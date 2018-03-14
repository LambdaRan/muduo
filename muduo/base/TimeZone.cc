#include <muduo/base/TimeZone.h>
#include <muduo/base/Date.h>

#include <algorithm>
#include <stdexcept>
#include <string>
#include <vector>

#include <assert.h>
//#define _BSD_SOURCE
#include <endian.h>

#include <stdint.h>
#include <stdio.h>
#include <strings.h>

namespace muduo
{
namespace detail
{
struct Transition 
{
    time_t gmtime;
    time_t localtime;
    int localtimeIdx;

    Transition(time_t t, time_t l, int localIdx)
        : gmtime(t), localtime(l), localtimeIdx(localIdx)
    {}

};  
struct Comp
{
    bool compareGmt;
    Comp(bool gmt)
        : compareGmt(gmt)
    {}

    bool operator()(const Transition& lhs, const Transition& rhs) const 
    {
        if (compareGmt)
            return lhs.gmtime < rhs.gmtime;
        else
            return lhs.localtime < rhs.localtime;
    }

    bool equal(const Transition& lhs, const Transition& rhs) const
    {
        if (compareGmt)
            return lhs.gmtime == rhs.gmtime;
        else 
            return lhs.localtime == rhs.localtime;
    }
};

struct Localtime 
{
    time_t gmtOffset;
    bool isDst;
    int arrbIdx;

    Localtime(time_t offset, bool dst, int arrb)
        : gmtOff(offset), isDst(dst), arrbIdx(arrb)
    {}
};

inline void fillHMS(unsigned seconds, struct tm* utc)
{
    utc->tm_sec = seconds % 60;
    unsigned minutes = seconds / 60;
    utc->tm_min = minutes % 60;
    utc->tm_hour = minutes / 60;
}

}// detail
const int kSecondsPerDay = 24*60*60;
}// muduo

using namespace muduo;
using namespace std;
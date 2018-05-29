
#include <muduo/base/Timestamp.h>

#include <sys/time.h> // gettimeofday
#include <stdio.h>

#ifndef __STD_FORMAT_MACROS
#define __STD_FORMAT_MACROS
#endif // !__STD_FORMAT_MACROS

#include <inttypes.h>

using namespace muduo;

static_assert(sizeof(Timestamp) == sizeof(int64_t),
                "Timestamp is same size as int64_t");

string Timestamp::toString() const 
{
    char buf[32] = {0};
    int64_t seconds = microSecondsSinceEpoch_ / kMicroSecondsPerSecond;
    int64_t microseconds = microSecondsSinceEpoch_ % kMicroSecondsPerSecond;
    snprintf(buf, sizeof(buf)-1, "%" PRId64 ".%06" PRId64 "", seconds, microseconds);
    return buf;
}

string Timestamp::toFormattedString(bool showMicroseconds) const 
{
    char buf[32] = {0};
    time_t seconds = static_cast<time_t>(microSecondsSinceEpoch_ / kMicroSecondsPerSecond);
    struct tm tm_time;
    // 函数将日历时间 seconds 转换为以协调世界时（UTC）表示的分解时间表示，存储在　tm_time
    gmtime_r(&seconds, &tm_time);

    if (showMicroseconds)
    {
        int microseconds = static_cast<int>(microSecondsSinceEpoch_ % kMicroSecondsPerSecond);
        snprintf(buf, sizeof(buf), "%4d%2d%2d %2d:%2d:%2d.%6d",
                tm_time.tm_year+1900, tm_time.tm_mon+1, tm_time.tm_mday,
                tm_time.tm_hour, tm_time.tm_min, tm_time.tm_sec, 
                microseconds);
    }
    else
    {
        snprintf(buf, sizeof(buf), "%4d%2d%2d %2d:%2d:%2d",
                tm_time.tm_year+1900, tm_time.tm_mon+1, tm_time.tm_mday,
                tm_time.tm_hour, tm_time.tm_min, tm_time.tm_sec);        
    }
    return buf;
}

Timestamp Timestamp::now()
{
    struct timeval tv;
    // https://linux.die.net/man/2/gettimeofday
    // int gettimeofday(struct timeval *tv, struct timezone *tz);
    gettimeofday(&tv, NULL);
    int64_t seconds = tv.tv_sec;
    return Timestamp(seconds * kMicroSecondsPerSecond + tv.tv_usec);
}
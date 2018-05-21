
#include <muduo/base/LogStream.h>

#include <algorithm>
#include <limits>
#include <type_traits>
#include <assert.h>
#include <string.h>
#include <stdint.h>
#include <stdio.h>

using namespace muduo;
using namespace muduo::detail;

#if defined(__clang__)
#pragma clang diagnostic ignored "-Wtautological-compare"
#else  
#pragma GCC diagnostic ignored "=Wtype-limits"
#endif

namespace muduo
{

namespace detail
{

const char digits[] = "9876543210123456789";



}
}
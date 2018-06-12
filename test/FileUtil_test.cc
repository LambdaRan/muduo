
#include <muduo/base/FileUtil.h>

#include <stdio.h>
#define __STDC_FORMAT_MACROS
#include <inttypes.h>

using namespace muduo;

int main()
{
    string result;
    int64_t size = 0;
    // int err = FileUtil::readFile("/proc/self", 1024, &result, &size);
    // printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    // err = FileUtil::readFile("/proc/self", 1024, &result, NULL);
    // printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    int err = FileUtil::readFile("/proc/self/cmdline", 1024, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    err = FileUtil::readFile("/dev/null", 1024, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    err = FileUtil::readFile("/dev/zero", 1024, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    err = FileUtil::readFile("/notexist", 1024, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    err = FileUtil::readFile("/dev/zero", 102400, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    err = FileUtil::readFile("/dev/zero", 102400, &result, NULL);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);

    err = FileUtil::readFile("/home/lambda/usrp", 1024, &result, &size);
    printf("%d %zd %" PRIu64 "\n", err, result.size(), size);
    printf("\ncontent:%s\n", result.c_str());
    return 0;
}

#ifndef MUDUO_BASE_LOGFILE_H
#define MUDUO_BASE_LOGFILE_H

#include <muduo/base/Mutex.h>
#include <muduo/base/Types.h>
#include <memory>

namespace muduo
{

namespace FileUtil
{
    class AppendFile;
}

// 日志的名字为：日志名+日期+时间+主机名+线程ID+.log

class LogFile : noncopyable
{
public:
    LogFile(const string& basename,
            off_t rollSize, 
            bool threadSafe = true,
            int flushInterval = 3, 
            int checkEveryN = 1024);
    
    ~LogFile();

    void append(const char* logline, int len);
    void flush();
    bool rollFile();

private: 
    void append_unlocked(const char* logline, int len);

    static string getLogFileName(const string& basename, time_t* now);

    const string basename_;
    const off_t rollSize_; //日志文件达到rolsize生成一个新文件
    const int flushInterval_; // 日志写入间隔,定期flush到磁盘
    const int checkEveryN_; // 每多少次flush一次

    int count_; //写入日志次数，配合checkEveryN_

    std::unique_ptr<MutexLock> mutex_;
    time_t startOfPeriod_;
    time_t lastRoll_;
    time_t lastFlush_;
    std::unique_ptr<FileUtil::AppendFile > file_;

    const static int kRollPerSeconds_ = 60*60*24; // 多少秒一次roll file
};

} // namespace muduo
#endif
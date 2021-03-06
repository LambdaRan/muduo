// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)

#include <muduo/base/Thread.h>
#include <muduo/base/CurrentThread.h>
#include <muduo/base/Exception.h>
#include <muduo/base/Logging.h>

#include <type_traits>

#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <linux/unistd.h>

namespace muduo 
{
namespace CurrentThread
{
    // __thread变量每一个线程有一份独立实体，各个线程的变量值互不干扰
    __thread int t_cachedTid = 0;
    __thread char t_tidString[32];
    __thread int t_tidStringLength = 6;
    __thread const char* t_threadName = "unknown";
    // std::is_same<，>::value 类型形同返回true
    static_assert(std::is_same<int, pid_t>::value, "pid_t should be int");
}

namespace detail
{
    // 单线程中 pid = tid
    // 多线程  pid为父进程的pid   tid为线程的真实pid
    pid_t gettid()
    {
        // 获取线程PID
        return static_cast<pid_t>(::syscall(SYS_gettid));
    }

    // 防止程序执行fork(2) 看到陈旧的缓存结果
    void afterFork()
    {
        muduo::CurrentThread::t_cachedTid = 0;
        muduo::CurrentThread::t_threadName = "main";
        CurrentThread::tid();
        // no need to call pthread_atfork(NULL, NULL, &afterFork);
    }

    class ThreadNameInitializer
    {
    public:
        ThreadNameInitializer()
        {
            muduo::CurrentThread::t_threadName = "main";
            CurrentThread::tid();
            pthread_atfork(NULL, NULL, &afterFork);
        }
    };

    ThreadNameInitializer init;

    struct ThreadData 
    {
        typedef muduo::Thread::ThreadFunc ThreadFunc;
        ThreadFunc func_;
        string name_;
        pid_t* tid_;
        CountDownLatch* latch_;

        ThreadData(ThreadFunc func,
                   const string& name,
                   pid_t* tid,
                   CountDownLatch* latch)
            : func_(std::move(func)),
              name_(name),
              tid_(tid),
              latch_(latch)
        {}

        void runThread()
        {
            *tid_ = muduo::CurrentThread::tid();
            tid_ = NULL;
            latch_->countDown();
            latch_ = NULL;

            muduo::CurrentThread::t_threadName = name_.empty() ? "muduoThread" : name_.c_str();
            // 设置进程的名字
            ::prctl(PR_SET_NAME, muduo::CurrentThread::t_threadName);

            try
            {
                func_();
                muduo::CurrentThread::t_threadName = "finished";
            }
            catch (const Exception& ex)
            {
                muduo::CurrentThread::t_threadName = "crashed";
                fprintf(stderr, "exception caugth in Thread %s\n", name_.c_str());
                fprintf(stderr, "reason: %s\n", ex.what());
                fprintf(stderr, "stack trace: %s\n", ex.stackTrace());
                abort();
            }
            catch (const std::exception& ex)
            {
                muduo::CurrentThread::t_threadName = "crashed";
                fprintf(stderr, "exception caugth in Thread %s\n", name_.c_str());
                fprintf(stderr, "reason: %s\n", ex.what());
                abort();                
            }
            catch (...)
            {
                muduo::CurrentThread::t_threadName = "crashed";
                fprintf(stderr, "exception caugth in Thread %s\n", name_.c_str());
                throw; //rethrow
            }
        }
    }; // struct ThreadData 

    void* startThread(void* obj)
    {
        ThreadData* data = static_cast<ThreadData*>(obj);
        data->runThread();
        delete data;
        return NULL;
    }

} // namespace detail

} // namespace muduo

using namespace muduo;

void CurrentThread::cachedTid()
{
    if (t_cachedTid == 0)
    {
        t_cachedTid = detail::gettid();
        t_tidStringLength = snprintf(t_tidString, sizeof(t_tidString), "%5d ", t_cachedTid);
    }
}

bool CurrentThread::isMainThread()
{
    // 主线程的pid 与 tid 相同
    return tid() == ::getpid();
}

void CurrentThread::sleepUsec(int64_t usec)
{
  struct timespec ts = { 0, 0 };
  ts.tv_sec = static_cast<time_t>(usec / Timestamp::kMicroSecondsPerSecond);
  ts.tv_nsec = static_cast<long>(usec % Timestamp::kMicroSecondsPerSecond * 1000);
  ::nanosleep(&ts, NULL);
}


/***************** Thread ********************/

AtomicInt32 Thread::numCreated_;

Thread::Thread(ThreadFunc func, const string& n)
    : started_(false),
      joined_(false),
      pthreadId_(0),
      tid_(0),
      func_(std::move(func)),
      name_(n),
      latch_(1)
{
    setDefaultName();
}
Thread::~Thread()
{
    if (started_ && !joined_)
    {
        // P318 分离线程
        pthread_detach(pthreadId_);
    }
}

void Thread::setDefaultName()
{ 
    int num = numCreated_.incrementAndGet();
    if (name_.empty())
    {
        char buf[32];
        snprintf(buf, sizeof buf, "Thread%d", num);
        name_ = buf;
    }
}

void Thread::start()
{
    assert(!started_);
    started_ = true;
    // FIXME: move(func_)
    detail::ThreadData* data = new detail::ThreadData(func_, name_, &tid_, &latch_);
    if (pthread_create(&pthreadId_, NULL, &detail::startThread, data))
    {
        started_ = false;
        delete data; // or no delete?
        LOG_SYSFATAL << "Failed in pthread_create";
    }
    else
    {
        latch_.wait();
        assert(tid_ > 0);
    }
}

int Thread::join()
{
    assert(started_);
    assert(!joined_);
    joined_ = true;
    return pthread_join(pthreadId_, NULL);
}
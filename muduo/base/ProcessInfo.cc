// Copyright 2010, Shuo Chen.  All rights reserved.
// http://code.google.com/p/muduo/
//
// Use of this source code is governed by a BSD-style license
// that can be found in the License file.

// Author: Shuo Chen (chenshuo at chenshuo dot com)
//

#include <muduo/base/ProcessInfo.h>
#include <muduo/base/CurrentThread.h>
#include <muduo/base/FileUtil.h>

#include <algorithm>

#include <assert.h>
#include <dirent.h>
#include <pwd.h>
#include <stdio.h> // snprintf
#include <stdlib.h>
#include <unistd.h>
#include <sys/resource.h>
#include <sys/times.h>

namespace muduo
{

namespace detial
{
// struct dirent
// {
//     long d_ino; /* inode number 索引节点号 */
//     off_t d_off; /* offset to this dirent 在目录文件中的偏移 */
//     unsigned short d_reclen; /* length of this d_name 文件名长 */
//     unsigned char d_type; /* the type of d_name 文件类型 */
//     char d_name [256]; /* file name (null-terminated) 文件名，最长256字符 */
// }
__thread int t_numOpenedFiles = 0;
// lambda@ran:/proc/self/fd$ ls
// 0  1  2  255
int fdDirFilter(const struct dirent* d)
{
    // d_name[] 文件名，最长255字符
    // 以数字命名的文件 
    if (::isdigit(d->d_name[0]))
    {
        ++t_numOpenedFiles;
    }
    return 0;
}
__thread std::vector<pid_t>* t_pids = NULL;
// lambda@ran:/proc/self/task$ ls
// 28660
int taskDirFilter(const struct dirent* d)
{
    if (::isdigit(d->d_name[0]))
    {
        t_pids->push_back(atoi(d->d_name));
    }
    return 0;
}

int scanDir(const char* dirpath, int (*filter)(const struct dirent*))
{
    struct dirent** namelist = NULL;
    int result = ::scandir(dirpath, &namelist, filter, alphasort);
    assert(namelist == NULL);
    return result;
}
Timestamp g_startTime = Timestamp::now();
// assume those won't change during the life time of a process.
int g_clockTicks = static_cast<int>(::sysconf(_SC_CLK_TCK));
int g_pageSize = static_cast<int>(::sysconf(_SC_PAGE_SIZE));
}// namespace detail
}// namespace muduo

using namespace muduo;
using namespace muduo::detial;

pid_t ProcessInfo::pid()
{
    return ::getpid();
}

string ProcessInfo::pidString()
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", pid());
    return buf;
}

uid_t ProcessInfo::uid()
{
    return ::getuid();
}
// /* The passwd structure.  */
// struct passwd
// {
//   char *pw_name;		/* Username.  */
//   char *pw_passwd;		/* Password.  */
//   __uid_t pw_uid;		/* User ID.  */
//   __gid_t pw_gid;		/* Group ID.  */
//   char *pw_gecos;		/* Real name.  */
//   char *pw_dir;			/* Home directory.  */
//   char *pw_shell;		/* Shell program.  */
// };
string ProcessInfo::username()
{
    struct passwd pwd;
    struct passwd* result = NULL;
    char buf[8092];//_SC_GETPW_R_SIZE_MAX 
    const char* name = "unknownuser";
    // 将查找结果存放在pwd中，result指针指向pwd
    // 结果以字符串形式存放在buf中
    getpwuid_r(uid(), &pwd, buf, sizeof(buf), &result);
    if (result)
    {
        name = pwd.pw_name;
    }
    return name;
}

uid_t ProcessInfo::euid()
{
    return ::geteuid();
}

Timestamp ProcessInfo::startTime()
{
    return g_startTime;
}
int ProcessInfo::clockTicksPerSecond()
{
    return g_clockTicks;
}

int ProcessInfo::pageSize()
{
    return g_pageSize;
}

bool ProcessInfo::isDebugBuild()
{
#ifdef NDEBUG
    return false;
#else
    return true;
#endif // DEBUG
}

// 主机名
string ProcessInfo::hostname()
{
    // HOST_NAME_MAX 64
    // _POSIX_HOST_NAME_MAX 255
    char buf[256];
    // P150 APUE
    if (::gethostname(buf, sizeof(buf)) == 0)
    {
        buf[sizeof(buf)-1] = '\0';
        return buf;
    }
    else  
    {
        return "unknownhost";
    }
}

string ProcessInfo::procname()
{
    return procname(procStat()).as_string();
}

StringPiece ProcessInfo::procname(const string& stat)
{
// lambda@ran:/proc/self$ cat stat
// 14556 (bash) S 14549 14556 14556 34817 15184 4194304 7656 15197 5 10 16 4 0 0 20 0 1 0 
    StringPiece name;
    size_t lp = stat.find('(');
    size_t rp = stat.find(')');
    if (lp != string::npos && rp != string::npos && lp < rp)
    {
        name.set(stat.data()+lp+1, static_cast<int>(rp-lp-1));
    }
    return name;
}
// /proc/self/status 进程当前状态，以可读的方式显示出来
// lambda@ran:~$ cat /proc/self/status 
// Name:	cat
// State:	R (running)
// Tgid:	14748
string ProcessInfo::procStatus()
{
    string result;
    FileUtil::readFile("/proc/self/status", 65536, &result);
    return result;
}
// /proc/self/stat 进程状态
// lambda@ran:/proc/self$ cat stat
// 14556 (bash) S 14549 14556 14556 34817 15184 4194304 7656 15197 5 10 16 4 0 0 20 0 1 0 
string ProcessInfo::procStat()
{
  string result;
  FileUtil::readFile("/proc/self/stat", 65536, &result);
  return result;
}

// lambda@ran:/proc/self/task/14556$ cat stat
// 14556 (bash) S 14549 14556 14556 34817 15027 4194304 6449 13761 5 10 14 3 0 0 20 0 1 0 
string ProcessInfo::threadStat()
{
    char buf[64];
    snprintf(buf, sizeof(buf), "/proc/self/task/%d/stat", CurrentThread::tid());
    string result;
    FileUtil::readFile(buf, 65536, &result);
    return result;
}
// 获取当前程序的绝对路径
string ProcessInfo::exePath()
{
    string result;
    char buf[1024];
    // P99
    ssize_t n = ::readlink("/proc/self/exe", buf, sizeof(buf));
    if (n > 0)
    {
        result.assign(buf, n);
    }
    return result;
}
int ProcessInfo::openedFiles()
{
    t_numOpenedFiles = 0;
    scanDir("/proc/self/fd", fdDirFilter);
    return t_numOpenedFiles;
}

int ProcessInfo::maxOpenFiles()
{
    // P175 每个进程能打开的文件数
    struct rlimit rl;
    if (::getrlimit(RLIMIT_NOFILE, &rl))
    {
        return openedFiles();
    }
    else  
    {
        return static_cast<int>(rl.rlim_cur);
    }
}
// /* Structure describing CPU time used by a process and its children.  */
// struct tms
// {
//     clock_t tms_utime;		/* User CPU time.  */
//     clock_t tms_stime;		/* System CPU time.  */

//     clock_t tms_cutime;		/* User CPU time of dead children.  */
//     clock_t tms_cstime;		/* System CPU time of dead children.  */
// };
ProcessInfo::CpuTime ProcessInfo::cpuTime()
{
    ProcessInfo::CpuTime t;
    struct tms tms;
    if (::times(&tms) >= 0)
    {
        const double hz = static_cast<double>(clockTicksPerSecond());
        t.userSeconds = static_cast<double>(tms.tms_utime) / hz;
        t.systemSeconds = static_cast<double>(tms.tms_stime) / hz;
    }
    return t;
}
// lambda@ran:~$ cat /proc/self/status 
// ...
// VmSwap:	       0 kB
// HugetlbPages:	       0 kB
// Threads:	1
// SigQ:	0/15472
// ... 
int ProcessInfo::numThreads()
{
    int result = 0;
    string status = procStatus();
    size_t pos = status.find("Threads:");
    if (pos != string::npos)
    {
        result = ::atoi(status.c_str() + pos + 8);
    }
    return result;
}
// /proc/self/task 当前进程有哪些线程
std::vector<pid_t> ProcessInfo::threads()
{
    std::vector<pid_t> result;
    t_pids = &result;
    scanDir("/proc/self/task", taskDirFilter);
    t_pids = NULL;
    std::sort(result.begin(), result.end());
    return result;
}
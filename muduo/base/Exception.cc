// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)


#include <muduo/base/Exception.h>

//#include <cxxabi.h>
#include <execinfo.h> // 声明了三个函数用于获取当前线程的函数调用堆栈
#include <stdlib.h>

using namespace muduo;

Exception::Exception(const char* msg)
    : message_(msg)
{
    fillStackTrace();
}

Exception::Exception(const string& msg)
    : message_(msg)
{
    fillStackTrace();
}

Exception::~Exception() throw() 
{}

// P690
// C++11使用noexcept说明指定某个函数不会抛出异常。
// void recoup(int) noexcept;
// 关键字 noexcept出现在该函数的所有声明语句和定义语句中，

// 函数后throw() 说明此函数将不会抛出异常
// 在C++11新版本中这种使用throw的异常说明方案被取消，而是使用noexcept说明
// 及一下两种形式等价：
// const char* Exception::what() const throw();
// const char* Exception::what() const noexcept;
const char* Exception::what() const throw()
{
    return message_.c_str();
}

const char* Exception::stackTrace() const throw()
{
    return stack_.c_str();
}

void Exception::fillStackTrace()
{
    const int len = 200;
    void* buffer[len];
    int nptrs = ::backtrace(buffer, len);
    char** strings = ::backtrace_symbols(buffer, len);
    if (strings)
    {
        for (int i = 0; i < nptrs; ++i)
        {
            // TODO demangle function name with abi::__cxa_demangle
            stack_.append(strings[i]);
            stack_.push_back('\n');
        }
        free(strings);
    }
}
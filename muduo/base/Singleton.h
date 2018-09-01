// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)

#ifndef MUDUO_BASE_SINGLETON_H
#define MUDUO_BASE_SINGLETON_H

#include <muduo/base/noncopyable.h>

#include <assert.h>
#include <pthread.h>
#include <stdlib.h> // atexit

namespace muduo
{

namespace detail
{
// 这不检测继承的成员函数！
// This doesn't detect inherited member functions!
// http://stackoverflow.com/questions/1966362/sfinae-to-check-for-inherited-member-functions
template <typename T>
struct has_no_destroy
{
    template <typename C> static char test(decltype(&C::no_destroy));
    template <typename C> static int32_t test(...);
    const static bool value = sizeof(test<T>(0)) == 1;
};
}// namespace detail
template <typename T>
class Singleton : noncopyable 
{
public: 
    static T& instance()
    {
        // 保证Singleton::init只调用一次
        pthread_once(&ponce_, &Singleton::init);
        assert(value_ != NULL);
        return *value_;
    }
private: 
    Singleton();
    ~Singleton();

    static void init()
    {
        value_ = new T();
        if (!detail::has_no_destroy<T>::value)
        {
            //P160 登记终止处理函数 exit()会调用这些函数
            // 每登记一次，就会被调用一次，顺序与登记时相反（栈。FILO）
            // int atexit(void (*func)(void));
            ::atexit(destroy);
        }
    }
    static void destroy()
    {
        typedef char T_must_be_complete_type[sizeof(T) == 0 ? -1 : 1];
        T_must_be_complete_type dummy; (void)dummy;

        delete value_;
        value_ = NULL;
    }
private: 
    //P359 必须是一个非本地变量（如全局变量或静态变量),而且必须初始化为PTHREAD_ONCE_INIT
    static pthread_once_t ponce_;
    static T* value_;
};
template<typename T>
pthread_once_t Singleton<T>::ponce_ = PTHREAD_ONCE_INIT;

template<typename T>
T* Singleton<T>::value_ = NULL;
} // namespace muduo

#endif // MUDUO_BASE_SINGLETON_H
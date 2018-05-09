// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)

#ifndef MUDUO_BASE_THREADLOCALSINGLETON_H
#define MUDUO_BASE_THREADLOCALSINGLETON_H

#include <muduo/base/noncopyable.h>

#include <assert.h>
#include <pthread.h>

namespace muduo 
{

template<typename T>
class ThreadLocalSingleton : noncopyable
{
public:  
    static T& instance()
    {
        if (!t_value_)
        {
            t_value_ = new T();
            deleter_.set(t_value_);
        }
        return *t_value_;
    }

    static T* pointer()
    {
        return t_value_;
    }

private: 
    ThreadLocalSingleton();
    ~ThreadLocalSingleton();

    static void destructor(void *obj)
    {
        assert(obj == t_value_);
        typedef char T_must_be_complete_type[sizeof(T) == 0 ? -1 : 1];
        T_must_be_complete_type dummy; (void)dummy;
        delete t_value_;
        t_value_ = 0;
    } 

    class Deleter 
    {
    public: 
        Deleter()
        {
            // APUE P358 为键关联一个析构函数，析构函数在线程退出时调用
            pthread_key_create(&pkey_, &ThreadLocalSingleton::destructor);
        }
        ~Deleter()
        {
            // 取消键与线程特定数据之间的关联关系，不会激活与键关联的析构函数
            pthread_key_delete(pkey_);
        }
        void set(T* newObj)
        {
            assert(pthread_getspecific(pkey_) == NULL);
            // 把键和线程特定数据关联起来
            pthread_setspecific(pkey_, newObj);
        }

        pthread_key_t pkey_;
    };
    // 类内静态成员的声明
    static __thread T* t_value_;
    static Deleter deleter_;
};

// 静态成员的定义与初始化
template<typename T> 
__thread T* ThreadLocalSingleton<T>::t_value_ = 0;

template<typename T>
typename ThreadLocalSingleton<T>::Deleter ThreadLocalSingleton<T>::deleter_;

}


#endif
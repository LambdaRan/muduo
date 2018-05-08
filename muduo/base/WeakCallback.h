// Copyright 2010, Shuo Chen.  All rights reserved.
// http://code.google.com/p/muduo/
//
// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)

#ifndef MUDUO_BASE_WEAKCALLBACK_H
#define MUDUO_BASE_WEAKCALLBACK_H

#include <memory>
#include <functional>

namespace muduo
{
// A barely usable WeakCallback
// __GXX_EXPERIMENTAL_CXX0X__ 用来判断C++版本
#ifdef __GXX_EXPERIMENTAL_CXX0X__

// 可变参数模板
// 模板参数包：表示零个或多个模板参数
// 函数参数包：表示零个或多个函数参数
// sizeof...运算符 求包中有几个参数

// class...或typename...指出接下来的参数表示零个或多个类型的列表
// ARGS：模板参数包
template<typename CLASS, typename... ARGS>
class WeakCallback 
{
public:  

    WeakCallback(const std::weak_ptr<CLASS>& object,
                 const std::function<void (CLASS*, ARGS...)>& function)
        : object_(object), function_(function)
    {}

    // default dtor, copy ctor and assignment are okay
    // 函数调用运算符必须是成员函数
    
    // ARGS是一个模板参数包；args是一个函数参数包
    // ARGS表示零个或多个模板类型参数
    // args表示零个或多个函数参数
    void operator()(ARGS&&... args) const
    {
        std::shared_ptr<CLASS> ptr(object_.lock());
        if (ptr)
        {
            // 包扩展 --》扩展元素的模式为：std::forward<>()
            // 转发参数包
            function_(ptr.get(), std::forward<ARGS>(args)...);
        }
        // else
        // {
        //   LOG_TRACE << "expired";
        // }
    }
private:  

    std::weak_ptr<CLASS> object_;
    std::function<void (CLASS*, ARGS...)> function_;
};
template<typename CLASS, typename... ARGS>
WeakCallback<CLASS, ARGS...> makeWeakCallback(const std::shared_ptr<CLASS>& object,
                                              void (CLASS::*function)(ARGS...))
{
    return WeakCallback<CLASS, ARGS...>(object, function);
}
template<typename CLASS, typename... ARGS>
WeakCallback<CLASS, ARGS...> makeWeakCallback(const std::shared_ptr<CLASS>& object,
                                              void (CLASS::*function)(ARGS...) const)
{
  return WeakCallback<CLASS, ARGS...>(object, function);
}

#else // __GXX_EXPERIMENTAL_CXX0X__

// the C++98/03 version doesn't support arguments.
template<typename CLASS>
class WeakCallback
{
public:  

    WeakCallback(const std::shared_ptr<CLASS>& object
                 const std::function<void (CLASS*)>& function)
        :object_(object), function_(function)
    {}

    // Default dtor, copy ctor and assignment are okay

    void operator()() const 
    {
        std::shared_ptr<CLASS> ptr(object_.lock());
        if (ptr)
        {
            function_(ptr.get());
        }
        // else
        // {
        //   LOG_TRACE << "expired";
        // }
    }
private: 

    std::weak_ptr<CLASS> object_;
    std::function<void (CLASS*)> function_;
};
template<typename CLASS>
WeakCallback<CLASS> makeWeakCallback(const std::shared_ptr<CLASS>& object,
                                     void (CLASS::*function)())
{
  return WeakCallback<CLASS>(object, function);
}

template<typename CLASS>
WeakCallback<CLASS> makeWeakCallback(const std::shared_ptr<CLASS>& object,
                                     void (CLASS::*function)() const)
{
  return WeakCallback<CLASS>(object, function);
}

#endif // __GXX_EXPERIMENTAL_CXX0X__
}

#endif
#ifndef MUDUO_BASE_NONCOPYABLE_H
#define MUDUO_BASE_NONCOPYABLE_H

namespace muduo 
{
// 将拷贝构造函数与拷贝赋值运算符声明位私有，禁止类的拷贝动作
class noncopyable 
{
protected: 
    noncopyable() = default;
    ~noncopyable() = default;
private: 
    noncopyable(const noncopyable&) = delete;
    void operator=(const noncopyable&) = delete;
};

}

#endif // !MUDUO_BASE_NONCOPYABLE_H
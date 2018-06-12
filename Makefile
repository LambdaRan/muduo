#显示所有警告
CXXFLAGS += -Wall -Wextra -Werror -Wconversion -Wshadow -std=c++11
CXXFLAGS += -g
#CXXFLAGS +=    -Wfatal-errors
#-std=c++0x
#CFLAG += -O #基本优化
# -g选项，产生供gdb调试用的可执行文件
CC = g++

PROJECT = main
SYSLIB = -lpthread -lz

ROOTDIR = $(shell pwd)
OBJDIR = .
#SRCS = $(wildcard ./*.c)
SRCDIR = $(ROOTDIR)/muduo/base

#GzipFile
SRCS = $(ROOTDIR)/test/GzipFile_test.cc \
		$(SRCDIR)/Thread.cc \
		$(SRCDIR)/Condition.cc \
		$(SRCDIR)/Exception.cc \
		$(SRCDIR)/CountDownLatch.cc \
		$(SRCDIR)/Logging.cc \
		$(SRCDIR)/Timestamp.cc \
		$(SRCDIR)/LogStream.cc \
		$(SRCDIR)/TimeZone.cc \
		$(SRCDIR)/Date.cc

#BoundedBlockingQueue
# SRCS = $(ROOTDIR)/test/BoundedBlockingQueue_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#BlockingQueue_bench
# SRCS = $(ROOTDIR)/test/BlockingQueue_bench.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#BlockingQueue
# SRCS = $(ROOTDIR)/test/BlockingQueue_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#FileUtil
# SRCS = $(ROOTDIR)/test/FileUtil_test.cc \
# 		$(SRCDIR)/FileUtil.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#Exception
# SRCS = $(ROOTDIR)/test/Exception_test.cc \
# 		$(SRCDIR)/Exception.cc

#Fork
# SRCS = $(ROOTDIR)/test/Fork_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#SingletonThreadLocal
# SRCS = $(ROOTDIR)/test/SingletonThreadLocal_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc

#Singleton
# SRCS = $(ROOTDIR)/test/Singleton_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

#ThreadLocalSingleton
# SRCS = $(ROOTDIR)/test/ThreadLocalSingleton_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

#ThreadLocal
# SRCS = $(ROOTDIR)/test/ThreadLocal_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

#ThreadPool
# SRCS = $(ROOTDIR)/test/ThreadPool_test.cc \
# 		$(SRCDIR)/ThreadPool.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

# Mutex_test
# SRCS = $(ROOTDIR)/test/Mutex_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

# Thread_bench
# SRCS = $(ROOTDIR)/test/Thread_bench.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

#thread_test
# SRCS = $(ROOTDIR)/test/Thread_test.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

#processInfo
# SRCS = $(ROOTDIR)/test/ProcessInfo_test.cc \
# 		$(SRCDIR)/ProcessInfo.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/FileUtil.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Exception.cc

# Date
# SRCS = $(ROOTDIR)/test/Date_unittest.cc \
# 		$(SRCDIR)/Date.cc

 #指定头文件目录，代码中就不需要把头文
INCLUDE_DIRS = -I. \
			   -I$(SRCDIR) 
OBJS = $(patsubst %.cc,%.o,$(SRCS))

$(PROJECT):$(OBJS)
	$(CC) -o $@ $^ $(CXXFLAGS) $(INCLUDE_DIRS) $(SYSLIB)
#	mv $(OBJS_BASE) $(OBJDIR)                         
$(OBJS):%.o:%.cc
	$(CC) -c $(CXXFLAGS) $(INCLUDE_DIRS) $< -o $@ 

test:test.cpp
	$(CC) $(CXXFLAGS) test.cpp -o main	
.PHONY: clean
clean:
	rm -f $(OBJDIR)/*.o  $(SRCDIR)/*.o $(ROOTDIR)/test/*.o $(OBJDIR)/$(PROJECT)


# SRC = test.cpp 
# SRC += Rational_1.cpp
# SRC += MemoryPool.cpp

# main:$(SRC) 
# 	$(CC) $(CFLAG)  $(SRC) -o main
# test:test.cpp
# 	$(CC) $(CFLAG)  test.cpp -o main	
# .PHONY:clean
# clean:
# 	rm -f *.o main


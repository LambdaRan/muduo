#显示所有警告
CXXFLAGS += -Wall -Wextra -Werror -Wconversion -Wshadow -std=c++11
#CXXFLAGS +=    -Wfatal-errors
#-std=c++0x
#CFLAG += -O #基本优化
# -g选项，产生供gdb调试用的可执行文件
CC = g++

PROJECT = main
SYSLIB = -lpthread

ROOTDIR = $(shell pwd)
OBJDIR = .
#SRCS = $(wildcard ./*.c)
SRCDIR = $(ROOTDIR)/muduo/base

# Mutex_test
SRCS = $(ROOTDIR)/test/Mutex_test.cc \
		$(SRCDIR)/Thread.cc \
		$(SRCDIR)/CountDownLatch.cc \
		$(SRCDIR)/Timestamp.cc \
		$(SRCDIR)/Condition.cc \
		$(SRCDIR)/Exception.cc \
		$(SRCDIR)/Logging.cc \
		$(SRCDIR)/LogStream.cc \
		$(SRCDIR)/TimeZone.cc \
		$(SRCDIR)/Date.cc 


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


#显示所有警告
CXXFLAGS += -Wall -Wextra -std=c++11
#CXXFLAGS +=  -Werror -Wfatal-errors
#-std=c++0x
#CFLAG += -O #基本优化
# -g选项，产生供gdb调试用的可执行文件
CC = g++

PROJECT = main
SYSLIB = 

ROOTDIR = $(shell pwd)
OBJDIR = .
#SRCS = $(wildcard ./*.c)
SRCDIR = $(ROOTDIR)/muduo/base
SRCS = $(ROOTDIR)/test/Atomic_unittest.cc


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

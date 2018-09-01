
CC = g++

PROJECT = main
#TARGETS = echoclient echoserver
#SYSLIB += -lpthread -lz -lunit_test
SYSLIB = -lpthread
ROOTDIR = $(shell pwd)
OBJDIR = .
#SRCS = $(wildcard ./*.c)

#显示所有警告
CXXFLAGS += -Wall -Wextra -Werror -Wconversion -Wshadow -std=c++11
CXXFLAGS += -g
#CXXFLAGS +=    -Wfatal-errors
#-std=c++0x
#CFLAG += -O #基本优化
# -g选项，产生供gdb调试用的可执行文件

#CPPFLAGS += -isystem $(ROOTDIR)/muduo

SRCDIRBASE = $(ROOTDIR)/muduo/base
SRCDIRNET = $(ROOTDIR)/muduo/net

SRCS = $(SRCDIRNET)/TcpConnection.cc \
		$(SRCDIRNET)/TimerQueue.cc \
		$(SRCDIRNET)/EventLoopThread.cc \
		$(SRCDIRNET)/Channel.cc \
		$(SRCDIRNET)/EventLoop.cc \
		$(SRCDIRNET)/Socket.cc \
		$(SRCDIRNET)/InetAddress.cc \
		$(SRCDIRNET)/SocketsOps.cc \
		$(SRCDIRNET)/Poller.cc \
		$(SRCDIRNET)/poller/DefaultPoller.cc \
		$(SRCDIRNET)/poller/PollPoller.cc \
		$(SRCDIRNET)/poller/EPollPoller.cc \
		$(SRCDIRNET)/Timer.cc \
		$(SRCDIRNET)/Buffer.cc \
		$(SRCDIRBASE)/Logging.cc \
		$(SRCDIRBASE)/Timestamp.cc \
		$(SRCDIRBASE)/LogStream.cc \
		$(SRCDIRBASE)/TimeZone.cc \
		$(SRCDIRBASE)/Date.cc \
		$(SRCDIRBASE)/Thread.cc \
		$(SRCDIRBASE)/CountDownLatch.cc \
		$(SRCDIRBASE)/Exception.cc \
		$(SRCDIRBASE)/Condition.cc 

#EchoClient
ECHOCLIENTSRCS = $(ROOTDIR)/test_net/EchoClient_unittest.cc \
				 $(SRCDIRNET)/TcpClient.cc \
				 $(SRCDIRNET)/Connector.cc	

#EchoServer
ECHOSERVERSRCS = $(ROOTDIR)/test_net/EchoServer_unittest.cc \
				 $(SRCDIRNET)/TcpServer.cc \
				 $(SRCDIRNET)/Acceptor.cc \
				 $(SRCDIRNET)/EventLoopThreadPool.cc 

#TcpClient
# SRCS = $(ROOTDIR)/test_net/TcpClient_reg3.cc \
# 		$(SRCDIRNET)/TcpClient.cc \
# 		$(SRCDIRNET)/TcpConnection.cc \
# 		$(SRCDIRNET)/Connector.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/Socket.cc \
# 		$(SRCDIRNET)/InetAddress.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRNET)/Buffer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 


# #TcpClient
# SRCS = $(ROOTDIR)/test_net/TcpClient_reg2.cc \
# 		$(SRCDIRNET)/TcpClient.cc \
# 		$(SRCDIRNET)/TcpConnection.cc \
# 		$(SRCDIRNET)/Connector.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/Socket.cc \
# 		$(SRCDIRNET)/InetAddress.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRNET)/Buffer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

# #TcpClient
# SRCS = $(ROOTDIR)/test_net/TcpClient_reg1.cc \
# 		$(SRCDIRNET)/TcpClient.cc \
# 		$(SRCDIRNET)/TcpConnection.cc \
# 		$(SRCDIRNET)/Connector.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/Socket.cc \
# 		$(SRCDIRNET)/InetAddress.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRNET)/Buffer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

#TimerQueue
# SRCS = $(ROOTDIR)/test_net/TimerQueue_unittest.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

#EventLoopThreadPool
# SRCS = $(ROOTDIR)/test_net/EventLoopThreadPool_unittest.cc \
# 		$(SRCDIRNET)/EventLoopThreadPool.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc

#EventLoopThread
# SRCS = $(ROOTDIR)/test_net/EventLoopThread_unittest.cc \
# 		$(SRCDIRNET)/EventLoopThread.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 


#InetAdderss
# SRCS = $(ROOTDIR)/test_net/InetAddress_unittest.cc \
# 		$(SRCDIRNET)/InetAddress.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

#EventLoop
# SRCS = $(ROOTDIR)/test_net/EventLoop_unittest.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

# Channel
# SRCS = $(ROOTDIR)/test_net/Channel_test.cc \
# 		$(SRCDIRNET)/Channel.cc \
# 		$(SRCDIRNET)/EventLoop.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRNET)/Poller.cc \
# 		$(SRCDIRNET)/poller/DefaultPoller.cc \
# 		$(SRCDIRNET)/poller/PollPoller.cc \
# 		$(SRCDIRNET)/poller/EPollPoller.cc \
# 		$(SRCDIRNET)/TimerQueue.cc \
# 		$(SRCDIRNET)/Timer.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

#Buffer
# SRCS = $(ROOTDIR)/test_net/Buffer_unittest.cc \
# 		$(SRCDIRNET)/Buffer.cc \
# 		$(SRCDIRNET)/SocketsOps.cc \
# 		$(SRCDIRBASE)/Logging.cc \
# 		$(SRCDIRBASE)/Timestamp.cc \
# 		$(SRCDIRBASE)/LogStream.cc \
# 		$(SRCDIRBASE)/TimeZone.cc \
# 		$(SRCDIRBASE)/Date.cc \
# 		$(SRCDIRBASE)/Thread.cc \
# 		$(SRCDIRBASE)/CountDownLatch.cc \
# 		$(SRCDIRBASE)/Exception.cc \
# 		$(SRCDIRBASE)/Condition.cc 

# 		$(SRCDIR)/Thread.cc \
# 		$(SRCDIR)/CountDownLatch.cc \
# 		$(SRCDIR)/Exception.cc \
# 		$(SRCDIR)/Logging.cc \
# 		$(SRCDIR)/Condition.cc \
# 		$(SRCDIR)/LogStream.cc \
# 		$(SRCDIR)/Timestamp.cc \
# 		$(SRCDIR)/TimeZone.cc \
# 		$(SRCDIR)/Date.cc 

 #指定头文件目录，代码中就不需要把头文
INCLUDE_DIRS = -I. \
			   -I$(SRCDIRBASE) \
			   -I$(SRCDIRNET)
# PROJECT_HEADERS = $(SRCDIRBASE)/*.h \
# 				  $(SRCDIRNET)/*.h	
OBJS = $(patsubst %.cc,%.o,$(SRCS))
ECHOCLIENT_OBJS = $(patsubst %.cc,%.o,$(ECHOCLIENTSRCS))
ECHOSERVER_OBJS = $(patsubst %.cc,%.o,$(ECHOSERVERSRCS))


# $(PROJECT):$(OBJS)
# 	$(CC) -o $@ $^ $(CXXFLAGS) $(INCLUDE_DIRS) $(SYSLIB)
#	mv $(OBJS_BASE) $(OBJDIR)  

all : echoserver echoclient
.PHONY : all

echoserver: $(ECHOSERVER_OBJS) $(OBJS)
	$(CC) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@ $(SYSLIB)

echoclient: $(ECHOCLIENT_OBJS)
	$(CC) $(CPPFLAGS) $(CXXFLAGS) $(OBJS) $^ -o $@ $(SYSLIB)
                       
$(OBJS):%.o:%.cc
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(INCLUDE_DIRS) $< -o $@ 

$(ECHOCLIENT_OBJS):%.o:%.cc 
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(INCLUDE_DIRS) $< -o $@ 
$(ECHOSERVER_OBJS):%.o:%.cc
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(INCLUDE_DIRS) $< -o $@ 

test:test.cpp
	$(CC) $(CXXFLAGS) test.cpp -o main	

.PHONY: clean cleanBase cleanNet cleanEcho
clean: cleanBase cleanNet cleanEcho
	rm -f $(OBJDIR)/*.o  $(SRCDIR)/*.o $(SRCDIRBASE)/*.o $(SRCDIRNET)/*.o $(OBJDIR)/$(PROJECT)
cleanBase:
	rm -f $(ROOTDIR)/test_base/*.o 
cleanNet:
	rm -f $(ROOTDIR)/test_net/*.o 
cleanEcho:
	rm -f $(OBJDIR)/echoclient $(OBJDIR)/echoserver

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


# 指定编译器
CXX = g++
# 编译选项，启用C++11标准并打开优化
CXXFLAGS = -std=c++11 -O2 -Wall

# 输出的可执行文件名称
TARGET = test

# 源文件和目标文件
SRCS = test.cpp
OBJS = $(SRCS:.cpp=.o)

# 默认目标
all: $(TARGET)

# 链接目标文件生成可执行文件
$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET)

# 编译每个 .cpp 文件为 .o 文件
.cpp.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 清理目标文件
clean:
	rm -f $(OBJS) $(TARGET)

# 伪目标，避免与文件名冲突
.PHONY: all clean

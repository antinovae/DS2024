# Makefile for compiling test_BST.cpp, generating report from report.tex

# Compiler and flags for C++ code
CXX = g++
CXXFLAGS = -Wall -std=c++11 -g

# LaTeX compiler and flags
TEX = pdflatex
TEXFLAGS = -interaction=nonstopmode

# Targets
TARGET = test_BST
SRC = test_BST.cpp binary_search_tree.cpp
REPORT = report.tex

# Object files
OBJ = test_BST.o binary_search_tree.o

# Build the main target (C++ program)
all: $(TARGET) report.pdf

# Compile C++ source files
$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJ)

# Compile individual object files
test_BST.o: test_BST.cpp BST.h
	$(CXX) $(CXXFLAGS) -c test_BST.cpp

# Generate PDF report from LaTeX
report.pdf: $(REPORT)
	$(TEX) $(TEXFLAGS) $(REPORT)
	$(TEX) $(TEXFLAGS) $(REPORT) # Run pdflatex twice for proper references

# Run the compiled test program
run: $(TARGET)
	./$(TARGET)

# Clean up generated files
clean:
	rm -f $(TARGET) $(OBJ) *.aux *.log *.pdf

# Debug version of the C++ program
debug: CXXFLAGS += -g
debug: $(TARGET)


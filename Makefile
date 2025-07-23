# Makefile for CUDA Audio Spectrum Analyzer (Linux Version)

# Define the compilers. These are standard on Colab's Linux environment.
CXX = g++
NVCC = nvcc

# Define the name of the final executable.
EXECUTABLE = audio_analyzer

# Define compiler flags.
CXXFLAGS = -std=c++17
NVCCFLAGS = -std=c++17

# Define the libraries to link against.
# These will be available after we install libsndfile.
LIBS = -lsndfile -lcufft

# The default target, 'all', depends on the executable.
all: $(EXECUTABLE)

# Rule to link the final executable from the compiled object files.
$(EXECUTABLE): main.o kernel.o
	$(NVCC) $(NVCCFLAGS) -o $(EXECUTABLE) main.o kernel.o $(LIBS)

# Rule to compile the C++ source file into an object file.
main.o: main.cpp kernel.h
	$(CXX) $(CXXFLAGS) -c main.cpp

# Rule to compile the CUDA source file into an object file.
kernel.o: kernel.cu kernel.h
	$(NVCC) $(NVCCFLAGS) -c kernel.cu

# Rule to clean up compiled files.
# 'rm -f' is the correct command for deleting files on Linux.
clean:
	rm -f *.o $(EXECUTABLE) output_data/*.csv

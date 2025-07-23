# Makefile for CUDA Audio Spectrum Analyzer (Windows Version)

# --- IMPORTANT: USER CONFIGURATION ---
# 1. Path to libsndfile library
# NOTE: Do NOT put quotes around the path here.
SNDFILE_PATH = C:/dev/libsndfile-1.2.2-win64

# 2. Full path to the g++ compiler executable.
# This is the correct path you found.
GXX_PATH = C:/ProgramData/mingw64/mingw64/bin/g++.exe
# --- END USER CONFIGURATION ---


# Define the compilers
# We will now use NVCC for all compilation to ensure consistency.
NVCC = nvcc

# Define the name of the final executable
EXECUTABLE = audio_analyzer.exe

# Define compiler flags
# -std=c++17 enables modern C++ features
# -I tells the compiler where to find header files (.h)
# -ccbin tells nvcc which host compiler to use, now with a full path.
# -Xcompiler -D_WIN32 forces the host compiler to define the Windows macro, fixing the "unsupported OS" error.
NVCCFLAGS = -std=c++17 -I"$(SNDFILE_PATH)/include" -ccbin "$(GXX_PATH)" -Xcompiler -D_WIN32

# Define the libraries to link against
# -L tells the linker where to find library files (.lib, .a)
# -lsndfile for reading audio files
# -lcufft for the CUDA FFT library
LIBS = -L"$(SNDFILE_PATH)/lib" -lsndfile -lcufft

# The default target, 'all', depends on the executable.
all: $(EXECUTABLE)

# Rule to link the final executable from the compiled object files.
$(EXECUTABLE): main.o kernel.o
	$(NVCC) $(NVCCFLAGS) -o $(EXECUTABLE) main.o kernel.o $(LIBS)

# Rule to compile the C++ source file into an object file.
# We now use $(NVCC) here instead of g++ to avoid compiler conflicts.
main.o: main.cpp kernel.h
	$(NVCC) $(NVCCFLAGS) -c main.cpp

# Rule to compile the CUDA source file into an object file.
kernel.o: kernel.cu kernel.h
	$(NVCC) $(NVCCFLAGS) -c kernel.cu

# Rule to clean up compiled files.
# 'del' is the Windows command for deleting files.
# This replaces the 'rm -f' command used on Linux/macOS.
clean:
	del /F /Q *.o $(EXECUTABLE) 2>nul || (echo No files to clean)


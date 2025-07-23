# GPU-accelerated-audio-analyzer.

---

## Overview
This project demonstrates GPU-accelerated Fast Fourier Transform (FFT) processing on a set of audio files. It leverages NVIDIA CUDA for parallel computation, the FFTW library for highly optimized FFTs, and libsndfile for efficient audio input/output. The core objective is to utilize GPU acceleration to compute FFTs on .wav audio files and save the resulting magnitude spectrum data as .csv files.

This project was developed as part of the "CUDA at Scale for the Enterprise" module, showcasing a practical application of GPU computing for scalable signal processing using modern C++ and parallel programming techniques.

---

## Project Structure

```
GPU-accelerated-audio-analyzer/
├── input_data/            # Contains input .wav audio files
├── output_data/           # Contains output .csv files with FFT magnitude results
├── main.cpp               # Main C++ program performing audio FFT processing
├── generate_audio.py      # Python script to generate synthetic input audio files
├── kernel.h               # Header file for CUDA kernel declarations
├── kernel.cu              # CUDA kernel implementation for GPU-acceleraccelerated FFT
├── Makefile               # Build automation for compiling and cleaning the C++ project
├── run.sh                 # Shell script for simplified build and run operations 
├── README.md              # Project documentation (this file)
```

---

## Key Concepts
- GPU-Accelerated FFT: Utilizing CUDA to offload computationally intensive FFT operations to the GPU for significant speedup.
- Audio I/O: Efficient reading and writing of .wav audio files using libsndfile.
- FFTW Integration: Leveraging the highly optimized FFTW library for robust Fourier transforms
- Batch Processing: Designed to efficiently process multiple audio files in a single execution
- Build Automation: Streamlined compilation and execution using Makefile and run.sh
- Synthetic Audio Generation: Programmatic creation of test audio data using Python

---

## Requirements

- NVIDIA GPU with CUDA support (T4, A100, etc.)  
- CUDA Toolkit installed  
- FFTW library installed  
- libsndfile library installed  
- Python 3.7+ (for generating input audio files)  
- CuPy, NumPy, SciPy Python packages (for audio generation)
- Google Colab envrionment

---

## Installation and Setup (as performed in Google Colab)

This section details the exact steps to set up the environment and dependencies, specifically as performed within your Google Colab notebook.

1.  **Clone the Repository:** Start by cloning your GitHub repository into the Colab environment.
    ```bash
    !git clone [https://github.com/edgecase7/GPU-accelerated-audio-analyzer.git](https://github.com/edgecase7/GPU-accelerated-audio-analyzer.git)
    ```
    

2.  **Install System Packages:** Install required C/C++ libraries for `libsndfile` and `FFTW`.
    ```bash
    !apt-get update
    !apt-get install -y libfftw3-dev libsndfile1-dev
    ```

3.  **Navigate to Project Directory:** Change to your project's root directory after cloning.
    ```bash
    %cd GPU-accelerated-audio-analyzer
    ```

4.  **Install Python Dependencies and Generate Input Audio Files:** Install Python packages needed for `generate_audio.py` and then run the script to create synthetic `.wav` files.
    ```bash
    !pip install numpy scipy
    !python generate_audio.py
    ```
    This will populate the `input_data/` directory with test audio files (e.g., 100 `.wav` files).

---
## How to Run the Project

### 1. Build the C++ Project

Compile the C++ source code using the provided `Makefile`:

```bash
!make
```

This command compiles main.cpp and kernel.cu, then links them to generate the executable named audio_analyzer.

### Run the FFT Processing
Execute the compiled binary to process all .wav files found in input_data/ and save the FFT results to output_data/:

```bash
!./audio_analyzer
```

Alternatively, use the  script:

```bash
./run.sh
```

##Output
-  The program processes each .wav file from the input_data/ directory.
-  For each input audio file, a corresponding .csv file containing the FFT magnitude spectrum is generated.
-  Output files are saved in the output_data/ directory, typically with filenames like fft_tone_1.csv.
-  execution processed 100 audio files, resulting in 100 .csv output files
---
## Makefile Commands

- `make` — compile the C++ project  
- `make clean` — remove executables and output CSV files

---

## Supported Environments

- OS: Linux, Windows (with compatible CUDA setup)  
- GPU: NVIDIA GPUs with CUDA 11.x or later  
- Compiler: g++ with C++11 support or higher

---

## How FFT is Performed

The steps in `main.cpp` are:
1.  Read Audio Data: Reads .wav audio files from input_data/ using libsndfile.
2.  Converts stereo audio to mono if necessary, preparing it for FFT.
3.  Transfers the audio data from host (CPU) memory to device (GPU) memory.
4.  Executes the Fast Fourier Transform on the GPU using CUDA-accelerated FFTW routines (specifically cuFFT as indicated by your make output).
5.  Computes the magnitude spectrum from the complex FFT results.
6.  Writes the calculated FFT magnitude data to .csv files on disk within the output_data/ directory.

---

## Credits

Developed by Pradyut Kumar Mishra as part of the CUDA at Scale Enterprise course. This project serves as a demonstration of efficient GPU-based FFT processing of audio data utilizing modern C++ and CUDA.
---

## License

This project is intended for educational purposes and does not currently include an open-source license.

---


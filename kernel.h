// kernel.h
#ifndef KERNEL_H
#define KERNEL_H

// This is the function main.cpp will call.
// It acts as a "wrapper" for all the CUDA operations.
void perform_fft_on_gpu(double* audio_data, int num_samples, const char* output_filename);

#endif
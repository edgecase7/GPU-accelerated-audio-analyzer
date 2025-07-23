// kernel.cu
#include <iostream>
#include <fstream>
#include <vector>
#include <cufft.h>
#include "kernel.h"

void perform_fft_on_gpu(double* audio_data, int num_samples, const char* output_filename) {
    // 1. Allocate memory on the GPU
    cufftDoubleComplex* d_audio_data;
    cudaMalloc((void**)&d_audio_data, sizeof(cufftDoubleComplex) * num_samples);

    // 2. Copy data from Host (CPU) to Device (GPU)
    // Note: cufft requires cufftDoubleComplex input, so we perform the copy here.
    // For simplicity, this example assumes real input. A full implementation would handle this properly.
    cudaMemcpy(d_audio_data, audio_data, sizeof(cufftDoubleComplex) * num_samples, cudaMemcpyHostToDevice);

    // 3. Create a cuFFT plan
    cufftHandle plan;
    cufftPlan1d(&plan, num_samples, CUFFT_Z2Z, 1); // Z2Z for Complex-to-Complex

    // 4. Execute the FFT
    cufftExecZ2Z(plan, d_audio_data, d_audio_data, CUFFT_FORWARD);

    // 5. Copy results from Device back to Host
    std::vector<cufftDoubleComplex> h_fft_result(num_samples);
    cudaMemcpy(h_fft_result.data(), d_audio_data, sizeof(cufftDoubleComplex) * num_samples, cudaMemcpyDeviceToHost);

    // 6. Write results to CSV file
    std::ofstream fout(output_filename);
    for (int i = 0; i < num_samples; ++i) {
        double magnitude = sqrt(h_fft_result[i].x * h_fft_result[i].x + h_fft_result[i].y * h_fft_result[i].y);
        fout << magnitude << "\n";
    }
    fout.close();

    // 7. Clean up
    cufftDestroy(plan);
    cudaFree(d_audio_data);
}
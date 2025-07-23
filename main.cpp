// main.cpp
#include <iostream>
#include <filesystem>
#include <vector>
#include <sndfile.h>
#include "kernel.h" // Include your kernel header

namespace fs = std::filesystem;

int main() {
    const std::string input_dir = "input_data";
    const std::string output_dir = "output_data";
    fs::create_directory(output_dir);

    for (const auto& entry : fs::directory_iterator(input_dir)) {
        if (entry.path().extension() == ".wav") {
            std::cout << "Processing: " << entry.path().filename() << std::endl;

            // Use libsndfile to read .wav file
            SF_INFO sfinfo;
            SNDFILE* infile = sf_open(entry.path().string().c_str(), SFM_READ, &sfinfo);
            if (!infile) continue;

            std::vector<double> buffer(sfinfo.frames);
            sf_read_double(infile, buffer.data(), sfinfo.frames);
            sf_close(infile);

            // Prepare output filename
            std::string out_filename = output_dir + "/fft_" + entry.path().stem().string() + ".csv";

            // Call the CUDA wrapper function
            perform_fft_on_gpu(buffer.data(), sfinfo.frames, out_filename.c_str());
        }
    }
    std::cout << "Processing complete." << std::endl;
    return 0;
}
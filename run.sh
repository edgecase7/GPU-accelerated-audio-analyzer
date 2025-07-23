#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Build the Project ---
echo "Building the project..."
make clean
make

# --- Generate Input Data ---
# Check if the input_data directory exists. If not, generate the files.
if [ ! -d "input_data" ] || [ ! "$(ls -A input_data)" ]; then
    echo "Input data not found. Generating audio files..."
    pip install numpy scipy
    python generate_audio.py
else
    echo "Input data already exists. Skipping generation."
fi

# --- Run the Analyzer ---
echo "Running the audio analyzer..."
./audio_analyzer

# --- Final Report ---
echo "Processing complete. Check the 'output_data' directory for results."
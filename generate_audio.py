# input_generator.py
import numpy as np
from scipy.io.wavfile import write
import os
import shutil

# --- Settings ---
# The directory where the generated audio files will be saved.
output_dir = "input_data"
# The sample rate of the audio files in Hz. 44100 is standard for CD-quality audio.
sample_rate = 44100
# The duration of each audio file in seconds.
duration = 1.0
# The number of audio files to generate.
num_files = 100

# --- Main Script ---

# Remove the old input_data folder if it exists to ensure a clean start.
if os.path.exists(output_dir):
    shutil.rmtree(output_dir)
    print(f"Removed existing directory: {output_dir}")

# Recreate the directory.
os.makedirs(output_dir)
print(f"Created directory: {output_dir}")


# Loop to generate the specified number of .wav files.
for i in range(num_files):
    # Generate a different frequency for each file to make them unique.
    # This starts at 220 Hz (A3) and increases for each file.
    frequency = 220 * (i + 1)
    
    # Create a time array from 0 to the duration.
    t = np.linspace(0., duration, int(sample_rate * duration), endpoint=False)
    
    # Set the amplitude for the sine wave. We use half the max value for a 16-bit integer.
    amplitude = np.iinfo(np.int16).max * 0.5
    
    # Generate the actual audio data as a sine wave.
    data = amplitude * np.sin(2. * np.pi * frequency * t)
    
    # Construct the full filename.
    filename = os.path.join(output_dir, f"tone_{i+1}.wav")
    
    # Write the audio data to a .wav file.
    # The data must be converted to 16-bit integers, which is a standard format.
    write(filename, sample_rate, data.astype(np.int16))
    
    print(f"Generated {filename} with frequency {frequency} Hz")

print("\nAudio file generation complete.")

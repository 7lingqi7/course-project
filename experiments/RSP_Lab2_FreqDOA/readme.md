## 🔁 Autocorrelation, Frequency Estimation, and DOA with Microphone Arrays

This project explores the use of autocorrelation and cross-correlation for signal analysis and enhancement. Tasks include signal denoising, frequency estimation under various noise levels, and direction-of-arrival (DOA) estimation using both 2-mic and 8-mic arrays under different SNR conditions.

---

### 🔧 Key Implementations

#### Part 1: Signal Autocorrelation and Cross-Correlation

- Generate sinusoidal signals with added Gaussian noise
- Compute:
  - Autocorrelation of noisy signal
  - Cross-correlation between signal and noise
- Visualize lag-peaks and noise effects

#### Part 2: Frequency Estimation Using Autocorrelation

- Parameters:
  - Frequency: 99.99 Hz
  - Sampling rate: 1000 Hz
  - Duration: 1s
  - Noise variances: 0.05, 0.5, 1, 5, 10
- Method:
  - Estimate frequency by identifying autocorrelation peaks
  - Repeat for 100 runs per variance
  - Report mean, standard deviation, and error bars

#### Part 3: Signal Enhancement with Microphone Array

- Use 4 microphones with calculated time delays
- Add Gaussian noise (SNR = 30, 10, -10 dB)
- Estimate lag via cross-correlation
- Align and sum signals to reduce noise

#### Part 4: DOA Estimation via Cross-Correlation

- Tabulate lag to DOA mapping (−11 to +11)
- Estimate DOA under varying SNR:
  - 2-mic array and 8-mic array
  - Analyze detection accuracy vs. SNR
- Visualize results in accuracy–SNR plots

#### Part 5: Improvement Strategies (Optional)

- Explore improved algorithms or array designs
- Report performance with updated accuracy curves and method explanation

---

### 📦 Libraries Used

- MATLAB built-in functions:
  - `randn`, `xcorr`, `plot`, `subplot`, `legend`, `xlabel`, `ylabel`, `title`
  - `mean`, `std`, `audioread`, `sound`, `fft`, `ifft`, `findpeaks`
  - Custom implementation for delay simulation and angle estimation

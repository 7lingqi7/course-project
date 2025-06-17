## 📉 Spectrum Estimation and Matched Filtering Using Periodogram and Correlogram

This experiment investigates the impact of window functions, sampling parameters, and noise on power spectrum estimation using periodogram and correlogram methods. A matched filtering approach is also explored for chirp signal detection in noisy environments.

---

### 🔧 Key Implementations

#### Part 1: Periodogram Analysis with Various Windows

- Signal: Combination of sine and cosine with white Gaussian noise
- Tested windows: Rectangular, Hamming, Hann, Blackman
- Compared effects on leakage, resolution, and frequency peak visibility

#### Part 2: Influence of Signal Parameters on Periodogram

- Varied:
  - Sampling rate: 300, 400, 600 Hz
  - Signal length: 1s, 2s, 4s
  - FFT length: 256, 512, 1024
  - Noise variance: 0.01, 0.1, 1.0
- Assessed changes in spectral resolution and peak sharpness

#### Part 3: Custom Periodogram and Correlogram Comparison

- Implemented FFT-based custom periodogram and biased autocorrelation-based correlogram
- Compared with MATLAB built-in methods for frequency peak alignment and spectral smoothness

#### Part 4: Power Spectrum under Random Interference

- Signal with random interference frequency ωI ∈ [50π, 80π]
- Ran 100 simulations and plotted:
  - Periodograms of 1st, 50th, 100th runs
  - Averaged power spectrum
- Analyzed effects of noise variance on spectral clarity

#### Part 5: Matched Filtering for Chirp Detection

- Chirp signal: \( x(t) = \cos(2\pi(f_0 t + kt^2)) \), where \( f_0 = 1000 \) Hz, \( k = 12000 \)
- SNR range: −50 dB to +15 dB
- Metrics: Detection success rate and MSE of estimated end time
- Observed sharp performance gain beyond −10 dB

#### Part 6: Periodogram-Based Detection Comparison

- Similar chirp detection setup without matched filter
- Used periodogram-based method to estimate signal end time
- Compared MSE and success rate vs. SNR
- Found matched filter more robust in low SNR environments

---

### 📦 Libraries Used

- `MATLAB` built-in:
  - `fft`, `xcorr`, `hamming`, `hann`, `blackman`, `periodogram`, `rand`, `mean`, `std`, `plot`, `findpeaks`
  - Custom scripts for matched filtering and flowchart visualization


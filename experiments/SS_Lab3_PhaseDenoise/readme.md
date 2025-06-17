## 🎧 Audio Signal Processing: Phase Perception and Noise Filtering

This project investigates human auditory perception of phase and explores noise reduction using frequency-domain and time-domain filtering techniques in MATLAB. It includes reversing entire signals and frame-wise segments, as well as filtering noisy signals at various SNR levels.

---

### 🔧 Key Implementations

#### Part 1: Phase Inversion and Perception

- Load a 5-second audio segment sampled at 16 kHz
- Reverse the full signal (`x(t)` → `x(−t)`) and compare perception
- Perform frame-wise inversion with varying frame lengths: 2000, 1000, 500, 250, 125, 62 samples
- Use STFT to analyze spectral effects of frame length on phase perception
- Identify phase insensitivity thresholds in human hearing

#### Part 2: Noise Filtering

- Generate noisy audio signals with SNRs of 10 dB, 0 dB, −10 dB
- Apply low-pass filter (cutoff 3 kHz) in frequency domain via FFT and IFFT
- Design equivalent FIR filter for time-domain noise removal
- Compare waveforms and audio quality across original, noisy, and denoised signals

---

### 📦 Libraries Used

- MATLAB built-in functions:
  - `audioread`, `audiowrite`, `sound`, `resample`, `mean`, `flipud`
  - `plot`, `subplot`, `xlabel`, `ylabel`, `title`, `legend`, `spectrogram`
  - `fft`, `ifft`, `fir1`, `filter`, `randn`, `var`, `hamming`

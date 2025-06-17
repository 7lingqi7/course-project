## 🔁 Signal Convolution: MATLAB Simulation vs Hardware Experiment

This project simulates the convolution of a periodic square wave signal with the impulse response of an RC circuit using MATLAB. The simulation results are compared to those of a real-world hardware experiment using identical parameters to evaluate the fidelity and accuracy of digital signal processing techniques.

---

### 🔧 Key Implementations

- **Signal Definition**
  - Periodic square wave: amplitude = 5 V, frequency = 10 kHz, DC offset = 1 V
  - Impulse response: derived from RC circuit parameters (R = 2.2 kΩ, C = 10 nF)

- **Convolution Processing**
  - Use `conv()` function to simulate the system’s output
  - Normalize result for consistent visual comparison

- **Visualization Enhancements**
  - Apply dynamic `y`-axis adjustment for clarity
  - Normalize convolution output to match input scale
  - Display impulse response and overlay original vs. convolved signal

- **Comparison with Hardware**
  - MATLAB and hardware results analyzed
  - Differences noted in waveform amplitude alignment and clipping (hardware limited to 0–5 V)

---

### 📦 Libraries Used

- MATLAB built-in functions:
  - `linspace`, `square`, `exp`, `conv`, `subplot`, `plot`, `legend`, `axis`, `ylim`


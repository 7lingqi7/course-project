## 📊 Fourier Series, Gibbs Phenomenon, and Correlation Functions

This project is divided into two major parts. The first part demonstrates the Gibbs phenomenon by approximating a square wave using Fourier series. The second part explores autocorrelation and cross-correlation functions of periodic and random signals using MATLAB.

---

### 🔧 Key Implementations

#### Part 1: Gibbs Phenomenon

- Generate a square wave signal defined on [−π, π], with value 1 in [−π/2, π/2] and 0 elsewhere
- Use Fourier series with odd sine terms only (since the signal is odd)
- Visualize convergence behavior with increasing number of terms (e.g., N = 100)
- Highlight oscillations near the signal's discontinuities (overshoot near ±π/2)

#### Part 2: Autocorrelation and Cross-Correlation

- Generate three signals:
  - `x₁`: periodic cosine wave
  - `x₂`: periodic sine wave of different frequency
  - `x₃`: random noise sequence
- Compute **autocorrelation** for each signal using `xcorr` with unbiased estimation
- Compute **cross-correlation** between all pairs (x₁ & x₂, x₁ & x₃, x₂ & x₃)
- Visualize correlation functions and interpret statistical significance

---

### 📦 Libraries Used

- MATLAB built-in functions:
  - `linspace`, `square`, `sin`, `cos`, `randn`, `xcorr`, `subplot`, `plot`, `legend`, `xlabel`, `ylabel`, `title`, `grid`



## 🌌 Frequency Domain Processing and Image Restoration in Python

This project explores image processing in the frequency domain using Discrete Fourier Transform and implements several restoration techniques in Python. It includes spectrum visualization, ideal/Gaussian/Butterworth filters, adaptive median filtering, motion blur simulation, inverse filtering, Wiener filtering, and noise estimation.

---

### 🔧 Key Implementations

- **FFT and IFFT**
  - Perform 2D Fourier Transform on grayscale images
  - Visualize magnitude and phase spectrum with DC shift
  - Reconstruct images with IFFT

- **Ideal Lowpass Filtering**
  - Create an ideal circular lowpass mask
  - Apply frequency domain filtering to observe ringing artifacts

- **Gaussian and Butterworth Filters**
  - Apply lowpass filtering on grayscale and RGB images
  - Explore the effect of cutoff frequency and filter order on smoothing and artifacts

- **Butterworth Highpass Filtering**
  - Sharpen images by preserving high-frequency components
  - Compare different highpass filters and settings

- **Adaptive Median Filtering**
  - Implement custom window-size-based adaptive median filter
  - Remove salt-and-pepper noise while preserving edges

- **Motion Blur, Inverse Filtering, and Wiener Filtering**
  - Simulate linear motion blur in a given direction
  - Recover blurred images using inverse and Wiener filters
  - Analyze behavior under noise interference

- **Noise Parameter Estimation (Bonus)**
  - Analyze smooth regions in noisy images
  - Plot histograms to estimate distribution type
  - Use moment estimation to derive noise parameters

---

### 📦 Libraries Used

- `numpy`
- `opencv-python`
- `scikit-image`
- `matplotlib`
- `scipy`

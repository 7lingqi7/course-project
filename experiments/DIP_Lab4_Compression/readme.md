## 🗜️ Exp 4: JPEG Compression and Fidelity Evaluation

This project explores image compression techniques using JPEG and evaluates image fidelity through multiple metrics. It also simulates core components of the JPEG compression pipeline using Python.

---

### 🔧 Key Implementations

- **JPEG Compression (OpenCV)**
  - Compress images (`bunny.png`) at quality levels 90, 60, and 10
  - Measure and compare file sizes
  - Calculate:
    - Compression Ratio
    - Relative Data Redundancy

- **Fidelity Evaluation**
  - Compute image quality metrics:
    - Mean Squared Error (MSE)
    - Peak Signal-to-Noise Ratio (PSNR)
    - Structural Similarity Index (SSIM)
  - Implement a manual SSIM calculation following Wang et al. (2004)
  - Visualize metric changes with respect to JPEG quality

- **JPEG Core Pipeline Simulation**
  - Read `lenagray.tiff` and perform mean-shifting
  - Apply block-wise 8×8 Discrete Cosine Transform (DCT)
  - Quantize DCT coefficients using a standard luminance quantization table scaled by QF=50
  - Flatten each block using **zigzag reordering**
  - Perform **lossless predictive coding** on DC coefficients
  - Save all processed data into `.npz` file and compress into ZIP
  - Reconstruct the image from compressed data
  - Compare original and reconstructed image using MSE and PSNR

---

### 📦 Libraries Used

- `numpy`
- `opencv-python`
- `matplotlib`
- `skimage`
- `scipy`
- `PIL`
- `zipfile`
- `io`
- `math`
- `os`

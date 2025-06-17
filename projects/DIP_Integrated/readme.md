# 🔍 Experiment 5: Real-Time Image Denoising with Convolutional Autoencoders

This experiment implements a Convolutional Autoencoder (CAE) to denoise grayscale images. It trains the CAE to reconstruct clean images from noisy inputs and evaluates performance using PSNR metrics and visual comparisons.

---

## 🧪 Workflow Overview

### 📥 Data Preparation

- Dataset: Grayscale images resized to 128×128
- Preprocessing:
  - Normalization to [0, 1]
  - Gaussian noise added with mean = 0, variance = 0.01

### 🧱 CAE Architecture

- **Encoder**:
  - Conv2D → ReLU → MaxPool (×2)
- **Decoder**:
  - Conv2D → ReLU → UpSampling (×2)
- Output layer: Sigmoid activation to reconstruct normalized images

### ⚙️ Training Setup

- Loss: Binary Cross-Entropy (BCE)
- Optimizer: Adam
- Epochs: 50
- Batch size: 64
- GPU acceleration enabled

---

## 📈 Evaluation

- PSNR used to evaluate image fidelity
- Training loss steadily decreased, confirming convergence
- Visual comparison shows effective noise removal, preserving structure

| Sample | Input (Noisy) | Output (Denoised) |
|--------|----------------|--------------------|
| Img 1  | ![noisy1](./images/noisy1.png) | ![clean1](./images/clean1.png) |
| Img 2  | ![noisy2](./images/noisy2.png) | ![clean2](./images/clean2.png) |

---

## 📦 Libraries Used

- `numpy`
- `matplotlib`
- `tensorflow.keras`
  - `Model`, `Conv2D`, `MaxPooling2D`, `UpSampling2D`, `Input`
- `skimage.util.random_noise`
- `os`, `cv2`, `glob`



# 🖼️ GUI-Based Image Denoising Application with Autoencoder

This project builds a complete graphical user interface (GUI) application for real-time image denoising using a trained convolutional autoencoder (CAE). Users can load a noisy image and view the denoised result instantly via an interactive window.

---

## 🧠 Core Features

### 🎛️ GUI Functionality

- Built with `tkinter` for cross-platform compatibility
- Functions:
  - Load image from local storage
  - Display original (noisy) image
  - Denoise image via pre-trained model
  - Show output in a separate canvas
  - Save denoised image if needed

### 🧱 Model Architecture (CAE)

- Encoder:
  - Conv2D layers with ReLU activation
  - MaxPooling for spatial reduction
- Decoder:
  - Conv2D + UpSampling
  - Sigmoid for final reconstruction
- Trained on a custom noisy-clean grayscale dataset

---

## 🚀 Workflow

1. Start GUI via `main.py`
2. Click “Open Image” to select noisy input
3. Preview shown in left panel
4. Click “Denoise” to invoke the model
5. Output displayed in right panel
6. Optionally save result via “Save Image” button

---

## 📦 Libraries Used

- `tkinter` – GUI framework
- `PIL` (Pillow) – Image loading/display
- `numpy` – Image array manipulation
- `cv2` – Preprocessing operations
- `tensorflow.keras` – Model loading and prediction
- `os`, `glob` – File management

---

## 📂 Files

- `main.py` – Entry point and GUI logic
- `model.h5` – Trained convolutional autoencoder
- `/images/` – Sample input and output images

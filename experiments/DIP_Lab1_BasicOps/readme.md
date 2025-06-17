## 🧮 Basic Operations and Algebraic Processing for Digital Images Using Python

This project introduces foundational techniques in **digital image processing** using Python. Through a series of practical exercises, it explores image reading, format conversion, grayscale transformation, noise simulation, denoising, cropping, masking, pixel-wise arithmetic, and even time-lapse photography with webcam input — all achieved with powerful libraries such as OpenCV, Scikit-Image, and PIL.

---

### 🧪 Key Experiments

1. **Image I/O and Format Conversion**
   - Load `.png` images with `skimage`, convert to `PIL`, `OpenCV`, and save as `.jpg`
   - Learn RGB ↔ BGR channel order caveats

2. **RGB Component Extraction**
   - Display R, G, B channels as subplots
   - Analyze color component contribution and visual differences

3. **Color to Grayscale Conversion**
   - Compare three methods: max(R,G,B), average(R,G,B), and weighted formula `0.30R + 0.59G + 0.11B`

4. **Image Cropping**
   - Select and save the central `128x128` region from an image

5. **Noise Addition**
   - Add **Gaussian**, **salt**, **pepper**, **salt-and-pepper**, and **speckle noise** using `random_noise()`

6. **Denoising with Averaging**
   - Use 3, 30, and 300 noisy images to restore clarity via pixel averaging

7. **Image Algebra**
   - Perform addition and subtraction between two images (after resizing if needed)

8. **Text and Graphics Overlay**
   - Use `cv2.rectangle()` and `cv2.putText()` to annotate images

9. **Image Masking**
   - Add circular masks using `numpy.ogrid` and set pixels outside to black

10. **Webcam Capture and Time-Lapse (Bonus)**
    - Use `cv2.VideoCapture` and `time.sleep()` for frame-based photography or video

---

### 📈 Analysis & Reflections

- Proper format conversion is crucial for compatibility across libraries (e.g. BGR vs RGB)
- Grayscale methods yield different brightness and detail levels
- Noise simulation and averaging reveal real-world techniques for denoising
- Algebraic operations can enhance or diminish brightness depending on pixel-level effects
- Text overlays and masking allow for intuitive image labeling and focus
- Webcam integration and time-lapse open doors to dynamic image sequence applications

---

### 📦 Libraries Used

- `opencv-python`
- `scikit-image`
- `PIL (Pillow)`
- `matplotlib`
- `numpy`

---

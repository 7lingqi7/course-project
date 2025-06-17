## 🧪 Image Intensity Transformations and Spatial Filtering

This project implements various image intensity transformations and spatial filtering operations using Python libraries such as `skimage`, `PIL`, and `OpenCV`. Key tasks include contrast stretching, negative/log/gamma transformations, histogram computation and equalization, smoothing with linear/Gaussian/median filters, sharpening with Laplacian filtering, and basic face detection on images and live camera input.

---

### 🔧 Key Implementations

- **Contrast Adjustment**: Stretching, shrinking, negative, log, and gamma transformations using `skimage.exposure`
- **Histogram Display**: Visualization of grayscale intensity distributions before and after transformations
- **Histogram Equalization**: Enhancing contrast by redistributing intensity values to a uniform histogram
- **Smoothing Filters**:
  - Linear blur with `ImageFilter.BLUR`
  - Gaussian smoothing with varying kernel radii
  - Median filtering for salt & pepper noise
- **Sharpening**: Laplacian-based enhancement for detail extraction
- **Face Detection (Bonus)**:
  - Static image detection using `CascadeClassifier`, `dnn`, and `MTCNN`
  - Real-time webcam detection with background blurring

---

### 🖼️ Sample Inputs

- `beans.png`, `mandrill.jpg`, `lena.jpg`, and `exp2_7.jpg`

---

### 💡 Techniques Used

- Intensity transformation via pixel-wise operations
- Histogram analysis and visual diagnostics
- Spatial filtering using predefined and parameterized kernels
- Real-time image processing with OpenCV and webcam streams

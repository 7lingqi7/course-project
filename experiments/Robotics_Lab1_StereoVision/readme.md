
## 👁️ Binocular Stereo Vision & Disparity Map Generation

This project explores the principles of **binocular stereo vision** and implements a Python-based algorithm to compute **disparity maps** using different similarity metrics (SAD, SSD, NCC). It demonstrates the impact of block size and metric choice on depth accuracy, noise, and computational time.

---

### 🎯 Objectives

- Understand the **geometry and principles of stereo vision** and **parallax**
- Implement a **block-matching disparity map algorithm**
- Compare performance across similarity metrics (SAD, SSD, NCC)
- Evaluate the effects of **window size** on accuracy, noise, and computation time

---

### 🧠 Principle Overview

- **Disparity** refers to the horizontal shift between corresponding pixels in the left and right images
- **Depth** is inversely proportional to disparity:  
  \[
  Z = \frac{f \cdot T}{d}
  \]
  where \( f \) = focal length, \( T \) = baseline, \( d \) = disparity
- **Stereo pipeline**:  
  1. Camera Calibration  
  2. Stereo Rectification  
  3. Stereo Matching  
  4. Parallax Calculation

- Matching accuracy is improved using a **window/block** instead of a single pixel, and matching is restricted by **epipolar constraints**

---

### ⚙️ Implementation Highlights

- **Input**: Rectified left/right grayscale images
- **Algorithms**:  
  - **SAD**: Sum of Absolute Differences  
  - **SSD**: Sum of Squared Differences  
  - **NCC**: Normalized Cross-Correlation

- **Main Functions**:
  - `read_images()`: load grayscale images
  - `compute_disparity_map()`: block-matching using selected metric
  - Adjustable parameters: `block_size`, `disparity_range`, `method`

- **Output**: Grayscale disparity map with pixel intensity representing disparity

---

### 🧪 Experimental Analysis

#### 🔍 Window Size Effect (3×3 to 21×21)
| Window Size | Visual Quality | Noise Level | Object Clarity | Time (s) |
|-------------|----------------|-------------|----------------|----------|
| 3           | High noise     | ❌ Very noisy | ✅ Edges sharp  | ~45s     |
| 7           | Balanced       | ✅ Moderate   | ✅ Good         | ~45s     |
| 15          | Smooth         | ✅ Low       | ⚠️ Slight distortion | ~52s     |
| 21          | Very smooth    | ✅ Lowest    | ❌ High distortion | ~60s     |

- **Smaller blocks** improve details but increase noise
- **Larger blocks** reduce noise but blur fine features and edges

#### 📐 Metric Comparison
| Metric | Accuracy | Noise Level | Time (s @ size=7) |
|--------|----------|-------------|-------------------|
| SAD    | Low      | High        | ~44s              |
| SSD    | Medium   | Medium      | ~45s              |
| NCC    | High     | Lowest      | ~400s             |

- **NCC** is robust but computationally expensive
- **SAD/SSD** are faster but more prone to noise and block artifacts

---

### 📌 Key Takeaways

- Disparity estimation is highly sensitive to **block size** and **matching metric**
- **SSD** and **NCC** with 7×7 or 15×15 blocks strike a good balance
- **NCC** yields smoother depth maps but demands 5–10× longer processing time
- Proper tuning of **search range**, **window size**, and **matching algorithm** is essential for real-time applications

---

### 🛠️ Dependencies

- `opencv-python`
- `numpy`
- `time` (for benchmarking)

---

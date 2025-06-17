## 🧠 Image Segmentation and Ellipse Fitting Using Otsu Thresholding and Moment Analysis

This project implements a **complete image segmentation and analysis pipeline** based on grayscale conversion, **Otsu's thresholding**, **connected-component labeling**, **boundary detection**, and **minimum second moment axis estimation**. It concludes with the visualization of each object’s **best-fit ellipse**, using moment-based geometry and OpenCV.

---

### 🎯 Objectives

- Convert a color image into grayscale using weighted RGB values  
- Automatically binarize the grayscale image using **Otsu’s method**
- Perform **connected component labeling** to detect and differentiate objects
- Determine **object boundaries**, bounding boxes, and edge pixels
- Compute each object's **center of mass** and **second-order moments**
- Use moment analysis to draw:
  - The **minimum second moment axis** (long axis)
  - The **maximum second moment axis** (short axis)
  - The **best-fit ellipse** for each object

---

### 🧪 Key Steps

1. **Grayscale Conversion**  
   Weighted average: `I = 0.3*R + 0.59*G + 0.11*B`

2. **Binarization with Otsu’s Method**  
   - Automatically determines optimal threshold
   - Segments image into background and foreground

3. **Connected Component Labeling (Two-Pass Algorithm)**  
   - Assigns unique labels to connected regions
   - Uses union-find logic to resolve label equivalences

4. **Boundary Detection**  
   - Classifies boundary points by examining 8-neighbor connectivity
   - Records top, bottom, left, and right extreme points per object

5. **Moment-Based Axis Calculation**  
   - Computes centroid `(x̄, ȳ)` and second-order moments `a`, `b`, `c`
   - Calculates object orientation via:
     \[
     \theta = \arctan\left(\frac{b}{a - c}\right)
     \]
   - Determines principal axes and draws them

6. **Best-Fit Ellipse Drawing**  
   - Long axis: along minimum second moment direction  
   - Short axis: orthogonal direction  
   - Uses `cv2.ellipse()` to draw ellipses based on moment geometry

---

### 📈 Visualization Highlights

- **Grayscale Image**
- **Binary Segmentation (Black/White)**
- **Color-Labeled Segmentation Map**
- **Object Bounding Boxes**
- **Principal Moment Axes (red/green lines)**
- **Best-Fit Ellipses (accurately aligned to orientation)**

---

### 📌 Key Learnings

- Otsu’s method provides robust, unsupervised thresholding for clean segmentation
- Moment analysis enables a mathematical description of shape, orientation, and scale
- Fitting ellipses based on principal moments creates a compact, visual summary of object geometry
- Practical understanding of connected-component labeling and shape detection

---

### 🛠️ Tools & Libraries

- `OpenCV (cv2)`
- `NumPy`
- `Matplotlib`

---

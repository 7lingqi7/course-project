# 🧍 A Comprehensive Survey on 3D Human Mesh Recovery and Applications

This term paper provides a structured literature review of 3D Human Mesh Recovery (HMR) methods and their downstream applications, covering foundational models, optimization strategies, datasets, and evaluation protocols.

---

## 📚 Structure

### 1. Introduction
- Motivation: Human mesh provides richer geometry than keypoints or silhouettes
- Challenges: Occlusion, ambiguity, clothing variance, annotation scarcity

### 2. Parametric Human Models
- **SMPL / SMPL-X**: Pose + Shape decomposition
- **MANO**: Hand-specific extension
- **SCAPE / STAR / GHUM**: Alternatives with varying detail and efficiency

### 3. Core 3D HMR Methods
- **Single-stage regression** from 2D to SMPL (e.g., HMR, SPIN)
- **Optimization-based methods** (e.g., SMPLify)
- **Heatmap-based lifting** with keypoint constraints
- **Volumetric prediction / Mesh rasterization approaches**

### 4. Learning Paradigms
- **Supervised** (Human3.6M, 3DPW)
- **Weakly/Unsupervised** with 2D keypoints or adversarial priors
- **Semi-supervised** using synthetic or pseudo-labeled data

### 5. Application Scenarios
- **Motion Capture**
- **Gesture & Action Recognition**
- **Human-Robot Interaction**
- **Virtual Try-on and AR/VR**

### 6. Datasets & Benchmarks
- 3DPW, Human3.6M, MPI-INF-3DHP, AGORA, InstaVariety

---

## 📦 Libraries and Tools Referenced

- `PyTorch`, `SMPLify-X`, `OpenPose`, `Detectron2`
- Evaluation metrics: MPJPE, PA-MPJPE, PVE, silhouette IoU

---

## 📁 Report

This paper contains detailed architecture diagrams, dataset summaries, and taxonomy tables. See:
📄 `A Comprehensive Survey on 3D Human Mesh.pdf`


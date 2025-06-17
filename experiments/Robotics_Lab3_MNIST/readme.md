## 🤖 Perceptron-Based MNIST Digit Classification

This project implements a **single-layer perceptron (SLP)** to classify handwritten digits, using the **MNIST dataset**. It explores the theoretical foundation of the perceptron, training strategies, evaluation metrics, and extends the discussion to multi-class classification.

---

### 🎯 Objectives

- Understand the mathematical basis and working principle of the perceptron
- Implement and train a perceptron on MNIST for binary digit recognition (e.g. recognizing the digit '6')
- Evaluate performance using a **confusion matrix** and metrics like precision and recall
- Explore the extension from single-layer to multi-layer perceptrons

---

### 🧠 Key Concepts

- **Input Weights & Weighted Sum**: Each pixel input is assigned a weight and combined via summation
- **Activation Function**: A step function classifies outputs as +1 or -1
- **Perceptron Learning Rule**: Weights are iteratively updated using a fixed learning rate
- **Limitations**:
  - Works only with **linearly separable** datasets
  - Cannot solve problems like XOR due to its **single-layer structure**

---

### ⚙️ Experiment Workflow

1. **Dataset Reading**:  
   - Skipped MNIST file headers (16 bytes for images, 8 for labels)
   - Extracted pixel and label data using Python and NumPy

2. **Data Preprocessing**:  
   - Divided the dataset into training/testing subsets
   - Binary labels assigned (e.g. 6 vs. not-6) using `np.where`

3. **Training Process**:
   - Initialized weights randomly or with zeros
   - Iteratively computed predictions, updated weights using learning rate η
   - Trained until convergence or acceptable error rate reached

4. **Evaluation**:
   - Tested model on validation set
   - Constructed a **confusion matrix**
   - Calculated accuracy, precision, recall, F1-score

---

### 📈 Results

- The model achieved **high classification accuracy (~100%)** for binary tasks like detecting '6'
- **Confusion Matrix** visualized true positives (TP), false positives (FP), etc.
- Demonstrated that **learning rate** and **initial weights** affect training speed and convergence

---

### 🔄 Extensions

- Multi-class classification can be implemented by **calling multiple SLPs** in parallel (one-vs-rest scheme)
- Discussion included using **gradient descent** and **loss function minimization** as core optimization strategy
- Introduction to **multi-layer perceptrons (MLP)** and potential improvements using deeper architectures

---

### ✅ Key Takeaways

- Perceptrons are foundational for understanding neural networks and binary classification
- Proper **weight initialization** and **learning rate tuning** are critical
- The **MNIST dataset** provides an excellent benchmark for beginner deep learning experiments
- Evaluation via confusion matrix offers detailed insights into classification strengths and weaknesses


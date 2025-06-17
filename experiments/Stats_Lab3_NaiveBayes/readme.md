## 🧠 Naive Bayes for Text Classification

This project applies **Bayes' Theorem** to implement a binary text classifier using the **Naive Bayes algorithm**. The goal is to classify email messages as spam or non-spam using the Enron dataset.

---

### 🎯 Objectives

- Understand the concept and mathematical formulation of **Bayes’ Theorem**
- Learn how the **Naive Bayes model** simplifies computations via independence assumptions
- Implement spam detection from scratch using **Python**
- Apply **probability estimation, smoothing, and model evaluation** in a real-world NLP task

---

### 🔧 Experiment Process

1. **Theory Foundation**
   - Reviewed Bayes’ Theorem and reframed it for spam detection:  
     \[
     P(\text{Spam} \mid \text{Words}) \propto P(\text{Words} \mid \text{Spam}) \cdot P(\text{Spam})
     \]

2. **Preprocessing**
   - Loaded and cleaned the **Enron dataset**
   - Tokenized messages and computed word frequencies per class (spam/ham)

3. **Model Construction**
   - Calculated **log class priors**:  
     \[
     \log P(\text{Spam}) \quad \text{and} \quad \log P(\text{Ham})
     \]
   - Computed **conditional probabilities** with **Laplace smoothing**:
     \[
     P(\text{word} \mid \text{Spam}) = \frac{\text{count(word in spam)} + 1}{\text{total spam words} + V}
     \]

4. **Classification**
   - For each test message, computed cumulative log-probability for each class
   - Applied **decision rule** to assign spam or ham label

5. **Evaluation**
   - Compared predicted labels to ground truth
   - Calculated **classification accuracy**

---

### ✅ Results & Analysis

- Successfully built a Naive Bayes spam detector
- Understood and applied:
  - Log-space computation for numerical stability
  - Laplace smoothing for handling unseen vocabulary
- Highlighted the importance of:
  - Clean preprocessing in text classification
  - Naive assumption of **word independence**, a core simplification in Naive Bayes

---

### 📌 Key Takeaways

- Naive Bayes is simple but powerful for large-scale text tasks
- Preprocessing and probability estimation significantly affect performance
- Log-probabilities help manage underflow in probabilistic models
- The experiment deepened understanding of **applied Bayes theory** and its role in **natural language processing**


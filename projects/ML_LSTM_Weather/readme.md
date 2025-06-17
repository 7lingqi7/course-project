# 📶 Final Project: Text Classification with Traditional and Neural Models

This project implements and compares traditional ML models and a basic neural network for Chinese news text classification. It evaluates performance using precision, recall, F1-score, and training/inference time.

---

## 🧪 Project Overview

### 📚 Dataset

- Chinese News Dataset (`toutiao_cat_data.txt`)
- Preprocessing:
  - Removed null entries and duplicates
  - Split titles and categories
  - Tokenized using `jieba`
  - Padded sequences to uniform length

---

### ⚙️ Models Implemented

#### 1. **Multinomial Naive Bayes**
- Input: CountVectorizer features
- Accuracy: ~83%
- High precision on clear-cut categories
- Fastest training/inference time

#### 2. **Logistic Regression**
- Input: TF-IDF features
- Accuracy: ~85%
- Improved on nuanced titles, slightly slower

#### 3. **Support Vector Machine (SVM)**
- Input: TF-IDF features
- Accuracy: ~87%
- Strong performance on ambiguous cases
- Slowest inference time

#### 4. **Neural Network (SimpleNN)**
- Input: Word embeddings (avg pooled)
- Architecture: Dense → Dropout → Softmax
- Accuracy: ~89%
- Best performance on multi-category detection
- Trained with batch size 128 for 10 epochs

---

## 📊 Evaluation Metrics

- Metrics used: Precision, Recall, F1-Score (macro avg)
- SimpleNN outperformed others in both F1 and robustness
- SVM slightly better than Logistic Regression but slower
- Naive Bayes fastest but less accurate

---

## 📈 Visual Analysis

- Confusion matrix shows NN handles overlapping categories better
- Word cloud and frequency analysis validate importance of token selection
- Training curves plotted for NN (loss vs epoch)

---

## 📦 Libraries Used

- `pandas`
- `numpy`
- `matplotlib`, `seaborn`
- `jieba`
- `sklearn` (SVM, NaiveBayes, LogisticRegression, metrics, preprocessing)
- `tensorflow.keras`
  - `Tokenizer`, `pad_sequences`, `Sequential`, `Dense`, `Dropout`, `Embedding`


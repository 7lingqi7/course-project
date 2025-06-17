# 🧪 Experiment: Machine Learning Task 2 – Multi-Model Classification on Seeds Dataset

This experiment explores the application of six supervised machine learning models on the UCI Seeds dataset. The goal is to evaluate the classification performance of each model through accuracy, precision, recall, F1-score, and visual analysis.

## 🔍 Tasks Overview

1. **Data Exploration & Preprocessing**
   - Boxplots to detect distribution and outliers
   - Pairplots for bivariate relationships
   - Correlation heatmap and PCA for dimensional insights

2. **Model Implementations**
   - Logistic Regression (multinomial, lbfgs)
   - LDA (Linear Discriminant Analysis)
   - KNN (k=3 default)
   - Naive Bayes (Gaussian, Multinomial, Bernoulli)
   - SVM (Support Vector Machine, linear kernel)
   - Decision Tree

3. **Evaluation Metrics**
   - Accuracy
   - Confusion Matrix
   - Precision / Recall / F1-score
   - 10-fold CV for Naive Bayes

## 📈 Results Summary

| Model            | Accuracy | Best Classifier Notes                          |
|------------------|----------|------------------------------------------------|
| Logistic Reg.    | 95.24%   | Perfect on Class 3                             |
| LDA              | 93.65%   | Strong for Class 2 & 3                         |
| KNN              | 89.00%   | Slight drop for Class 1 & 3                    |
| Gaussian NB      | 87.30%   | Best NB variant, balanced performance          |
| Multinomial NB   | 85.71%   | Good for discrete features                     |
| Bernoulli NB     | 31.75%   | Poor results, unsuitable for continuous input  |
| SVM (linear)     | 90.48%   | Great for Class 2, minor errors in Class 1, 3  |
| Decision Tree    | 85.71%   | Decent performance with some misclassifications|

## 🧠 Key Insights

- PCA showed dimensional clustering potential, aiding model selection.
- Logistic regression, SVM, and LDA were top performers.
- Model selection should align with data characteristics (e.g., BernoulliNB fails on continuous features).
- Confusion matrices revealed class-specific strengths and weaknesses.

## 📦 Libraries Used

- `pandas`
- `numpy`
- `matplotlib`
- `seaborn`
- `sklearn` (LogisticRegression, LDA, KNN, SVM, Naive Bayes, DecisionTree, StandardScaler, metrics, model_selection)

## 🗂️ Dataset

- Source: [UCI Machine Learning Repository – Seeds Dataset](https://archive.ics.uci.edu/dataset/236/seeds)
- 7 continuous features, 3-class classification


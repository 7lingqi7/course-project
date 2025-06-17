## 🧠 ML Task 1: Ridge Regression and PCA on Boston Housing Dataset

This project focuses on predicting Boston house prices using Ridge Regression with PCA-based dimensionality reduction and 10-fold cross-validation.

---

### 🔧 Key Implementations

#### 📊 Data Preprocessing

- Dataset: 506 samples, 13 features
- Missing values filled with mean
- Feature normalization using `StandardScaler`
- PCA applied to retain 95% variance

#### 🧮 Model Training and Evaluation

- Implemented Ridge Regression with:
  - L2 regularization
  - Gradient descent (custom implementation)
  - Epoch-level loss tracking
- 10-fold cross-validation used to compute average MSE
- Training/test split: 90% / 10%
- Final training loss after 1000 epochs ≈ 27.58  
- Average MSE from cross-validation: ≈ 28.52

#### 📈 Data Analysis and Visualization

- Target distribution histogram shows slight left skew
- Correlation matrix reveals relationships among features
- Scatter plot of actual vs. predicted prices shows strong alignment

---

### 📦 Libraries Used

- `numpy`
- `pandas`
- `matplotlib`
- `seaborn`
- `sklearn`  
  - `StandardScaler`, `PCA`, `train_test_split`, `mean_squared_error`, `cross_val_score`


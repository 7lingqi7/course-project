# 🔢 Experiment 4: Non-negative Matrix Factorization (NMF) Clustering on Wheat Varieties

This project performs clustering on the UCI Seeds dataset using both library-based and manual implementations of Non-negative Matrix Factorization (NMF). The objective is to evaluate how well NMF can cluster grain varieties based on extracted features.

---

## 🧪 Experimental Workflow

### 📂 Dataset

- `seeds.csv` containing 210 wheat samples across three varieties (Kama, Rosa, Canadian)
- Features scaled using `MinMaxScaler` for [0,1] range compliance

---

## 📌 Part 1: Sklearn-based NMF

- **NMF Settings**:  
  - `rank = 3`, `repeat_times = 20`, `init = 'nndsvd'`
- **Process**:
  - Extract features and convert to numpy array
  - Apply NMF with sklearn 20 times using different seeds
  - Label each sample by its dominant feature from matrix W
  - Compute Silhouette score for each clustering result
  - Plot scores and highlight best run
  - Cross-tabulate original labels vs predicted clusters

- **Results**:
  - Best silhouette score ≈ 0.37
  - Strong clustering for Rosa wheat (67/70), and decent separation for Kama and Canadian

---

## 🛠️ Part 2: Manual NMF Implementation

- **Matrix Update Rules**:
  - Defined custom `update_H` and `update_W` functions using multiplicative rules
- **Process**:
  - Initialize W and H with non-negative random values
  - Iterate updates for 100 steps per run, repeated 20 times
  - Label samples by dominant weights in matrix W
  - Plot silhouette scores and highlight best run
  - Cross-tabulate predicted vs actual varieties

- **Results**:
  - Silhouette scores unstable, ranging from negative to ~0.20
  - Weaker cluster separation and less consistency
  - Greater dispersion across clusters, especially for Kama wheat

---

## 📈 Evaluation & Insights

| Metric             | Sklearn NMF              | Manual NMF                  |
|--------------------|---------------------------|------------------------------|
| Silhouette Scores  | Stable, peak at ≈ 0.37     | Fluctuates, peak at ≈ 0.20   |
| Cluster Cohesion   | High for Rosa & Canadian  | Low, especially for Kama     |
| Initialization     | nndsvd                    | Random non-negative values   |
| Convergence        | Fast, consistent           | Slower, prone to suboptimal  |

---

## 📦 Libraries Used

- `numpy`
- `pandas`
- `matplotlib`
- `sklearn.decomposition.NMF`
- `sklearn.preprocessing.MinMaxScaler`
- `sklearn.metrics.silhouette_score`
- `sklearn.model_selection.train_test_split`


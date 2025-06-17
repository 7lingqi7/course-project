# 🔍 Experiment 3: K-Means and DBSCAN Clustering on Synthetic Datasets

This experiment applies K-Means and DBSCAN clustering algorithms to five synthetic datasets of varying structures. The goal is to explore how each algorithm handles data distribution, density, and noise by visualizing parameter selection, applying clustering, and comparing results.

---

## 📂 Datasets Used

- `noisy_circles.txt`: Concentric circular clusters with noise  
- `noisy_moons.txt`: Interlocking crescent shapes  
- `blobs.txt`: Spherical Gaussian blobs  
- `aniso.txt`: Anisotropic (elongated) clusters  
- `no_structure.txt`: Random scatter with no clear clusters

---

## 🧪 Part I: Parameter Selection

### K-Means

- **Inertia vs. k plots** were created to apply the elbow method.
- Optimal `k` values were visually identified:
  - `noisy_circles` → k=2
  - `noisy_moons` → k=2
  - `blobs` → k=3
  - `aniso` → k=3
  - `no_structure` → no clear elbow; k=2 or 3 used cautiously

### DBSCAN

- Used **k-distance plots** and second derivative analysis to determine eps.
- Elbow point at the 498th distance sample was a common pattern.
- Fine-tuned `eps` for each dataset based on graph behavior:
  - DBSCAN could better adapt to density-based separation.

---

## 🧪 Part II: Clustering Comparison

| Dataset        | K-Means Result                              | DBSCAN Result                                  |
|----------------|----------------------------------------------|-------------------------------------------------|
| Noisy Circles  | Failed to separate rings                     | Successfully detected circular structure        |
| Noisy Moons    | Mixed crescents                              | Clearly identified both moon-shaped clusters    |
| Blobs          | Correctly clustered                         | Correctly clustered                             |
| Aniso          | Partial clustering                           | Better fitted to elongated data                 |
| No Structure   | Arbitrary partition                          | Most points labeled as noise                    |

- K-Means is efficient for spherical, evenly distributed data.
- DBSCAN is robust for irregular shapes and outliers.

---

## ⚙️ Implementation Details

- Calculated **inertia** for K-Means to guide `k` selection.
- For DBSCAN, used sorted k-distances and curvature analysis to estimate optimal `eps`.
- Used **three plots** per dataset:
  - Original data
  - K-Means clustering results
  - DBSCAN clustering results

---

## 📦 Libraries Used

- `numpy`
- `matplotlib`
- `scikit-learn`
  - `KMeans`, `DBSCAN`, `NearestNeighbors`, `StandardScaler`
- `scipy` (for derivative estimation)



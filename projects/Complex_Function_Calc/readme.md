# Complex Analysis Computation with MATLAB

This repository contains MATLAB implementations of various problems in complex analysis. It covers operations on complex numbers, solving complex equations, computing limits, derivatives, integrals, Taylor expansions, and visualizing complex-valued functions.

---

## 📘 Problem List

### 1. Calculate the values of the following functions:
1. \( \sqrt{1 + i} \)  
2. \( \sqrt{-2 + 2i} \)  
3. \( \sqrt[6]{\sqrt{3} + \left(2\sqrt{3} - 3\right)i} \)

---

### 2. Solve the equation system:
\[
\begin{cases}
z_1 + 2z_2 = 1 + i \\
3z_1 + iz_2 = 2 - 3i
\end{cases}
\]

---

### 3. Calculate limits:
1. \( \lim_{n \to \infty} \left( \frac{3 + 4i}{6} \right)^n \)  
2. \( \lim_{n \to \infty} \left( n + \frac{n^2}{2} \right)^{\frac{1}{n}} \)

---

### 4. Calculate the first-order derivative:
Given  
\[
f(z) = \left( z^2 - 1 \right)^2 \left( z^2 + 1 \right)^2
\]  
find \( f'(z) \) at \( z = \frac{i}{2} \)

---

### 5. Calculate the integrals:
1. \( \int_{1}^{i} \frac{1 + \tan z}{\cos^2 z} \, dz \)  
2. \( \int_{0}^{i} (z - i)e^{-z} \, dz \)

---

### 6. Expand the top 10 Taylor series terms of the following functions:
1. \( \sin(3 + z) \)  
2. \( e^z \ln(1 + z) \)  
3. \( \frac{2z^5 + 5z^3 + z^2 + 2}{z^3 + 2z^2 + 3z + 1} \)

---

### 7. Calculate the residue of:
\[
\frac{1 + z^4}{z(z^2 + 1)^2}
\]  
at its singular point.

---

### 8. Evaluate the contour integral:
\[
\oint_{|z| = 1} \frac{2z^2 + 1}{2z^3 + z^2 + 4z - 5} \, dz
\]

---

### 9. Draw the figures represented by the following complex numbers (where \( t \) is a real number):
1. \( z = t + it^2 \)  
2. \( z = t + ie^t \sin t \)

---

## 🛠️ Language & Tools

- MATLAB for symbolic computation and plotting
- `syms`, `residue`, `limit`, `int`, `diff`, and plotting functions

---


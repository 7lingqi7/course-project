## 📊 Conditional Probability and Bayes Rule in Python

This project applies **conditional probability** and **Bayes' rule** to simulate probabilistic events and analyze real-world data using Python. The experiment is divided into three parts: die roll simulations, a classic urn problem, and a statistical analysis of students’ math scores.

---

### 🎲 Part 1: Die Roll Simulations

#### Exercise 1:
- Simulated fair die rolls using `numpy.random`.
- Plotted **empirical vs theoretical probability** distributions of all 6 faces.
- As the number of rolls increased (e.g., n=1000), empirical results approached theoretical values.

#### Exercise 2:
- Focused on the event **E = {2, 4, 6}** (even numbers).
- Calculated and visualized the theoretical (0.5) vs. empirical probability of E.

---

### 🧠 Part 2: Conditional Probability & Bayes Rule – Urn Model

- Defined two urns with red and white balls.
- Wrote a Python function `conditional_probability()` to calculate:
  
  \[
  P(\text{Urn A} \mid \text{white ball drawn})
  \]

- Applied **Bayes’ Theorem**:
  
  \[
  P(A \mid W) = \frac{P(W \mid A)P(A)}{P(W \mid A)P(A) + P(W \mid B)P(B)}
  \]

---

### 📈 Part 3: Math Score Analysis Using Bayes Rule

- Used pandas and matplotlib to analyze student **study time vs. math scores**.
- Defined “high score” as a grade ≥ 15.
- Calculated:
  - \( P(\text{score} \geq 15) \)
  - \( P(\text{study time interval}) \)
  - \( P(\text{study interval} \mid \text{score} \geq 15) \)
- Applied Bayes’ Rule to find:

  \[
  P(\text{score} \geq 15 \mid \text{study time})
  \]

- Discovered an interesting trend: **moderate study time (2–5 hours)** correlated most strongly with high scores, while too much study time (>5 hours) showed diminishing returns.

---

### 📌 Key Takeaways

- Gained practical experience using **NumPy**, **pandas**, and **Matplotlib**.
- Understood and implemented **Bayes’ rule** in real and simulated scenarios.
- Learned to visualize and interpret empirical probability distributions.
- Developed deeper insight into **data-driven reasoning** and **statistical modeling** in Python.


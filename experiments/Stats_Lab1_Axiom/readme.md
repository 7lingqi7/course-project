## 🎲 Axiom of Probability in Python

This project explores basic probability theory and set operations using Python. It is divided into two parts: a **simulation-based probability estimator** and **set operation verifications** based on the axioms of probability and the inclusion-exclusion principle.

---

### 📐 Part 1: Probability Simulation

- Implemented `seq_sum(n)` to simulate `n` coin flips and return the number of heads using NumPy.
- Created `estimate_prob(n, k1, k2, m)` to estimate probabilities of the number of heads falling within a range `[k1, k2)` over `m` trials.
- Tested and validated the function using various probability scenarios.
- Measured standard deviations, median errors, and normalized error to verify estimation accuracy.

📊 **Key results from trials:**
- Median estimates consistently matched expected probability values with low standard deviations
- Normalized error < 1.0 across all cases, indicating reliable estimation

---

### 🧮 Part 2: Set Operations & Inclusion-Exclusion

- Verified set-theoretic identities using Python:
  - `complement_of_union(A, B)`
  - `intersection_of_complements(A, B)`
  - `union(A, B)` vs `inclusion_exclusion(A, B)`
  - `union3(A, B, C)` vs `inclusion_exclusion3(A, B, C)`
- Demonstrated **De Morgan’s Laws** and **inclusion-exclusion principle** for both two-set and three-set systems
- Used `itertools.product()` to generate the universal set for finite set operations

---

### 🧠 Key Takeaways

- Reinforced understanding of **probability estimation via simulation** and **randomness interpretation**
- Developed confidence in **Python syntax**, debugging, and modular programming
- Gained deeper insight into **set theory**, **complement**, **intersection**, and **union operations**
- Validated theoretical laws through numerical and programmatic approaches


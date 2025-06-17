# 🔐 Experiment 2: Public-Key Cryptography and Computational Hardness

This experiment investigates two key aspects of modern cryptography: probabilistic primality testing for public-key cryptosystems and integer factorization as a hard computational problem. The report provides algorithmic comparisons, implementation details, and performance testing for large numerical inputs.

> 📝 The complete Python code and result screenshots are included in the report: `2022110131_Zuyi Liao_EXP2.pdf`

---

## 🧪 Contents

### 🧮 A. Primality Testing

- Goal: Generate a 1024-bit prime number within the range \[2¹⁰²³, 2¹⁰²⁴\]
- Algorithms compared:
  - Brute Force
  - Sieve of Eratosthenes
  - Fermat's Little Theorem
  - AKS Primality Test
  - **Miller-Rabin Primality Test** ✅ (final choice)
- Final implementation uses 40+ rounds of Miller-Rabin for strong confidence
- Successfully generated and verified three distinct 1024-bit prime numbers

### 🔓 B. Integer Factorization

- Focus: Evaluate and implement factorization algorithms for large integers
- Algorithms considered:
  - Trial Division
  - Pollard’s Rho (chosen)
  - Quadratic Sieve (QS)
  - General Number Field Sieve (GNFS)
- Pollard’s Rho was selected for its balance of simplicity and effectiveness
- Max test case: 24-digit composite number
  - Successfully factored into primes but required ~7 minutes

---

## 📦 Libraries Used

- `random`
- `math`
- `time`
- (others embedded in the report code)


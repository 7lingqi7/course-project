## 🎲 Random Variable Distributions and Bayesian Game Strategy

This project simulates and analyzes common probability distributions using MATLAB, and applies Bayes’ theorem to design and evaluate a game-based decision strategy under uncertainty.

---

### 🔧 Key Implementations

#### Part 1: Random Variable Simulation

- Simulate 50 and 5000 samples for the following distributions:
  - **Rayleigh**
  - **Poisson**
  - **Uniform**
  - **Exponential**
- Plot:
  - Normalized histogram (relative frequency)
  - Estimated PDF/PMF (via `ksdensity`)
  - Theoretical PDF/PMF (via `pdf` or manual formula)
- Analyze the impact of sample size and kernel step size on smoothness and estimation accuracy

#### Part 2: Bayesian Decision Strategy (Advance)

- Define a game where betrayal probability `p` follows a uniform distribution in (0,1)
- Derive posterior distribution \( f_{P|A}(p|A) \) using Bayes' theorem, given previous betrayals in a Binomial setting
- Calculate the probability of betrayal in the next round \( P(B) = \int_0^1 p f_{P|A}(p|A) \,dp \)
- Apply threshold-based decision rule:
  - Trust if \( P(B) < 0.5 \), otherwise report

#### Part 3: Strategy Evaluation

- Simulate 1000 strategy runs to measure total return
- Visualize return distribution:
  - Scatter plot: trade time vs. return
  - Histogram: frequency of return outcomes
- Calculate:
  - Expected return ≈ 488
  - Variance ≈ 310.55
  - Probability of positive return ≈ 83.33%

#### Part 4: Program Structure

- Provide flowchart for betrayal estimation and decision strategy
- Discuss evaluation metric: total return mean and variance

---

### 📦 Libraries Used

- MATLAB built-in functions:
  - `makedist`, `random`, `pdf`, `ksdensity`
  - `histogram`, `plot`, `scatter`, `legend`, `title`, `xlabel`, `ylabel`
  - Custom code for Bayes posterior and integral estimation


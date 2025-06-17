## 📈 Central Limit Theorem & Data Visualization in Python

This project explores the **Central Limit Theorem (CLT)** through simulation and applies it to finance and weather data analysis. The goal is to understand the theoretical foundations and reinforce them through visualization and statistical reasoning using Python.

---

### 🎯 Objectives

- Understand the Central Limit Theorem and its practical significance
- Use Python to simulate sampling distributions from exponential and binomial populations
- Apply CLT to **financial return modeling**
- Build interactive visualizations for **weather trend analysis**

---

### 🧪 Experiment Sections

#### 1. Central Limit Theorem in Action

**Exercise 1: Exponential Distribution**
- Simulated samples from an exponential distribution (θ = 4)
- Verified that sample means approximate a normal distribution as `n → ∞`
- Compared empirical and theoretical means/standard deviations

**Exercise 2: Binomial Distribution**
- Simulated 50 samples (n=500) from a Binomial(k=30, p=0.9)
- Visualized convergence of sampling mean distribution to normal
- Compared with theoretical mean = `np` and std = `sqrt(np(1-p))`

---

#### 2. Application of CLT in Finance

- Analyzed **10 years of daily returns** for ITC
- Observed a **leptokurtic distribution**: fat tails and sharper peak than Gaussian
- Used Seaborn to plot return histograms and validate normality assumptions

---

#### 3. Advanced Visualization with Weather Data

**Exercise 1:** Histogram of Detroit temperatures with dynamic bin size  
**Exercise 2:** 7-day moving average to predict future temperature trends  
**Exercise 3:** Subplots showing **temperature trends across cities** with shared X-axis  
**Exercise 4:** Joint plotting of **humidity, pressure, and temperature** for detailed climate insights in Detroit

---

### ✅ Key Takeaways

- 👨‍💻 **Simulation Mastery**: Reinforced CLT through population sampling
- 📊 **Visualization Skills**: Gained experience with Matplotlib and Seaborn for presenting complex data
- 🔍 **Statistical Thinking**: Understood distribution properties and their relevance in real-world data (e.g. finance, weather)
- 🔄 **Interactivity**: Learned to build dynamic visualizations using sliders
- 📉 **Moving Averages**: Applied time-series smoothing techniques to detect and forecast trends

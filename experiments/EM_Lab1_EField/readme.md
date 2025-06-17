## ⚡ Electrostatic Field Simulation with MATLAB

This project explores five electrostatic field configurations through theoretical derivation and MATLAB-based numerical simulations. It compares analytical results with simulation data under various boundary and material conditions.

---

### 🔧 Key Implementations

#### Problem 1: Charged Dielectric Sphere

- Uniform charge distribution ρ₀ within a dielectric sphere (ε = 1.3)
- Plots electric field E(x) along the x-axis
- Observed linear increase inside the sphere (r < a), inverse square decay outside (r > a)
- Discusses influence of boundary size on simulation smoothness

#### Problem 2: Charged Disk on xoy Plane

- Circular disk of radius 10 mm, surface charge density ρₛ
- Simulates E(z) on the z-axis
- Analytical and simulated results match: E decays and stabilizes as z increases

#### Problem 3: Conductor Sphere with Dielectric Shell

- Inner conductor: radius 10 mm, charge = 1 C
- Outer dielectric shell: radius = 23 mm, εr = 4
- Computes E(x) and D(x) on the x-axis
- Analyzes field jumps at material boundaries and symmetry

#### Problem 4: Concentric Spherical Capacitor with Two Dielectrics

- Inner radius: 10 mm, outer radius: 20 mm
- Top half ε₁ = 2.3, bottom half ε₂ = 4.0
- Studies how electric field E(x) and displacement D(x) vary across dielectric boundaries
- Asymmetry introduced by different permittivity along the x-axis

#### Problem 5: Non-concentric Charged Shells

- Uniform body charge between two spheres of radius 8 mm and 20 mm
- Centers offset by 10 mm on x-axis
- Theoretical E is constant; simulation shows fluctuations due to resolution
- Notes trade-off between smoothness and computation cost

---

### 📦 Libraries Used

- `MATLAB` built-in:
  - `meshgrid`, `surf`, `quiver`, `plot`, `legend`, `xlabel`, `ylabel`, `title`
  - Custom field solvers and analytical models


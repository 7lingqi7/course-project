## 🧲 Magnetic Field Simulation and Analytical Verification in Classic EM Structures

This project uses MATLAB to simulate and analyze the magnetic field distribution in various electromagnetic structures including hollow cylinders, circular wire loops, coaxial lines, and overlapping current-carrying conductors. The results are compared with theoretical predictions derived from Ampère's Law and Biot–Savart Law.

---

### 🔧 Key Implementations

#### Problem 1: Magnetic Field in Hollow Cylinder

- Geometry: Infinite hollow cylinder with inner radius 1 mm and outer radius 1.5 mm
- Current: Uniform axial current I = 1.3 A
- Theory:
  - B = 0 when r < a
  - B increases linearly for a ≤ r ≤ b
  - B decreases as 1/r for r > b
- Simulation confirms piecewise behavior along x-axis

#### Problem 2: Magnetic Field at Center of Wire Loop

- Geometry: Circular wire loop with radius 20.3 mm
- Current: 1 A
- Field calculated using Biot–Savart Law
- B reaches maximum at center (x = 0), decays with distance
- Small simulation deviations due to boundary truncation

#### Problem 3: Coaxial Line Magnetic Field

- Inner conductor: radius a = 0.5 mm  
- Outer conductor: b = 1 mm, c = 1.5 mm  
- Relative permeability μr = 4.3  
- Opposite-phase current in inner/outer conductors
- B and H show symmetric profiles with linear and inverse relationships across regions
- Simulation validates piecewise trends with minor outer-boundary deviations

#### Problem 4: Overlapping Cylindrical Currents

- Two cylinders of radius 1 mm, spaced 1 mm apart
- Equal and opposite currents (1 A) in each cylinder
- Magnetic field B in overlapping region is constant as predicted
- Simulation agrees with constant field expectation in region [−0.4 mm, 0.4 mm]

---

### 📦 Libraries Used

- `MATLAB` built-in:
  - `plot`, `meshgrid`, `quiver`, `surf`, `legend`, `xlabel`, `ylabel`, `title`
  - Custom code for current geometry modeling and field solver integration

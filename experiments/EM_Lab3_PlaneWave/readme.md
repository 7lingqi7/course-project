## 🌊 Plane Wave Simulation Across Layered Media

This project combines theoretical modeling and simulation to analyze how a 2.4 GHz plane wave propagates through three dielectric layers with distinct permittivities. It computes electric field intensities and verifies results using Ansys HFSS and MATLAB.

---

### 🔧 Key Implementations

#### Theoretical Modeling

- **Waveform**: Incident plane wave \( \vec{E} = \hat{x} E_0 e^{-jkz} \) with amplitude 1 V/m and frequency 2.4 GHz
- **Layered Medium**: 
  - \( z < d_1 \): free space
  - \( d_1 < z < d_2 \): \( \varepsilon_r = 2.3 \)
  - \( d_2 < z < d_3 \): \( \varepsilon_r = 3.3 \)
  - \( d_3 < z < d_4 \): \( \varepsilon_r = 4.3 \)
- **Impedance Matching**: Recursive calculation of equivalent input impedance across layers
- **Field Expressions**:
  - Total and reflected electric fields in \( z < d_1 \)
  - Transmitted field in \( z > d_4 \)
  - Real part extracted to obtain instantaneous electric field

#### HFSS + MATLAB Simulation

- Simulated plane wave propagating in the +z direction from origin
- Electric field vector oriented along +x
- Evaluated fields at \( t = T/4 \)
- Simulation region: (50 mm, 50 mm, 0) → (50 mm, 50 mm, 220 mm)

#### Result Visualization

- **Total Field**: Decreases then increases across layers; minimum near z = 15 mm, peaks at start and end
- **Scattered Field**: Similar trend with strong field discontinuities at interfaces
- **Agreement**: Simulation results (blue points) match theoretical curves (red line) closely
- **Error Sources**: Numerical approximations, meshing errors, material parameter inaccuracies

---

### 📦 Libraries Used

- `Ansys HFSS` for full-wave simulation
- `MATLAB` for post-processing and plotting
  - `plot`, `real`, `meshgrid`, `surf`, `legend`, `xlabel`, `ylabel`, `title`


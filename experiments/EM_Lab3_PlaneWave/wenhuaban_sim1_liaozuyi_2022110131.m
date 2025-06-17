% Constants
f = 2.4e9; % Frequency of the plane wave in Hz
c = 3e8; % Speed of light in vacuum in m/s
lambda = c / f; % Wavelength of the plane wave in meters
omega = 2 * pi * f; % Angular frequency of the plane wave
k = 2 * pi / lambda; % Wave number
E0 = 1; % Amplitude of the electric field in V/m
phi = 0; % Initial phase of the plane wave

% Time at t = T/4
T = 1 / f; % Period of the plane wave
t = T/4; % Specific time point at one quarter of the period

% Z-axis range from 0mm to 40mm 
z = linspace(0, 40e-3, 1000); % Generate 1000 linearly spaced points from 0 to 40mm along z-axis

% Relative permittivities (from the problem statement)
eta0 = 120*pi; % Intrinsic impedance of vacuum
adj = 0.2; % Adjusted value to account for medium specifics
epsilon1 = 2 + adj; % Relative permittivity of the first medium
epsilon2 = 3 + adj; % Relative permittivity of the second medium
epsilon3 = 4 + adj; % Relative permittivity of the third medium

% Impedance calculations for each medium
eta1 = eta0 / sqrt(epsilon1);   
eta2 = eta0/ sqrt(epsilon2);
eta3 = eta0/ sqrt(epsilon3);

% Phase constants for each medium
beta1 = omega * sqrt(epsilon1) / c;
beta2 = omega * sqrt(epsilon2) / c;
beta3 = omega * sqrt(epsilon3) / c;

% Thickness of each medium
dz1 = 10 * 1e-3;
dz2 = 20 * 1e-3;
dz3 = 30 * 1e-3;

% Calculating equivalent impedance for layered media
eta_eq1 = eta3 * (eta0 + 1j * eta3 * tan(beta3 * dz3)) / (eta3 + 1j * eta0 * tan(beta3 * dz3));
eta_eq2 = eta2 * (eta_eq1 + 1j * eta2 * tan(beta2 * dz2)) / (eta2 + 1j * eta_eq1 * tan(beta2 * dz2));
eta_eq3 = eta1 * (eta_eq2 + 1j * eta3 * tan(beta1 * dz1)) / (eta1 + 1j * eta_eq2 * tan(beta1 * dz1));

% Initialize fields
E_total = zeros(size(z)); % Initial total electric field is zero
E_incident = E0 * exp(-1j * k * z) * exp(1i * omega * t); % Calculate incident electric field

% Calculate reflected field and add to total field
gamma1 = (eta_eq3 - eta0) / (eta_eq3 + eta0); % Reflection coefficient
E_refl_region = gamma1 * exp(1j * k .* z) * exp(1i * omega * t); 
E_total = E_total + E_incident + E_refl_region; % Superposition of incident and reflected fields

% Plotting the results for total electric fields
figure;
a = importdata("total.csv");
data1 = a.data;
plot(z * 1e3, abs(real(E_total)), 'LineWidth', 2, 'Color', 'r'); % Plot calculated total field
hold on;
plot(data1(1:18,3), data1(1:18,4), 'o-', 'MarkerSize', 8, 'Color', 'b'); % Plot simulated data
grid on;
legend('Calculated', 'Simulated');
xlabel('z (mm)', 'FontSize', 12);
ylabel('Electric Field Intensity (V/m)', 'FontSize', 12);
title('Total Electric Fields along z-axis between 0mm and 40mm', 'FontSize', 14);
set(gca, 'FontSize', 10);
hold off;

% Plotting the results for scattered electric fields
figure;
b = importdata("scatter.csv");
data2 = b.data;
plot(z * 1e3, abs(real(E_refl_region)), 'LineWidth', 2, 'Color', 'r'); % Plot calculated reflected field
hold on;
plot(data2(1:18,3), data2(1:18,4), 'o-', 'MarkerSize', 8, 'Color', 'b'); % Plot simulated data
grid on;
legend('Calculated', 'Simulated');
xlabel('z (mm)', 'FontSize', 12);
ylabel('Electric Field Intensity (V/m)', 'FontSize', 12);
title('Scattered Electric Fields along z-axis between 0mm and 40mm', 'FontSize', 14);
set(gca, 'FontSize', 10);
hold off;


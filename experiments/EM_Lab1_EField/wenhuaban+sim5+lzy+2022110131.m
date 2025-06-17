% Constants
epsilon_0 = 8.854e-12; % Permittivity of vacuum (C/V·m)
r_outer = 20e-3; % Radius of the outer sphere (20 mm)
r_inner = 8e-3; % Radius of the inner sphere (8 mm)
c = 10e-3; % Distance between the centers of the spheres (10 mm)
Q = 1; % Total charge (C)

% Calculate the volume of the spherical shell
V = (4/3) * pi * (r_outer^3 - r_inner^3);

% Calculate volume charge density
rho = Q / V;

% Define spatial points along the x-axis from 2 mm to 18 mm
x = linspace(2e-3, 18e-3, 10000); % From 2 mm to 18 mm

% Theoretical calculation of the electric field inside the cavity
E = (rho * c) / (3 * epsilon_0) * ones(size(x));

% Convert x to mm for plotting
x_mm = x * 1e3;

% Plot computed electric field
figure;
plot(x_mm, E, 'r-', 'LineWidth', 2); % Red solid line for computed electric field

% Add title and axis labels
title('E-Field vs Position (X) on X-Axis');
xlabel('Position (X) [mm]');
ylabel('E-Field (N/C)');

% Show grid
grid on;

% Adjust axis to fit data range
axis tight;

% Load experimental electric field data
data_E = load('E5.txt'); % Use load to read the data

% Extract X values and E-Field values
X_exp_E = data_E(:, 1); % First column
E_Field_exp = data_E(:, 2); % Second column

% Plot experimental electric field data
hold on;
plot(X_exp_E, E_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental electric field
legend('Computed E-Field', 'Experimental E-Field');
hold off;


% Parameters
R = 10; % Disk radius (mm)
Q = 1.3; % Total charge on the disk (C)
epsilon_0 = 8.854e-12; % Vacuum permittivity (F/m)

sigma = Q / (pi * (R * 1e-3)^2); % Charge surface density (C/m^2)

% Points on the z-axis
z_values = linspace(0, 15, 500); % Generate 500 z-values from 0 mm to 50 mm

% Initialize electric field array
E_z = zeros(size(z_values));

% Calculate electric field at each z position
for i = 1:length(z_values)
    z = z_values(i) * 1e-3; % Convert to meters
    integrand = @(s) s ./ (z^2 + s.^2).^(3/2);
    integral_result = integral(integrand, 0, R * 1e-3, 'ArrayValued', true);
    E_z(i) = sigma * z / (2 * epsilon_0) * integral_result;
end

% Plot computed results
figure;
plot(z_values, E_z, 'r-', 'LineWidth', 2); % Red solid line for computed results

% Add title and axis labels
title('Comparison of Electric Field on Position Z-Axis');
xlabel('Position (Z) [mm]');
ylabel('E-Field (N/C)');

% Show grid
grid on;

% Adjust axis to fit data range
axis tight;

% Load experimental data
data = load('E2.txt');

% Extract Z values and E-Field values
Z_exp = data(:, 1); % First column
E_Field_exp = data(:, 2); % Second column

% Plot experimental data
hold on;
plot(Z_exp, E_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental data
legend('Computed E-Field', 'Experimental E-Field');
hold off;

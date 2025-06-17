% Parameters
a = 10; % Sphere radius (mm)
Q = 1; % Total charge (C)
epsilon_r = 1.3; % Dielectric constant
epsilon_0 = 8.85e-12; % Vacuum permittivity (F/m)

% Define spatial points (only positive axis)
x = linspace(0, 25, 500); % From 0 mm to 25 mm

% Initialize electric field array
E = zeros(size(x));

% Calculate electric field
for i = 1:length(x)
    r = x(i) * 1e-3; % Convert to meters
    if r < a * 1e-3
        % Inside the sphere
        E(i) = (Q * r) / (4 * pi * epsilon_r * epsilon_0 * (a * 1e-3)^3);
    else
        % Outside the sphere
        E(i) = (Q) / (4 * pi * epsilon_0 * r^2);
    end
end

% Plot computed results
figure;
plot(x, E, 'r-', 'LineWidth', 2); % Red solid line for computed results

% Add title and axis labels
title('Comparison of Electric Field on Positive X-Axis');
xlabel('Position (X) [mm]');
ylabel('E-Field (N/C)');

% Show grid
grid on;

% Adjust axis to fit data range
axis tight;

% Load experimental data
data = load('E1.txt');

% Extract X values and E-Field values
X_exp = data(:, 1); % First column
E_Field_exp = data(:, 2); % Second column

% Plot experimental data
hold on;
plot(X_exp, E_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental data
legend('Computed E-Field', 'Experimental E-Field');
hold off;



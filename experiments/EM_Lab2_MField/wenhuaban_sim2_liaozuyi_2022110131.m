% Constants
mu_0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
I_total = 1; % Total current (A)

adj = 3 / 10; % Given adjustment factor
% Radius of the circular wire
radius = (20 + adj) * 1e-3; % Radius in meters

% Define x positions where B is to be calculated
x_positions = linspace(-10e-3, 10e-3, 100); % Example x positions from -10 to 10mm

% Calculate B at each x position
B = mu_0 * I_total * radius^2 ./ (2 * (radius^2 + x_positions.^2).^(3/2));

% Load data from file
data_B = importdata("B2.txt");
if isstruct(data_B)
    data_B = data_B.data;
end

% Extract X values and B-Field values
x_exp_B = data_B(:, 1); % First column
B_exp = data_B(:, 2); % Second column

% Plot B vs x
figure;
plot(x_positions * 1e3, B, 'LineWidth', 2, 'DisplayName', 'Calculated B-Field'); % Convert x_positions to mm for plotting
hold on;
plot(x_exp_B, B_exp, 'r--', 'LineWidth', 2, 'Marker', 'o', 'MarkerSize', 3, 'DisplayName', 'Experimental B-Field');
xlabel('Position (x) [mm]');
ylabel('Magnetic Field (B) [T]');
title('Magnetic Field (B) along the x-axis');
xlim([-10, 10]); % Correct usage of xlim
grid on;
legend('show');




% Constants definition
mu_0 = 4 * pi * 10^-7; % Vacuum permeability in H/m
radius = 0.001; % Radius in meters
distance = 0.001; % Distance between axes in meters
I_current = 1; % Current in Amperes

% Calculate current density
J_density = I_current / ((1/3) * pi * radius^2 + (sqrt(3)/2) * radius^2); % Current density in A/m^2

% Define x-axis range
x_positions = -0.0005:0.00001:0.0005; % x-axis from -0.5mm to 0.5mm

% Calculate magnetic field B
B_field = (mu_0 * J_density * distance) / 2 * ones(size(x_positions)); % B is constant in this range

% Load data from file
data_B = importdata("B4.txt").data;

% Calculate the mean of the imported data
mean_data_B = mean(data_B(:, 2));

% Plot the results
figure;
plot(x_positions * 1000, B_field, 'LineWidth', 2, 'DisplayName', 'Calculated'); % Convert x to mm for better readability
hold on;
plot(data_B(:, 1), data_B(:, 2), '--o', 'LineWidth', 2, 'MarkerSize', 3, 'DisplayName', 'Imported');
xlabel('x (mm)');
ylabel('B (T)');
ylim([min(min(B_field), min(data_B(:, 2))) * 0.5, max(max(B_field), max(data_B(:, 2))) * 1.5]); % Adjust y-axis limits
title('Magnetic Field B along x-axis');
grid on;
legend('show');

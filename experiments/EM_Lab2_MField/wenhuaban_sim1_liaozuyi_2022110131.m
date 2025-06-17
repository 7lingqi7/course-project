% Constants
mu_0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
I_base = 1; % Base current (A)
adj = 3/10; % Given adjustment factor
I_total = I_base * (1 + adj); % Total current (A)

% Radii of the cylinder
r_inner = 1e-3; % Inner radius (m)
r_outer = 1.5e-3; % Outer radius (m)

% Define x positions where B is to be calculated
x_positions = linspace(0, 10e-3, 100); % Example x positions from 0 to 10mm

% Initialize B array
B = zeros(size(x_positions));

% Calculate B at each x position
for i = 1:length(x_positions)
    x = x_positions(i);
    if abs(x) <= r_inner
        % Inside the inner radius, B is 0
        B(i) = 0;
    elseif abs(x) > r_inner && abs(x) <= r_outer
        % Between inner and outer radius
        B(i) = (mu_0 * I_total / (2 * pi * abs(x))) * (abs(x)^2 - r_inner^2) / (r_outer^2 - r_inner^2);
    else
        % Outside the outer radius
        B(i) = (mu_0 * I_total / (2 * pi * abs(x))) * (r_outer^2 - r_inner^2) / (r_outer^2 - r_inner^2);
    end
end

% Load data from file
data_B = importdata('B1.txt');
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
xlim([0, 10]); % Correct usage of xlim
grid on;
legend('show');


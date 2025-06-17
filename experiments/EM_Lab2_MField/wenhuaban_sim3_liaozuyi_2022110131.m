% Constants
mu_0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
adj = 3/10; % Given adj
mu_r = 4 + adj; % Relative permeability
I_current = 1; % Current (A)

% Radii
radius_inner = 0.5e-3; % Inner radius (m)
radius_middle = 1e-3; % Middle radius (m)
radius_outer = 1.5e-3; % Outer radius (m)

% Define x positions where H and B are to be calculated
x_positions = linspace(0, 5e-3, 100); % Example x positions from 0 to 5mm

% Initialize H and B arrays
H_field = zeros(size(x_positions));
B_flux = zeros(size(x_positions));

% Calculate H and B at each x position
for i = 1:length(x_positions)
    x_pos = x_positions(i);
    if abs(x_pos) < radius_inner
        % Region 1: r < a
        H_field(i) = I_current * abs(x_pos) / (2 * pi * radius_inner^2);
        B_flux(i) = mu_0 * H_field(i);
    elseif abs(x_pos) >= radius_inner && abs(x_pos) < radius_middle
        % Region 2: a <= r < b
        H_field(i) = I_current / (2 * pi * abs(x_pos));
        B_flux(i) = mu_0 * mu_r * H_field(i);
    elseif abs(x_pos) >= radius_middle && abs(x_pos) < radius_outer
        % Region 3: b <= r < c
        H_field(i) = (I_current / (2 * pi * abs(x_pos))) - (I_current * (abs(x_pos) - radius_middle) / (2 * pi * radius_outer^2));
        B_flux(i) = mu_0 * H_field(i);
    else
        % Region 4: r >= c
        H_field(i) = 0;
        B_flux(i) = 0;
    end
end

% Load data from file
data_H = importdata('H3.txt');
if isstruct(data_H)
    data_H = data_H.data;
end

% Load data from file
data_B = importdata('B3.txt');
if isstruct(data_B)
    data_B = data_B.data;
end


% Extract X values and H-Field values
x_exp_H = data_H(:, 1); % First column
H_exp = data_H(:, 2); % Second column

% Extract X values and B-Field values
x_exp_B = data_B(:, 1); % First column
B_exp = data_B(:, 2); % Second column

% Plot H and B vs x
figure;
subplot(2, 1, 1);
plot(x_positions * 1e3, H_field, 'LineWidth', 2, 'DisplayName', 'Calculated H-Field'); % Convert x_positions to mm for plotting
hold on;
plot(x_exp_H, H_exp, 'r--', 'LineWidth', 2, 'Marker', 'o', 'MarkerSize', 3, 'DisplayName', 'Experimental H-Field');
xlabel('Position (x) [mm]');
ylabel('Magnetic field H (A/m)');
title('Magnetic field H along the x-axis');
grid on;
legend('show');

subplot(2, 1, 2);
plot(x_positions * 1e3, B_flux, 'LineWidth', 2, 'DisplayName', 'Calculated B-Field'); % Convert x_positions to mm for plotting
hold on;
plot(x_exp_B, B_exp, 'r--', 'LineWidth', 2, 'Marker', 'o', 'MarkerSize', 3, 'DisplayName', 'Experimental B-Field');
xlabel('Position (x) [mm]');
ylabel('Magnetic flux density B (T)');
title('Magnetic flux density B along the x-axis');
grid on;
legend('show');






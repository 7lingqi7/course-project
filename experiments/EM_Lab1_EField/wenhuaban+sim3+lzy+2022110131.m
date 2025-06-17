% Parameters
R_inner = 10; % Inner radius of the conductor ball (mm)
R_outer = 20 + 0.3 * 10; % Outer radius of the dielectric shell (mm)
Q = 1; % Total charge on the conductor ball (C)
epsilon_r = 4; % Relative permittivity of the dielectric shell
epsilon_0 = 8.85e-12; % Vacuum permittivity (F/m)

% Define spatial points along the x-axis
x = linspace(0, 60, 1000); % From 0 mm to 60 mm

% Initialize electric field and electric displacement field arrays
E = zeros(size(x)); % Electric field array
D = zeros(size(x)); % Electric displacement field array

% Calculate electric field and electric displacement field
for i = 1:length(x)
    r = x(i) * 1e-3; % Convert to meters
    if r <= R_inner * 1e-3 % Inside the conductor ball
        E(i) = 0; % Electric field inside a conductor is zero
        D(i) = 0; % Electric displacement field inside a conductor is zero
    elseif r <= R_outer * 1e-3 % Inside the dielectric shell
        E(i) = Q / (4 * pi * epsilon_0 * epsilon_r * r^2); % Electric field in dielectric shell
        D(i) = Q / (4 * pi * r^2); % Electric displacement field in dielectric shell
    else % Outside the dielectric shell
        E(i) = Q / (4 * pi * epsilon_0 * r^2); % Electric field outside the dielectric shell
        D(i) = Q / (4 * pi * r^2); % Electric displacement field outside the dielectric shell
    end
end

% Convert x to mm for plotting
x_mm = x;

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

% Load experimental data
data = load('E3.txt');

% Extract X values and E-Field values
X_exp = data(:, 1); % First column
E_Field_exp = data(:, 2); % Second column

% Plot experimental data
hold on;
plot(X_exp, E_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental data
legend('Computed E-Field', 'Experimental E-Field');
hold off;

% Plot computed electric displacement field
figure;
plot(x_mm, D, 'g-', 'LineWidth', 2); % Green solid line for computed electric displacement field

% Add title and axis labels
title('D-Field vs Position (X) on X-Axis');
xlabel('Position (X) [mm]');
ylabel('D-Field (C/m^2)');

% Show grid
grid on;

% Adjust axis to fit data range
axis tight;

% Load experimental data
data = load('D3.txt');

% Extract X values and D-Field values
X_exp = data(:, 1); % First column
D_Field_exp = data(:, 2); % Second column

% Plot experimental electric field data again for comparison
hold on;
plot(X_exp, D_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental electric field
legend('Computed D-Field', 'Experimental D-Field');
hold off;

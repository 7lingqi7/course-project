% Parameters
R_inner = 10; % Inner radius of the inner conductor (mm)
R_outer = 20; % Inner radius of the outer conductor (mm)
Q_inner = 1; % Charge on the inner conductor (C)
Q_outer = -1; % Charge on the outer conductor (C)
epsilon_r1 = 2 + 0.3; % Relative permittivity of the upper half (unitless)
epsilon_r2 = 4; % Relative permittivity of the lower half (unitless)
epsilon_0 = 8.854e-12; % Vacuum permittivity (F/m)

% Define spatial points along the x-axis
x = linspace(-50, 50, 1000); % From -50 mm to 50 mm

% Initialize electric field and electric displacement field arrays
E = zeros(size(x)); % Electric field array
D = zeros(size(x)); % Electric displacement field array

% Calculate electric field and electric displacement field
for i = 1:length(x)
    r = abs(x(i)) * 1e-3; % Convert to meters
    if r <= R_inner * 1e-3 % Inside the inner conductor
        E(i) = 0; % Electric field inside a conductor is zero
        D(i) = 0; % Electric displacement field inside a conductor is zero
    elseif r <= R_outer * 1e-3 % Between inner and outer conductor
        if x(i) >= 0 % Upper half
            epsilon_r = epsilon_r1;
        else % Lower half
            epsilon_r = epsilon_r2;
        end
        E(i) = Q_inner / (2 * pi * epsilon_0 * (epsilon_r1 + epsilon_r2) * r^2*1e+6); % Electric field in dielectric shell
        D(i) = epsilon_0 * epsilon_r * E(i); % Electric displacement field in dielectric shell
    else % Beyond the outer conductor
        E(i) = 0; % Electric field outside the outer conductor is zero
        D(i) = 0; % Electric displacement field outside the outer conductor is zero
    end
end

% Convert x to mm for plotting
x_mm = x;

% Plot computed electric field
figure;
plot(x, E, 'r-', 'LineWidth', 2); % Red solid line for computed electric field

% Add title and axis labels
title('E-Field vs Position (X) on X-Axis');
xlabel('Position (X) [mm]');
ylabel('E-Field (N/C)');

% Show grid
grid on;

% Adjust axis to fit data range
axis tight;

% Load experimental electric field data
data_E =  readmatrix("E:\Homework\E4.txt"); % Use load to read the data

% Extract X values and E-Field values
X_exp_E = data_E(:, 1); % First column
E_Field_exp = data_E(:, 2); % Second column

% Plot experimental electric field data
hold on;
plot(X_exp_E, E_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental electric field
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

% Load experimental electric displacement field data
data_D =  readmatrix("E:\Homework\D4.txt"); % Use load to read the data

% Extract X values and D-Field values
X_exp_D = data_D(:, 1); % First column
D_Field_exp = data_D(:, 2); % Second column

% Plot experimental electric displacement field data
hold on;
plot(X_exp_D, D_Field_exp, 'b--', 'LineWidth', 2); % Blue dashed line for experimental electric displacement field
legend('Computed D-Field', 'Experimental D-Field');
hold off;


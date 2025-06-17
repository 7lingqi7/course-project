% Parameter settings
T = 2*pi; % Set the period to 2π, which is the basic period of the square wave signal
omega = 2*pi/T; % Compute the angular frequency, which is the basic angular frequency of the square wave in its frequency domain representation
N = 100; % Set the number of terms in the Fourier series, which determines the approximation accuracy of the square wave
t = linspace(-pi, pi, 1000); % Create a time vector ranging from -π to π with 1000 points, used to plot the signal

% Original square wave signal
x = double(abs(t) <= pi/2); % Generate the square wave signal, with high level (1) in the middle and low level (0) on the sides

% Fourier series approximation
x_approx = zeros(size(t)); % Initialize the Fourier approximation signal array, same size as time vector t
for n = 1:2:N % For odd terms from 1 to N
    x_approx = x_approx + (2/(n*pi)) * sin(n * omega * t); % Calculate the contribution of each term using the Fourier series formula and accumulate
end

% Plotting
figure;
plot(t, x, 'LineWidth', 2);
hold on;
plot(t, x_approx, 'r--', 'LineWidth', 1.5);
xlabel('Time (t)');
ylabel('Signal Amplitude');
legend('Original Signal', 'Fourier Approximation');
title('Gibbs Phenomenon Demonstration');
grid on;

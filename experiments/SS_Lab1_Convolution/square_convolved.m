% Initialisation
clc;
close all;

% Relevant parameters
frequency = 1e+4;
amplitude = 5;
offset = 1;
C = 1e-8;
R = 2.2e3;

% Time vector from -250 us to 250 us
t = linspace(-250e-6, 250e-6, 1000); % Increased number of points for better resolution
x = amplitude * square(2 * pi * frequency * t, 50) + offset; % Use 2*pi*f for the period

% Define the impulse response of an RC circuit
h = 1 / (R * C) * exp(-t / (R * C));

% Convolution of the input signal with the impulse response
y = conv(h, x, "same");

% Normalize the convolution result
y = y / max(abs(y));

% Create a figure
figure;

% Plotting the impulse response h on the first subplot
subplot(2,1,1); 
plot(t, h);
title('Impulse Response h(t)');
xlabel('Time (s)');
ylabel('Amplitude');
axis tight; % Tighten the axis around the plotted data

% Plotting the original square signal x and the convolved signal y result on the second subplot
subplot(2,1,2); % Selects the second subplot
plot(t, x, 'b', t, y, 'r--'); % 'b' for blue solid line, 'r--' for red dashed line
legend('Original Square Wave Signal y(t)', 'Convolved Signal Result(t)');
title('Original Square Wave Signal and Convolved Signal');
xlabel('Time (s)');
ylabel('Amplitude');
axis tight; % Tighten the axis around the plotted data

% Dynamically adjust the y-axis limits based on both y and x
combined_min = min(min(x), min(y)); % Find the minimum value of both signals
combined_max = max(max(x), max(y)); % Find the maximum value of both signals

% Set y-axis limits with some padding for better visibility
padding = 0.1 * (combined_max - combined_min); % 10% padding
ylim([combined_min - padding, combined_max + padding]);


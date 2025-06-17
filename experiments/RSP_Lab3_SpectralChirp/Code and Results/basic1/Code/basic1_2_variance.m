clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
signalLength = 2;  % Duration of signal in seconds
sampleRate = 1000;  % Fixed sample rate
fftLength = 512;  % Fixed FFT length

% Noise variance values to evaluate
sigma2_values = [0.01, 0.1, 1];  % Array of noise variance values

% Set up the figure
figure;
set(gcf, 'Position', [200, 200, 2000, 600]);  % Set the figure window position and size

% Generate and analyze the signal with different noise variances
for i = 1:length(sigma2_values)
    sigma2 = sigma2_values(i);
    timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

    % Signal Definition
    signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(sigma2) * randn(size(timeVector));

    % Plot the periodogram
    subplot(1, 3, i);
    periodogram(signal, rectwin(length(signal)), fftLength, sampleRate, 'power');
    title(['Power Spectrum with \sigma^2 = ', num2str(sigma2)], 'FontSize', 14, 'FontName', 'Times New Roman');
    xlabel('Normalized Frequency (rad/sample)', 'FontName', 'Times New Roman');
    ylabel('Power/Frequency (dB/(rad/sample))', 'FontName', 'Times New Roman');
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
end

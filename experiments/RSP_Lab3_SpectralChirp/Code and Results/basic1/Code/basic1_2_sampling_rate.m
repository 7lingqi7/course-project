clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLength = 2;  % Duration of signal in seconds

% Sampling rates to evaluate
sampleRates = [300, 400, 600];  % Array of sampling rates

% Set up the figure
figure;
set(gcf, 'Position', [200, 200, 2000, 400]);  % Set the figure window position and size

% Generate and analyze the signal at different sampling rates
for i = 1:length(sampleRates)
    sampleRate = sampleRates(i);
    timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

    % Signal Definition
    signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));

    % Plot the periodogram
    subplot(1, 3, i);
    periodogram(signal, rectwin(length(signal)), [], sampleRate, 'power');
    title(['Power Spectrum at Fs = ', num2str(sampleRate), ' Hz'], 'FontSize', 14, 'FontName', 'Times New Roman');
    xlabel('Normalized Frequency (rad/sample)', 'FontName', 'Times New Roman');
    ylabel('Power/Frequency (dB/(rad/sample))', 'FontName', 'Times New Roman');
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
end


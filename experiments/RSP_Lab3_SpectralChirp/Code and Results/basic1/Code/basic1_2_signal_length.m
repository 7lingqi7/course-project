clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLengths = [1, 2, 4];  % Array of different signal lengths in seconds

% Sampling
sampleRate = 1000;  % Fixed sample rate

% Set up the figure
figure;
set(gcf, 'Position', [200, 200, 2000, 600]);  % Set the figure window position and size

% Generate and analyze the signal at different signal lengths
for i = 1:length(signalLengths)
    signalLength = signalLengths(i);
    timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

    % Signal Definition
    signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));

    % Plot the periodogram
    subplot(1, 3, i);
    periodogram(signal, rectwin(length(signal)), [], sampleRate, 'power');
    title(['Power Spectrum at T = ', num2str(signalLength), ' s'], 'FontSize', 14, 'FontName', 'Times New Roman');
    xlabel('Normalized Frequency (rad/sample)', 'FontName', 'Times New Roman');
    ylabel('Power/Frequency (dB/(rad/sample))', 'FontName', 'Times New Roman');
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
end

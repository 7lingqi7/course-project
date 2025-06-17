clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLength = 2;  % Duration of signal in seconds

% Sampling
sampleRate = 1000;  % Fixed sample rate

% FFT lengths to evaluate
fftLengths = [256, 512, 1024];  % Array of FFT lengths

% Set up the figure
figure;
set(gcf, 'Position', [200, 200, 2000, 600]);  % Set the figure window position and size

% Generate and analyze the signal at different FFT lengths
for i = 1:length(fftLengths)
    fftLength = fftLengths(i);
    timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

    % Signal Definition
    signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));

    % Plot the periodogram
    subplot(1, 3, i);
    periodogram(signal, rectwin(length(signal)), fftLength, sampleRate, 'power');
    title(['Power Spectrum with FFT Length = ', num2str(fftLength)], 'FontSize', 14, 'FontName', 'Times New Roman');
    xlabel('Normalized Frequency (rad/sample)', 'FontName', 'Times New Roman');
    ylabel('Power/Frequency (dB/(rad/sample))', 'FontName', 'Times New Roman');
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
end

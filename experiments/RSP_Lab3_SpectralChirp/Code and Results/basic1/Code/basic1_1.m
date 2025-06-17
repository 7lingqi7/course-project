clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLength = 2;  % Duration of signal in seconds

% Sampling
sampleRate = 2 * w2 / pi + 1;  % Sample rate, chosen to satisfy Nyquist criterion for the highest frequency component
timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

% Signal Definition
signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));

%% Periodogram Analysis with Different Windows
windows = {'rectwin', 'hamming', 'hann', 'blackman'};
windowTitles = {'Rectangular', 'Hamming', 'Hann', 'Blackman'};
figure;

for i = 1:length(windows)
    % Generate window vector
    windowVector = feval(windows{i}, length(signal));
    
    % Compute Power Spectral Density (PSD)
    [powerSpectralDensity, frequency] = periodogram(signal, windowVector, [], sampleRate, 'power');

    % Plotting
    subplot(2, 2, i);  % Adjust subplot for four windows
    semilogy(frequency, powerSpectralDensity);
    title([windowTitles{i}, ' Window']);
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (dB/Hz)');
    grid on;
end

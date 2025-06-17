clear all;
clc;

rng(42);  % For reproducibility

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLength = 2;  % Duration of signal in seconds
numTrials = 100;  % Number of trials

% Sampling
sampleRate = 777;  % Sampling rate, chosen to satisfy Nyquist criterion for the highest frequency component
timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

% Storage for periodogram results
Pxx_all = zeros(numTrials, length(timeVector));

% Run M times
for trial = 1:numTrials
    % Generate interference frequency omegaI
    omegaI = (50 + (80-50) * rand) * pi;
    
    % Signal Definition
    signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + 4 * cos(omegaI * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));
    
    % Compute Custom Periodogram
    [powerSpectralDensity, frequency] = myPeriodogram(signal, sampleRate);
    
    % Store periodogram results
    Pxx_all(trial, :) = powerSpectralDensity;
    
    % Plot periodogram for specific trials
    if trial == 1 || trial == 50 || trial == 100
        figure;
        plot(frequency, 10 * log10(powerSpectralDensity));
        title(['Periodogram of Run ' num2str(trial)]);
        xlabel('Frequency (Hz)');
        ylabel('Power Spectral Density (dB/Hz)');
        grid on;
    end
end

% Compute average power spectrum
Pxx_mean = mean(Pxx_all, 1);

% Plot average power spectrum
figure;
plot(frequency, 10 * log10(Pxx_mean));
title('Average Power Spectrum over 100 Runs');
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB/Hz)');
grid on;

%% Custom Periodogram Function
function [powerSpectralDensity, frequency] = myPeriodogram(signal, sampleRate)
    N = length(signal);
    X = fft(signal);
    powerSpectralDensity = (1/N) * abs(X).^2;
    frequency = (0:(N-1)) * (sampleRate / N);
end

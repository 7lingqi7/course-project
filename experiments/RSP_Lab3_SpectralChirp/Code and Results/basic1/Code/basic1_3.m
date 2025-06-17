clear all;
clc;

% Signal Parameters
w1 = 100 * pi;  % Angular frequency for the sine component (rad/s)
w2 = 150 * pi;  % Angular frequency for the cosine component (rad/s)
noiseVariance = 0.1;  % Variance of white Gaussian noise
signalLength = 2;  % Duration of signal in seconds

% Sampling
sampleRate = 777;  % Sampling rate, at least twice the highest frequency
timeVector = 0:1/sampleRate:signalLength-1/sampleRate;  % Time vector for sampling

% Signal Definition
signal = sin(w1 * timeVector) + 2 * cos(w2 * timeVector) + sqrt(noiseVariance) * randn(size(timeVector));

%% Custom Periodogram and Correlogram Computation
[powerSpectralDensity_custom, frequency_custom] = myPeriodogram(signal, sampleRate);
[powerSpectralDensity_corr, frequency_corr] = myCorrelogram(signal, sampleRate);

%% Default Periodogram Computation
[powerSpectralDensity_default, frequency_default] = periodogram(signal, [], [], sampleRate, 'power');

%% Default Autocorrelation Computation
[autocorrelation, lags] = xcorr(signal, 'biased');
autocorrelation = autocorrelation(lags >= 0);  % Keep only non-negative lags
N = length(signal);
frequency_acf = (0:(N-1)) * (sampleRate / (2 * N));
powerSpectralDensity_acf = abs(fft(autocorrelation));

%% Plot Comparison of Periodograms
figure;
plot(frequency_custom(1:N/2), 10 * log10(powerSpectralDensity_custom(1:N/2)), 'm', 'DisplayName', 'Custom Periodogram');
hold on;
plot(frequency_default, 10 * log10(powerSpectralDensity_default), 'g', 'DisplayName', 'Default Periodogram');
title('Comparison of Custom and Default Periodogram Functions');
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB/Hz)');
legend;
grid on;
hold off;

%% Plot Comparison of Correlograms
figure;
plot(frequency_corr, 10 * log10(powerSpectralDensity_corr), 'm', 'DisplayName', 'Custom Correlogram');
hold on;
plot(frequency_acf, 10 * log10(powerSpectralDensity_acf), 'g', 'DisplayName', 'Default Correlogram');
title('Comparison of Custom and Default Correlogram Functions');
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB/Hz)');
legend;
grid on;
hold off;

%% Custom Periodogram Function
function [powerSpectralDensity, frequency] = myPeriodogram(signal, sampleRate)
    N = length(signal);
    X = fft(signal);
    powerSpectralDensity = (1/N) * abs(X).^2;
    frequency = (0:(N-1)) * (sampleRate / N);
end

%% Custom Correlogram Function
function [powerSpectralDensity, frequency] = myCorrelogram(signal, sampleRate)
    N = length(signal);
    autocorrelation = xcorr(signal, 'biased');
    autocorrelation = autocorrelation(N:end);  % Keep only non-negative lags
    autocorrelation = autocorrelation / autocorrelation(1);  % Normalize
    X = fft(autocorrelation);
    powerSpectralDensity = abs(X);
    frequency = (0:(N-1)) * (sampleRate / (2 * N));
end

clc
clear
close all

% Signal parameters
f1 = 60;             % Frequency of the first signal (Hz)
f2 = 150;            % Frequency of the second signal (Hz)
noiseVariance = 0.1; % Variance of the Gaussian white noise
samplingRate = 1000; % Sampling rate (Hz)
duration = 4;        % Duration of the signal (seconds)
time = 0:1/samplingRate:duration-1/samplingRate;  % Time vector

% Generate the signal
x = sin(2*pi*f1*time) + 2*cos(2*pi*f2*time);  % Combined signal
n = sqrt(noiseVariance)*randn(size(time));    % Gaussian white noise
s = x + n;                                    % Signal with noise

% Plot the original and noisy signals
figure;
subplot(2,1,1);
plot(time, x);
title('Signal without noise');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2);
plot(time, s);
title('Signal with noise');
xlabel('Time (s)');
ylabel('Amplitude');

% Estimate and plot the autocorrelation function
r = xcorr(s, 'biased');
lags = -(length(r)-1)/2:(length(r)-1)/2;
figure;
subplot(2,1,1);
plot(lags/samplingRate, r);
xlabel('Lag (s)');
ylabel('Autocorrelation');
title('Autocorrelation of signal with noise');

% Estimate and plot the cross-correlation function
r = xcorr(s, n, 'coeff');
lags = -(length(r)-1)/2:(length(r)-1)/2;
subplot(2,1,2);
plot(lags/samplingRate, r);
xlabel('Lag (s)');
ylabel('Cross-correlation');
title('Cross-correlation of signal with noise and noise');





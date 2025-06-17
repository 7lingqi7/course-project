clc;
clear;
close all;
warning('off');

% Initialize parameters
M = 4;  % Number of microphones
FS = 16000;  % Sampling frequency (Hz)
c = 340;  % Speed of sound in air (m/s)
Is_add_special_noise = 0;  % Do not add special noise

% Define microphone and source positions
Loc = [0 20 0 20; 0 0 10 10];  % Microphone locations
source_loc = [1; 1];  % Source location

% Calculate distances and time delays
Rsm = sqrt(sum((source_loc - Loc).^2, 1));  % Distance from microphones to source
TD = Rsm / c;  % Time delay
L_TD = round(TD * FS);  % Convert time delays to sample delays
max_delay = max(L_TD);  % Maximum delay

% Read the original speech signal
[sig_ori, FS] = audioread('test_audio.wav');
sig_ori = sig_ori';  % Transpose the signal
Lsig = length(sig_ori);  % Length of the signal

% Define SNR values
SNR_values = [30, 10, -10];

% Loop through different SNR cases
for snr_idx = 1:length(SNR_values)
    SNR_dB = SNR_values(snr_idx);

    % Calculate signal and noise power
    signal_power = sig_ori * sig_ori' / Lsig;
    noise_power = signal_power / (10^(SNR_dB / 10));

    % Initialize received signals
    Signal_Received = zeros(M, Lsig + max_delay);

    % Add noise and apply delays for each microphone
    for p = 1:M
        noise = sqrt(noise_power) * randn(1, Lsig);
        sig_noise = sig_ori + noise;
        Signal_with_noise = [zeros(1, L_TD(p)), sig_noise, zeros(1, max_delay - L_TD(p))];
        Signal_Received(p, :) = Signal_with_noise;
    end

    % Plot the received signals from all microphones
    figure;
    plot_time = 0:1/FS:(size(Signal_Received, 2)-1)/FS;
    plot(plot_time, Signal_Received.');
    title(['Received Signals at SNR = ', num2str(SNR_dB), ' dB']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Mic 1', 'Mic 2', 'Mic 3', 'Mic 4');
    
    % Calculate cross-correlation and estimate lags
    lags = zeros(1, M-1);
    for i = 2:M
        [R, lag] = xcorr(Signal_Received(1, :), Signal_Received(i, :), max_delay);
        [~, idx] = max(R);
        lags(i-1) = lag(idx);
    end

    % Align signals correctly
    Aligned_signals = zeros(M, Lsig + max_delay);
    for i = 2:M
        Aligned_signals(i, :) = circshift(Signal_Received(i, :), lags(i-1));
    end
    Aligned_signals(1, :) = Signal_Received(1, :);  % First signal is the reference

    % Sum the aligned signals
    Correct_Sum = sum(Aligned_signals, 1);

    % Plot the correctly summed signal
    figure;
    plot(plot_time, Correct_Sum);
    title(['Correctly Summed Signal at SNR = ', num2str(SNR_dB), ' dB']);
    xlabel('Time (s)');
    ylabel('Amplitude');
end


clc;
clear all;
close all;

rng(42);  % For reproducibility

% Signal Parameters
fo = 1000;  % Initial frequency of the chirp signal (Hz)
k = 12000;  % Chirp rate (Hz/s)
T = 0.1;  % Duration of the chirp signal (s)
Fs = 100000;  % Sampling frequency (Hz)
T_full = 1;  % Duration of the full signal (s)
N_full = T_full * Fs;  % Number of samples in the full signal

numTests = 500;  % Number of tests
SNR_range = [-50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15];  % Different SNR values (dB)

% Initialize result storage
results = struct();

% Number of repetitions
num_repetitions = 3;

for snr_idx = 1:length(SNR_range)
    SNR_dB = SNR_range(snr_idx);

    % Storage for errors in each repetition
    errors = zeros(1, num_repetitions);
    estimated_end_times = zeros(1, num_repetitions);
    
    % Perform 500 tests for each SNR value
    mse_snr = 0;
    correct_count = 0;
    
    for test = 1:numTests
        % Time vector
        t = 0:1/Fs:T-1/Fs; 
        signal = cos(2*pi*(fo*t + 0.5*k*t.^2)); 
        N = length(t);  % Number of samples in the signal
    
        % Calculate noise power for the given SNR
        signal_power = (signal * signal') / N;
        noise_power = signal_power / (10^(SNR_dB/10));
    
        % Generate random start time within [0.01, 0.9] seconds
        start_time = 0.01 + (0.9 - 0.01) * rand;
        start_point = round(start_time * Fs);
    
        % Scale full noise to the required noise power
        noise_full = sqrt(noise_power) * randn(1, N_full);
        signal_noise_full = noise_full;
        signal_noise_full(start_point:start_point+N-1) = signal_noise_full(start_point:start_point+N-1) + signal;
        
        estimated_end_times = zeros(1, num_repetitions);
    
        for rep = 1:num_repetitions
    
            % Window parameters
            window_size = 0.05 * Fs;  % 50 ms window
            overlap_size = 0.025 * Fs;  % 25 ms overlap
            num_windows = floor((N_full - overlap_size) / (window_size - overlap_size));
            window_function = hanning(window_size);  % Hanning window
        
            window_energies = zeros(1, num_windows);
        
            for win_idx = 1:num_windows
                start_sample = (win_idx - 1) * (window_size - overlap_size) + 1;
                end_sample = start_sample + window_size - 1;
        
                if end_sample > N_full
                    break;
                end
        
                windowed_signal = signal_noise_full(start_sample:end_sample) .* window_function';
        
                % Calculate energy of the windowed signal
                window_energy = sum(windowed_signal.^2);
                window_energies(win_idx) = window_energy;
            end
        
            % Find the window with the maximum energy
            [~, max_energy_idx] = max(window_energies);
        
            % Ensure the estimated end time does not exceed 1 second and is at least 0.1 seconds
            estimated_end_time = max(min((max_energy_idx * (window_size - overlap_size) + window_size - 1) / Fs, 1), 0.1);
        
            % Store result
            estimated_end_times(rep) = estimated_end_time;
        end
    
        actual_end_time = start_time + 0.1;
    
        % Calculate the median of the results
        median_estimated_end_time = median(estimated_end_times);
        squared_error = (actual_end_time - median_estimated_end_time)^2;
        mse_snr = mse_snr + squared_error;
    
        if abs(actual_end_time - median_estimated_end_time) <= 0.03
            correct_count = correct_count + 1;
        end 
    end

    % Store MSE and success rate for each SNR value
    average_MSE = mse_snr / numTests;
    average_success_rate = correct_count / numTests;
    
    results(snr_idx).SNR = SNR_dB;
    results(snr_idx).Average_MSE = average_MSE;
    results(snr_idx).Average_Success_Rate = average_success_rate;
end

% Display results
for snr_idx = 1:length(SNR_range)
    fprintf('SNR: %d dB\n', results(snr_idx).SNR);
    fprintf('Average MSE: %f\n', results(snr_idx).Average_MSE);
    fprintf('Average Success Rate: %f\n\n', results(snr_idx).Average_Success_Rate);
    fprintf('----------------------\n');
end

% Extract SNR values and corresponding success rates
snr_values = [results.SNR];
success_rates = [results.Average_Success_Rate];
mse_values = [results.Average_MSE];

% Plot success rate vs. SNR
figure;
plot(snr_values, success_rates, '-o', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Success Rate');
title('Success Rate vs. SNR');
grid on;

% Plot average MSE vs. SNR
figure;
plot(snr_values, mse_values, '-o', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Average MSE');
title('Average MSE vs. SNR');
grid on;

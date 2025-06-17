clc
clear all
close all

num_microphones = 8; % Number of microphones changed to 8
distance_between_mics = 0.085; % Distance between microphones (in meters)
speed_of_sound = 340; % Speed of sound in air (in meters per second)
num_samples = 44100; % Number of samples in the signal

% Generating a list of possible Direction of Arrival (DOA) angles
doa_list = asind((-11:11) * speed_of_sound / (num_samples * distance_between_mics));

num_trials = 100; % Number of trials for each SNR value
correct_detection_count = 0;

% Initialize arrays to store accuracy and SNR values
snr_range = -10:0; % SNR range from -10 dB to 0 dB
detection_accuracy = zeros(size(snr_range));

% Load the original signal
[original_signal, FS] = audioread('test_audio.wav');
original_signal = original_signal';
signal_length = length(original_signal);
time_step = 1 / num_samples;
time_vector = 0:time_step:(signal_length - 1) * time_step;

for snr_idx = 1:length(snr_range)
    snr_dB = snr_range(snr_idx);
    correct_detection_count = 0;

    rng(42); % Seed for reproducibility

    for trial = 1:num_trials
        random_index = randperm(length(doa_list), 1);
        actual_theta = doa_list(random_index);
        
        % Calculate the distance from the source to each microphone
        delta_distance = distance_between_mics * sin(deg2rad(abs(actual_theta))); 
    
        % Set Rsm based on theta
        if actual_theta > 0
            if delta_distance == 0
                mic_distances = zeros(1, 8);
            else
                mic_distances = (num_microphones - 1) * delta_distance : -delta_distance : 0;
            end
        else
            if delta_distance == 0
                mic_distances = zeros(1, 8);
            else
                mic_distances = 0 : delta_distance : (num_microphones - 1) * delta_distance;
            end
        end
        
        % Calculate Time Delays (TD) for each microphone
        time_delays = mic_distances / speed_of_sound;
        sample_delays = time_delays / time_step;
        sample_delays = round(sample_delays);
        
        received_signals = [];
        signal_end = signal_length - max(sample_delays);
        signal_power = original_signal * original_signal' / signal_length; % Calculate signal power
        noise_power = signal_power / (10^(snr_dB / 10)); % Calculate noise power
        
        % Generate noisy signals received by each microphone
        for mic = 1:num_microphones    
            noise = sqrt(noise_power) * randn(1, signal_length);    
            signal_with_noise = original_signal + noise;
            noisy_signal = [sqrt(noise_power) * randn(1, sample_delays(mic)), signal_with_noise, sqrt(noise_power) * randn(1, max(sample_delays) - sample_delays(mic))]; 
            received_signals = [received_signals; noisy_signal];
        end
        
        % Estimate Time Delays using cross-correlation
        max_lag = 66; % Maximum lag for cross-correlation
        lag_estimates = zeros(1, num_microphones-1);
        for i = 2:num_microphones-1
            [correlation, ~] = xcorr(received_signals(i, :), received_signals(i+1, :), max_lag , 'coeff');
            [~, idx] = max(correlation);
            lag_estimates(i-1) = idx - (max_lag + 1);
        end  
        
        % Determine the most probable lag (delay)
        probable_lag = mode(lag_estimates);
        
        % Estimate direction of arrival (DOA)
        estimated_distance = probable_lag * speed_of_sound / num_samples; % Convert lag to distance
        estimated_theta = asind(estimated_distance / distance_between_mics); % Calculate estimated angle
        angle_error = abs(actual_theta - estimated_theta);
        
        % Check if the estimated angle is within tolerance
        tolerance = 1e-6;
        if angle_error < tolerance
            correct_detection_count = correct_detection_count + 1;    
        end
    end

    % Calculate accuracy percentage
    detection_accuracy(snr_idx) = 100 * correct_detection_count / num_trials;
end

% Output all accuracy information
for snr_idx = 1:length(snr_range)
    disp(['Accuracy at SNR ', num2str(snr_range(snr_idx)), ' dB: ', num2str(detection_accuracy(snr_idx))]);
end

% Plot the line chart
plot(snr_range, detection_accuracy, '-o');
xlabel('SNR (dB)');
ylabel('Accuracy');
title('Accuracy vs SNR');





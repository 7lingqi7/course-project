clc; 
clear all; 
close all;  

% Parameters
num_mics = 2;  % Number of microphones
mic_distance = 0.085;  % Distance between microphones (meters)
sound_speed = 340;  % Speed of sound (m/s)
sample_rate = 44100;  % Sampling rate (Hz)
num_trials = 200;  % Number of trials

% Generate a list of possible directions of arrival (DOAs)
doa_angles = asind((-11:11) * sound_speed / (sample_rate * mic_distance));

% Read the original audio signal from a file
[sig_original, Fs] = audioread('test_audio.wav');
sig_original = sig_original';  % Transpose the signal matrix to make it a row vector
signal_length = length(sig_original);  % Length of the signal
time_step = 1 / sample_rate;  % Sampling interval
time_vector = 0:time_step:(signal_length - 1) * time_step;  % Time vector

% Initialize arrays to store SNR and accuracy
SNR_values = -10:10;
accuracy = zeros(size(SNR_values));

% Loop over each SNR value
for snr_idx = 1:length(SNR_values)  % Loop over each SNR value
    SNR_dB = SNR_values(snr_idx);  % Set SNR value for the current iteration
    correct_count = 0;  % Counter for correct DOA estimations

    rng(42);  % Set the seed for random number generation

    for trial = 1:num_trials  % Start trial loop
        random_index = randperm(length(doa_angles), 1);  % Randomly select a DOA angle
        true_theta = doa_angles(random_index);  % The randomly selected DOA angle

        % Calculate the distance of the sound source from the first microphone
        r = mic_distance * sin(deg2rad(abs(true_theta))); 
        % Determine the position of the sound source relative to the microphones
        if true_theta > 0
            distances = [r, 0];
        else
            distances = [0, r];
        end

        % Calculate time difference of arrival (TDoA)
        time_delays = distances / sound_speed;
        % Convert TDoA to the number of samples
        sample_delays = round(time_delays / time_step);

        % Initialize the received signal array
        Signal_Received = zeros(num_mics, signal_length + max(sample_delays));
        % Calculate the power of the signal
        signal_power = mean(sig_original.^2);
        % Calculate the power of the noise based on the SNR
        noise_power = signal_power / (10^(SNR_dB / 10));

        % Loop over each microphone to generate the signal with noise
        for mic = 1:num_mics    
            % Generate white Gaussian noise
            noise = sqrt(noise_power) * randn(1, signal_length);    
            % Add noise to the original signal
            noisy_signal = sig_original + noise;
            % Construct the signal with noise and delays for each microphone
            delayed_signal = [sqrt(noise_power) * randn(1, sample_delays(mic)), noisy_signal, sqrt(noise_power) * randn(1, max(sample_delays) - sample_delays(mic))];
            % Append the constructed signal to the received signal array
            Signal_Received(mic, :) = delayed_signal;
        end

        % Extract signals for each microphone
        x1 = Signal_Received(1, :);  % Signal for microphone 1
        x2 = Signal_Received(2, :);  % Signal for microphone 2

        % Define the maximum lag for cross-correlation
        max_lag = 11;             
        % Compute the cross-correlation between the signals from the two microphones
        [R, lags] = xcorr(x1, x2, max_lag, 'coeff');

        % Find the maximum value of the cross-correlation
        [~, max_index] = max(R);
        % Estimate the lag between the two microphone signals
        estimated_lag = lags(max_index);

        % Estimate the direction of arrival (DOA)
        % Convert the estimated lag to distance
        estimated_distance = estimated_lag * sound_speed / sample_rate;
        % Calculate the estimated angle of arrival
        estimated_theta = asind(estimated_distance / mic_distance);

        % Calculate the absolute error between the actual and estimated DOA
        error = abs(true_theta - estimated_theta);
        % Define a tolerance level for considering the DOA estimation correct
        tolerance = 1e-6;
        % If the error is within the tolerance, increment the count of correct estimations
        if error < tolerance
            correct_count = correct_count + 1;    
        end
    end  % End trial loop

    % Calculate accuracy for the current SNR
    accuracy(snr_idx) = 100 * correct_count / num_trials;
end

% Plot the accuracy versus SNR
figure;
plot(SNR_values, accuracy, '-o');
xlabel('SNR (dB)');
ylabel('Accuracy (%)');
title('DOA Estimation Accuracy vs. SNR');
grid on;

% Output accuracy for each SNR
disp('Accuracy for each SNR:');
disp(table(SNR_values', accuracy', 'VariableNames', {'SNR_dB', 'Accuracy_Percent'}));



               
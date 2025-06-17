clear all;
clc;

rng(42); % For reproducibility

% Signal Parameters
f0 = 1000;  % Initial frequency (Hz)
k = 12000;  % Frequency change rate (Hz/s)
tmin = 0;  % Signal start time (s)
tmax = 0.1;  % Signal end time (s)

sampleRate = 50000;  % Sampling frequency (Hz)
delay_min = 0.11;  % Minimum delay time (s)
delay_max = 1;  % Maximum delay time (s)

numTrials = 777;  % Number of trials
SNR_dB_list = [-50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15];  % Different SNR values (dB)

% Time vector
timeVector = tmin:(1/sampleRate):tmax-1/sampleRate;

% Generate chirp signal X(t)
signal = cos(2 * pi * (f0 * timeVector + k * timeVector.^2));

% Initialize result storage
results = struct();

% Perform multiple tests
for snr_idx = 1:length(SNR_dB_list)
    SNR_dB = SNR_dB_list(snr_idx);
    K = 0;
    MSE = zeros(1, numTrials);
    
    for trial = 1:numTrials
        % Randomly generate delay time
        delay = delay_min + (delay_max - delay_min) * rand;
        
        % Calculate true end time
        true_end_time = delay + tmax;
  
        % Calculate noise power given the SNR
        signalPower = rms(signal)^2;
        noisePower = signalPower / (10^(SNR_dB/10));

        % Generate received signal with noise
        receivedSignal = [zeros(1, round(delay * sampleRate)), signal];  % Delayed signal plus original signal
        receivedSignal = receivedSignal + sqrt(noisePower) * randn(size(receivedSignal));

        % Matched filter
        matchedFilterResponse = conv(receivedSignal, fliplr(signal));
        
        % Find the time index corresponding to the maximum value of the filter output
        [~, max_index] = max(abs(matchedFilterResponse));
        
        % Calculate the estimated end time
        estimated_end_time = (max_index - length(signal) + 1) / sampleRate + tmax;
        
        % Calculate estimation error
        estimationError = abs(estimated_end_time - true_end_time);

        % Calculate success rate
        if estimationError < 0.03
            K = K + 1;
        end
       
        MSE(trial) = (estimated_end_time - true_end_time)^2;
    end
    
    % Calculate average MSE and success rate
    average_MSE = mean(MSE);
    average_success_rate = K / numTrials;
    
    % Store results
    results(snr_idx).SNR_dB = SNR_dB;
    results(snr_idx).Average_MSE = average_MSE;
    results(snr_idx).Average_Success_Rate = average_success_rate;
    results(snr_idx).MatchedFilterResponse = matchedFilterResponse;  % Store matched filter output for the last run
end

% Display results
for snr_idx = 1:length(SNR_dB_list)
    fprintf('SNR: %d dB\n', results(snr_idx).SNR_dB);
    fprintf('Average MSE: %f\n', results(snr_idx).Average_MSE);
    fprintf('Average Success Rate: %f\n\n', results(snr_idx).Average_Success_Rate);
    fprintf('----------------------\n');
end

% Extract SNR values and corresponding success rates
snr_values = [results.SNR_dB];
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

% Plot time-domain matched filter responses for selected SNR values
snr_to_plot = [-40, 15];
for snr_idx = 1:length(SNR_dB_list)
    if any(SNR_dB_list(snr_idx) == snr_to_plot)
        figure;
        matchedFilterResponse = results(snr_idx).MatchedFilterResponse;
        matchedFilterLength = length(matchedFilterResponse);
        time_vector = (0:matchedFilterLength-1) / sampleRate;
        plot(time_vector, matchedFilterResponse);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(['Time-domain Matched Filter Response (SNR = ', num2str(SNR_dB_list(snr_idx)), ' dB)']);
        grid on;
    end
end

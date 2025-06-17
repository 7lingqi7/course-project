clc;
clear;
close all;

% Parameters
true_frequency = 99.99;             % Signal frequency (Hz)
Fs = 1000;                        % Sampling frequency (Hz)
T = 1 / Fs;                       % Sampling period
duration = 1;                     % Signal duration (seconds)
time = 0:T:duration-T;            % Time vector
theta = 0;                        % Phase shift
sigma_squared_values = [0.05, 0.5, 1, 5, 10]; % Variance of the Gaussian noise

% Number of independent runs for accuracy testing
num_runs = 100;

% Initialize storage for frequency estimates
frequency_estimates = zeros(num_runs, length(sigma_squared_values));

% Generate signal and estimate frequency for different noise levels
for j = 1:length(sigma_squared_values)
    sigma_squared = sigma_squared_values(j);
    fprintf('Noise variance: %.2f\n', sigma_squared);
    
    for i = 1:num_runs
        % Generate sinusoidal signal with Gaussian noise
        N = sqrt(sigma_squared) * randn(size(time)); % Gaussian noise
        X = sin(2*pi*true_frequency*time + theta) + N; % Sinusoidal signal with noise
        
        % Autocorrelation
        autocorr_X = xcorr(X, 'coeff');
        
        % Estimate signal frequency using autocorrelation
        [~, locs] = findpeaks(autocorr_X);
        
        % Calculate the number of points between adjacent peaks
        if length(locs) > 1
            N_points = mean(diff(locs));
            
            % Estimate signal period
            period = N_points * T;
            
            % Estimate signal frequency
            estimated_frequency = 1 / period;
            frequency_estimates(i, j) = estimated_frequency;
        else
            frequency_estimates(i, j) = NaN; % If not enough peaks found
        end
    end
    
    % Plot autocorrelation for one run
    figure;
    plot(autocorr_X);
    title(['Autocorrelation with \sigma^2 = ', num2str(sigma_squared)]);
    xlabel('Lag');
    ylabel('Autocorrelation');
end

% Calculate accuracy statistics
mean_estimates = mean(frequency_estimates, 'omitnan');
std_estimates = std(frequency_estimates, 'omitnan');

% Display results
disp('Frequency estimation results:');
result_table = table(sigma_squared_values', mean_estimates', std_estimates', ...
    'VariableNames', {'NoiseVariance', 'MeanEstimate', 'StdEstimate'});
disp(result_table);

% Plot results
figure;
errorbar(sigma_squared_values, mean_estimates, std_estimates, 'o-');
title('Frequency Estimation Accuracy');
xlabel('Noise Variance (\sigma^2)');
ylabel('Estimated Frequency (Hz)');
grid on;

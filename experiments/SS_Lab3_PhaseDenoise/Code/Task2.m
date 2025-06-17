% Load the audio file
[x1, fs] = audioread('segment_music.wav');

% Resample to 16 kHz
if fs ~= 16000
    x1 = resample(x1, 16000, fs);
    fs = 16000;
end

% Convert to mono if stereo
if size(x1, 2) > 1
    x1 = mean(x1, 2);
end

% Generate white noise
len = length(x1);
noise = randn(len, 1);

% Define SNR values
SNRs = [10, 0, -10];

% Initialize cell arrays to store results
noisy_signals = cell(length(SNRs), 1);
denoised_signals_freq = cell(length(SNRs), 1);
denoised_signals_time = cell(length(SNRs), 1);

% Loop over SNR values
for i = 1:length(SNRs)
    SNR = SNRs(i);
    noise_power = var(x1) / (10^(SNR / 10));
    noise_scaled = sqrt(noise_power) * noise;
    noisy_signal = x1 + noise_scaled;
    noisy_signals{i} = noisy_signal;
    
    % Fourier Transform of noisy signal
    Y = fft(noisy_signal);
    f = (0:length(Y)-1) * fs / length(Y); % Frequency vector
    
    % Design a simple low-pass filter in the frequency domain
    cutoff_freq = 3000; % Cutoff frequency in Hz
    H = double(f <= cutoff_freq); % Frequency domain filter
    
    % Apply the filter
    Y_filtered = Y .* H';
    denoised_signal_freq = ifft(Y_filtered);
    denoised_signals_freq{i} = real(denoised_signal_freq); % Get real part

    % Design a similar low-pass filter in the time domain
    order = 100; % Filter order
    b = fir1(order, cutoff_freq/(fs/2)); % Low-pass FIR filter
    
    % Apply the time domain filter
    denoised_signal_time = filter(b, 1, noisy_signal);
    denoised_signals_time{i} = denoised_signal_time;
    
    % Plot waveforms
    t = (0:length(x1)-1) / fs;
    figure;
    subplot(3, 1, 1);
    plot(t, x1);
    title('Original Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(3, 1, 2);
    plot(t, noisy_signal);
    title(['Noisy Signal (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(3, 1, 3);
    plot(t, denoised_signals_freq{i});
    title('Denoised Signal (Frequency Domain)');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Plot time-domain denoising result
    figure;
    subplot(2, 1, 1);
    plot(t, noisy_signal);
    title(['Noisy Signal (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(2, 1, 2);
    plot(t, denoised_signals_time{i});
    title('Denoised Signal (Time Domain)');
    xlabel('Time (s)');
    ylabel('Amplitude');
end

% Play the original audio
disp('Playing original audio...');
sound(x1, fs);
pause(length(x1) / fs + 2); % Pause to allow full playback

% Play the noisy audio signals
for i = 1:length(SNRs)
    disp(['Playing noisy audio with SNR = ', num2str(SNRs(i)), ' dB...']);
    sound(noisy_signals{i}, fs);
    pause(length(noisy_signals{i}) / fs + 2); % Pause to allow full playback
end

% Play the frequency domain denoised audio signals
for i = 1:length(SNRs)
    disp(['Playing frequency domain denoised audio with SNR = ', num2str(SNRs(i)), ' dB...']);
    sound(denoised_signals_freq{i}, fs);
    pause(length(denoised_signals_freq{i}) / fs + 2); % Pause to allow full playback
end

% Play the time domain denoised audio signals
for i = 1:length(SNRs)
    disp(['Playing time domain denoised audio with SNR = ', num2str(SNRs(i)), ' dB...']);
    sound(denoised_signals_time{i}, fs);
    pause(length(denoised_signals_time{i}) / fs + 2); % Pause to allow full playback
end



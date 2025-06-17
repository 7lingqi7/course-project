% Load the audio file with any sample rate
[x1, fs] = audioread('segment_music2.wav');

% If the sample rate is not 16 kHz, resample it to 16 kHz
if fs ~= 16000
    disp(['Resampling from ', num2str(fs), ' Hz to 16000 Hz...']);
    x1 = resample(x1, 16000, fs);
    fs = 16000; % Update the sample rate to 16 kHz
end

% Continue with the rest of the code
t = (0:length(x1)-1) / fs; % Time vector for plotting

% Reverse the audio signal
x1_reversed = flipud(x1);

% Play the original and reversed audio
disp('Playing original audio...');
sound(x1, fs);
pause(length(x1) / fs + 2);

disp('Playing reversed audio...');
sound(x1_reversed, fs);
pause(length(x1_reversed) / fs + 2);

% Plot the original and reversed audio for visualization
figure;
subplot(2, 1, 1);
plot(t, x1);
title('Original Audio Signal x_1(t)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, x1_reversed);
title('Reversed Audio Signal x_1(-t)');
xlabel('Time (s)');
ylabel('Amplitude');

% Divide into frames, reverse each frame, and reassemble
frame_lengths = [2000, 1000, 500, 250, 125, 62];
for i = 1:length(frame_lengths)
    l = frame_lengths(i);
    num_frames = floor(length(x1) / l);
    x2 = zeros(size(x1));

    for k = 1:num_frames
        frame_start = (k - 1) * l + 1;
        frame_end = k * l;
        frame = x1(frame_start:frame_end);
        frame_reversed = flipud(frame);
        x2(frame_start:frame_end) = frame_reversed;
    end

    disp(['Playing audio with frame length of ', num2str(l), ' samples...']);
    sound(x2, fs);
    pause(length(x2) / fs + 2);
end


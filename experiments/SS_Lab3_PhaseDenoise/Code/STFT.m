% Load the audio file with any sample rate
[x1, fs] = audioread('segment_music2.wav');

% If the sample rate is not 16 kHz, resample it to 16 kHz
if fs ~= 16000
    disp(['Resampling from ', num2str(fs), ' Hz to 16000 Hz...']);
    x1 = resample(x1, 16000, fs);
    fs = 16000; % Update the sample rate to 16 kHz
end

% If the audio is stereo, convert it to mono by averaging the two channels
if size(x1, 2) > 1
    disp('Converting stereo to mono by averaging the channels...');
    x1 = mean(x1, 2); % Convert to mono by averaging the two channels
end

% Define frame lengths to test
frame_lengths = [2000, 1000, 500, 250, 125, 62];

% Plotting the STFT results for each frame length
figure;
for i = 1:length(frame_lengths)
    l = frame_lengths(i);
    num_frames = floor(length(x1) / l);
    x2 = zeros(size(x1));

    for k = 1:num_frames
        frame_start = (k - 1) * l + 1;
        frame_end = k * l;
        frame = x1(frame_start:frame_end);
        
        % Reverse the frame
        frame_reversed = flipud(frame);
        x2(frame_start:frame_end) = frame_reversed;
    end

    % If the processed audio is stereo, convert it to mono
    if size(x2, 2) > 1
        x2 = mean(x2, 2);
    end

    % Plot the STFT of the processed signal
    subplot(length(frame_lengths), 1, i);
    spectrogram(x2, hamming(l), [], [], fs, 'yaxis');
    title(['STFT of Processed Audio Signal - Frame Length: ', num2str(l), ' samples']);
end

% Adjust figure properties
sgtitle('STFT of Processed Audio Signal for Different Frame Lengths');


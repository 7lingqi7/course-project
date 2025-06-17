% Step 1: Read the audio file
[originalAudio, fs] = audioread('music2.flac'); % 'input_audio_file.wav' is the path and name of the audio file

% Step 2: Calculate sample indices for the desired segment
start_time = 1; % Start time in seconds (2 minutes and 7 seconds)
end_time = 6;  % End time in seconds (2 minutes and 12 seconds)

start_sample = round(start_time * fs); % Calculate the starting sample index
end_sample = round(end_time * fs);     % Calculate the ending sample index

% Step 3: Extract the audio segment
audio_segment = originalAudio(start_sample:end_sample, :); % Extract the segment from the original audio

% Step 4: Save the extracted audio segment
audiowrite('segment_music2.wav', audio_segment, fs); % Save the segment as a new file 'output_audio_segment.wav'

% Display completion message
disp('The audio segment has been successfully saved as segment_music2.wav');

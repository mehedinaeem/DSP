clc;
clear;
close all;

% Load speech audio file
[audio, fs] = audioread('speech.wav');

% Convert stereo audio to mono
if size(audio, 2) > 1
    audio = mean(audio, 2);
end

% Create time vector
t = (0:length(audio)-1) / fs;

% Display audio information
fprintf('Sampling frequency = %d Hz\n', fs);
fprintf('Number of samples = %d\n', length(audio));
fprintf('Audio duration = %.2f seconds\n', length(audio)/fs);

% -----------------------------
% Design speech band-pass filter
% -----------------------------

% Keep frequencies approximately from 300 Hz to 3400 Hz
low_cutoff = 300;
high_cutoff = 3400;

% Normalize cutoff frequencies
Wn = [low_cutoff high_cutoff] / (fs/2);

% Design Butterworth band-pass filter
filter_order = 4;
[b, a] = butter(filter_order, Wn, 'bandpass');

% Apply filtering
filtered_audio = filtfilt(b, a, audio);

% -----------------------------
% Plot time-domain signals
% -----------------------------

figure;

subplot(2,1,1);
plot(t, audio);
title('Original Speech Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, filtered_audio);
title('Filtered Speech Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% -----------------------------
% STFT of original speech
% -----------------------------

figure;

subplot(2,1,1);
spectrogram(audio, hamming(256), 128, 512, fs, 'yaxis');
title('STFT Spectrogram of Original Speech');

% -----------------------------
% STFT of filtered speech
% -----------------------------

subplot(2,1,2);
spectrogram(filtered_audio, hamming(256), 128, 512, fs, 'yaxis');
title('STFT Spectrogram of Filtered Speech');

% -----------------------------
% Play audio
% -----------------------------

disp('Playing original speech...');
sound(audio, fs);

pause(length(audio)/fs + 1);

disp('Playing filtered speech...');
sound(filtered_audio, fs);

drawnow;
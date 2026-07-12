clc;
clear;
close all;

% Sampling frequency
fs = 500;

% Time duration
T = 1;

% Time vector
t = 0:1/fs:T;

% Clean low-frequency signal
f_signal = 5;
clean_signal = sin(2*pi*f_signal*t);

% High-frequency noise
f_noise = 50;
noise = 0.5*sin(2*pi*f_noise*t);

% Noisy signal
noisy_signal = clean_signal + noise;

% Butterworth filter settings
filter_order = 4;
cutoff_frequency = 10;

% Normalize cutoff frequency
normalized_cutoff = cutoff_frequency / (fs/2);

% Design Butterworth IIR low-pass filter
[b, a] = butter(filter_order, normalized_cutoff, 'low');

% Apply the filter
filtered_signal = filter(b, a, noisy_signal);

% Plot
figure;

% Clean signal
subplot(4,1,1);
plot(t, clean_signal, 'LineWidth', 1.2);
title('Original Clean Signal, 5 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Noise signal
subplot(4,1,2);
plot(t, noise, 'LineWidth', 1.2);
title('High-Frequency Noise, 50 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Before filtering
subplot(4,1,3);
plot(t, noisy_signal, 'LineWidth', 1.2);
title('Noisy Signal Before Filtering');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% After filtering
subplot(4,1,4);
plot(t, filtered_signal, 'LineWidth', 1.2);
title('Signal After Butterworth IIR Filtering');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

drawnow;
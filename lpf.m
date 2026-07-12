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

% FIR filter settings
filter_order = 40;
cutoff_frequency = 10;

% Normalize cutoff frequency
normalized_cutoff = cutoff_frequency / (fs/2);

% Design FIR low-pass filter
b = fir1(filter_order, normalized_cutoff, 'low');

% Apply filter
filtered_signal = filter(b, 1, noisy_signal);

% Plot
figure;

% Clean signal
subplot(3,1,1);
plot(t, clean_signal, 'LineWidth', 1.2);
title('Original Clean Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Before filtering
subplot(3,1,2);
plot(t, noisy_signal, 'LineWidth', 1.2);
title('Noisy Signal Before Filtering');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% After filtering
subplot(3,1,3);
plot(t, filtered_signal, 'LineWidth', 1.2);
title('Signal After FIR Low-Pass Filtering');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

drawnow;
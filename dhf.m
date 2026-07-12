clc;
clear;
close all;

% Sampling frequency
fs = 500;

% Time vector
t = 0:1/fs:1;

% Original signal with DC component
dc_value = 2;
signal = dc_value + sin(2*pi*5*t);

% High-pass filter settings
filter_order = 40;
cutoff_frequency = 1;

% Normalize cutoff frequency
normalized_cutoff = cutoff_frequency / (fs/2);

% Design FIR high-pass filter
b = fir1(filter_order, normalized_cutoff, 'high');

% Apply the filter
filtered_signal = filtfilt(b, 1, signal);

% Plot
figure;

% Original signal
subplot(3,1,1);
plot(t, signal, 'LineWidth', 1.2);
title('Original Signal with DC Component');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Filtered signal
subplot(3,1,2);
plot(t, filtered_signal, 'LineWidth', 1.2);
title('Filtered Signal after DC Removal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Comparison
subplot(3,1,3);
plot(t, signal, 'LineWidth', 1.2);
hold on;
plot(t, filtered_signal, '--', 'LineWidth', 1.2);
title('Original vs High-Pass Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Filtered Signal');
grid on;
hold off;

drawnow;
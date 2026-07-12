clc;
clear;
close all;

% Fix random values so the result is repeatable
rng(1);

% Sampling frequency
fs = 500;

% Time duration
T = 2;

% Time vector
t = 0:1/fs:T;

% Clean signal frequency
f_signal = 5;

% Generate clean signal
clean_signal = sin(2*pi*f_signal*t);

% Generate random Gaussian noise
noise_amplitude = 0.5;
noise = noise_amplitude * randn(size(t));

% Add noise to clean signal
noisy_signal = clean_signal + noise;

% Butterworth low-pass filter settings
filter_order = 4;
cutoff_frequency = 15;

% Normalize cutoff frequency
normalized_cutoff = cutoff_frequency / (fs/2);

% Design Butterworth low-pass filter
[b, a] = butter(filter_order, normalized_cutoff, 'low');

% Apply filtering
filtered_signal = filtfilt(b, a, noisy_signal);

% Calculate noise before filtering
input_noise = noisy_signal - clean_signal;

% Calculate remaining error after filtering
output_noise = filtered_signal - clean_signal;

% Calculate signal power
signal_power = mean(clean_signal.^2);

% Calculate noise power before filtering
input_noise_power = mean(input_noise.^2);

% Calculate noise power after filtering
output_noise_power = mean(output_noise.^2);

% Calculate SNR before filtering
SNR_before = 10 * log10(signal_power / input_noise_power);

% Calculate SNR after filtering
SNR_after = 10 * log10(signal_power / output_noise_power);

% Calculate SNR improvement
SNR_improvement = SNR_after - SNR_before;

% Display results
fprintf('SNR before filtering = %.2f dB\n', SNR_before);
fprintf('SNR after filtering  = %.2f dB\n', SNR_after);
fprintf('SNR improvement      = %.2f dB\n', SNR_improvement);

% Plot
figure;

% Clean signal
subplot(4,1,1);
plot(t, clean_signal, 'LineWidth', 1.2);
title('Original Clean Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Noisy signal
subplot(4,1,2);
plot(t, noisy_signal);
title(['Noisy Signal, SNR = ', num2str(SNR_before, '%.2f'), ' dB']);
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Filtered signal
subplot(4,1,3);
plot(t, filtered_signal, 'LineWidth', 1.2);
title(['Filtered Signal, SNR = ', num2str(SNR_after, '%.2f'), ' dB']);
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Comparison
subplot(4,1,4);
plot(t, clean_signal, 'LineWidth', 1.2);
hold on;
plot(t, filtered_signal, '--', 'LineWidth', 1.2);
title('Original vs Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Filtered Signal');
grid on;
hold off;

drawnow;
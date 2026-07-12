clc;
clear;
close all;

% ---------------------------------
% Original continuous-like signal
% ---------------------------------

% High rate used to represent a continuous signal
fs_continuous = 1000;

% Duration
T = 2;

% Continuous time vector
t = 0:1/fs_continuous:T;

% Signal frequencies
f1 = 5;       % Desired frequency
f2 = 18;      % Frequency that will cause aliasing

% Original signal
x = sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t);

% ---------------------------------
% Low sampling frequency
% ---------------------------------

fs_sample = 20;

% Nyquist frequency
nyquist_frequency = fs_sample / 2;

% Sampling time
t_sample = 0:1/fs_sample:T;

% Sample original signal directly
x_sampled = sin(2*pi*f1*t_sample) ...
          + 0.6*sin(2*pi*f2*t_sample);

% ---------------------------------
% Anti-aliasing filter
% ---------------------------------

% Cutoff must be below Nyquist frequency
cutoff_frequency = 8;

% Butterworth filter order
filter_order = 6;

% Normalize cutoff using continuous-like sampling rate
normalized_cutoff = cutoff_frequency / (fs_continuous/2);

% Design low-pass anti-aliasing filter
[b, a] = butter(filter_order, normalized_cutoff, 'low');

% Apply filter before sampling
x_filtered_continuous = filtfilt(b, a, x);

% ---------------------------------
% Sample the filtered signal
% ---------------------------------

% Find filtered values at sampling positions
x_filtered_sampled = interp1( ...
    t, x_filtered_continuous, t_sample, 'linear');

% ---------------------------------
% Calculate alias frequency
% ---------------------------------

f_alias = abs(f2 - fs_sample);

% False aliased signal for visualization
x_alias = sin(2*pi*f1*t) ...
        - 0.6*sin(2*pi*f_alias*t);

% ---------------------------------
% Plot time-domain results
% ---------------------------------

figure;

% Original signal
subplot(4,1,1);
plot(t, x, 'LineWidth', 1.2);
title('Original Signal: 5 Hz + 18 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 1]);
grid on;

% Sampling without anti-aliasing filter
subplot(4,1,2);
plot(t, x, 'LineWidth', 1);
hold on;
stem(t_sample, x_sampled, 'filled');
title('Direct Sampling at 20 Hz: Aliasing Occurs');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 1]);
legend('Original Signal', 'Sampled Points');
grid on;
hold off;

% Show aliased interpretation
subplot(4,1,3);
plot(t, x, 'LineWidth', 1);
hold on;
plot(t, x_alias, '--', 'LineWidth', 1.3);
stem(t_sample, x_sampled, 'filled');
title('Aliased Signal: 18 Hz Appears as 2 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 1]);
legend('Original Signal', ...
       'Aliased Interpretation', ...
       'Sampled Points');
grid on;
hold off;

% Filtering before sampling
subplot(4,1,4);
plot(t, x_filtered_continuous, 'LineWidth', 1.2);
hold on;
stem(t_sample, x_filtered_sampled, 'filled');
title('After Anti-Aliasing Filter and Sampling');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 1]);
legend('Filtered Continuous Signal', ...
       'Filtered Sampled Points');
grid on;
hold off;

drawnow;
clc;
clear;
close all;

% Original signal frequency
f = 5;

% Phase shift
phi = pi/4;

% Time duration
T = 1;

% Continuous-time approximation
t = 0:0.001:T;

% Original continuous signal
x = sin(2*pi*f*t + phi);

% Sampling frequency
fs = 20;

% Sampling time
t_sample = 0:1/fs:T;

% Sampled signal
x_sample = sin(2*pi*f*t_sample + phi);

% Reconstruction using interpolation
x_reconstructed = interp1(t_sample, x_sample, t, 'spline');

% Plot
figure;

% Original and sampled signal
subplot(3,1,1);
plot(t, x, 'LineWidth', 1.5);
hold on;
stem(t_sample, x_sample, 'filled');
title('Original Signal and Sampled Points');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Sampled Points');
grid on;
hold off;

% Reconstructed signal
subplot(3,1,2);
plot(t, x_reconstructed, 'LineWidth', 1.5);
title('Reconstructed Signal Using interp1');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Comparison
subplot(3,1,3);
plot(t, x, 'LineWidth', 1.5);
hold on;
plot(t, x_reconstructed, '--', 'LineWidth', 1.5);
title('Original vs Reconstructed Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Reconstructed Signal');
grid on;
hold off;

drawnow;
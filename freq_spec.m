clc;
clear;
close all;

% Sampling frequency
fs = 1000;

% Signal duration
T = 1;

% Time vector
t = 0:1/fs:T-1/fs;

% Frequency components
f1 = 50;
f2 = 120;
f3 = 200;

% Amplitudes
A1 = 1;
A2 = 0.6;
A3 = 0.4;

% Generate individual sine waves
x1 = A1*sin(2*pi*f1*t);
x2 = A2*sin(2*pi*f2*t);
x3 = A3*sin(2*pi*f3*t);

% Composite signal
x = x1 + x2 + x3;

% Number of samples
N = length(x);

% Compute FFT
X = fft(x);

% Two-sided magnitude spectrum
P2 = abs(X/N);

% Single-sided magnitude spectrum
P1 = P2(1:N/2+1);

% Multiply non-DC and non-Nyquist components by 2
P1(2:end-1) = 2*P1(2:end-1);

% Frequency axis
f = fs*(0:N/2)/N;

% Plot
figure;

% Composite signal
subplot(2,1,1);
plot(t, x);
title('Composite Signal in Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 0.1]);
grid on;

% Magnitude spectrum
subplot(2,1,2);
plot(f, P1, 'LineWidth', 1.5);
title('Single-Sided Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 300]);
grid on;

drawnow;
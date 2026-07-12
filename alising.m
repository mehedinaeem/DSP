clc;
clear;
close all;

% Original signal frequency
f = 5;

% Continuous-time approximation
t = 0:0.001:1;

% Original 5 Hz signal
x = sin(2*pi*f*t);

% -----------------------------
% Sampling above Nyquist rate
% -----------------------------
fs_good = 20;

t_good = 0:1/fs_good:1;

x_good = sin(2*pi*f*t_good);

% -----------------------------
% Sampling below Nyquist rate
% -----------------------------
fs_bad = 8;

t_bad = 0:1/fs_bad:1;

x_bad = sin(2*pi*f*t_bad);

% Calculate alias frequency
f_alias = abs(f - fs_bad);

% Generate alias signal
x_alias = -sin(2*pi*f_alias*t);

% -----------------------------
% Plot
% -----------------------------
figure;

% Original continuous signal
subplot(3,1,1);
plot(t, x);
title('Original Continuous Signal, f = 5 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Sampling above Nyquist
subplot(3,1,2);
plot(t, x);
hold on;
stem(t_good, x_good, 'filled');
title('Sampling Above Nyquist Rate, f_s = 20 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
hold off;

% Aliasing demonstration
subplot(3,1,3);

plot(t, x);
hold on;

plot(t, x_alias, '--');

stem(t_bad, x_bad, 'filled');

title('Aliasing: 5 Hz Signal Sampled at 8 Hz Appears as 3 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original 5 Hz Signal', ...
    'Aliased 3 Hz Signal', ...
    'Sampled Points');

grid on;
hold off;
clc;
clear;
close all;

% Original signal frequency
f = 5;

% Phase shift for clear sampling points
phi = pi/4;

% Time duration
T = 1;

% Continuous-time approximation
t = 0:0.001:T;

% Original continuous signal
x = sin(2*pi*f*t + phi);

% Sampling above Nyquist rate
fs_above = 20;
t_above = 0:1/fs_above:T;
x_above = sin(2*pi*f*t_above + phi);

% Sampling below Nyquist rate
fs_below = 8;
t_below = 0:1/fs_below:T;
x_below = sin(2*pi*f*t_below + phi);

% Aliased frequency
f_alias = abs(fs_below - f);

% Aliased signal
x_alias = -sin(2*pi*f_alias*t - phi);

% Plot
figure;

% Original continuous signal
subplot(3,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Continuous Signal, f = 5 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Sampling above Nyquist
subplot(3,1,2);
plot(t, x, 'LineWidth', 1.2);
hold on;
stem(t_above, x_above, 'filled');
title('Sampling Above Nyquist Rate, f_s = 20 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Sampled Points');
grid on;
hold off;

% Aliasing demonstration
subplot(3,1,3);
plot(t, x, 'LineWidth', 1.2);
hold on;
plot(t, x_alias, '--', 'LineWidth', 1.5);
stem(t_below, x_below, 'filled');
title('Aliasing: 5 Hz Signal Sampled at 8 Hz Appears as 3 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original 5 Hz Signal', ...
    'Aliased 3 Hz Signal', ...
    'Sampled Points');
grid on;
hold off;

drawnow;
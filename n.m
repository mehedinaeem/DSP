clc;
clear;
close all;

% Frequencies
f1 = 100;
f2 = 300;

% Short time interval for clear visualization
t = 0:0.000005:0.005;

% Original continuous signal
x = sin(2*pi*f1*t) + 0.5*cos(2*pi*f2*t);

% Sampling rates
fs_nyquist = 600;
fs_above = 1200;
fs_below = 400;

% Nyquist sampling
t_nyquist = 0:1/fs_nyquist:0.005;
x_nyquist = sin(2*pi*f1*t_nyquist) ...
          + 0.5*cos(2*pi*f2*t_nyquist);

% Above Nyquist sampling
t_above = 0:1/fs_above:0.005;
x_above = sin(2*pi*f1*t_above) ...
        + 0.5*cos(2*pi*f2*t_above);

% Below Nyquist sampling
t_below = 0:1/fs_below:0.005;
x_below = sin(2*pi*f1*t_below) ...
        + 0.5*cos(2*pi*f2*t_below);

% Alias frequency of 300 Hz when sampled at 400 Hz
f_alias = abs(f2 - fs_below);

% Aliased version
x_alias = sin(2*pi*f1*t) ...
        + 0.5*cos(2*pi*f_alias*t);

% Plot
figure;

% Original continuous signal
subplot(4,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Continuous Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
ylim([-2 2]);
grid on;

% Nyquist sampling
subplot(4,1,2);
plot(t, x, 'LineWidth', 1.2);
hold on;
stem(t_nyquist, x_nyquist, 'filled', 'LineWidth', 1.2);
title('Sampling at Nyquist Rate, f_s = 600 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
ylim([-2 2]);
grid on;
hold off;

% Above Nyquist sampling
subplot(4,1,3);
plot(t, x, 'LineWidth', 1.2);
hold on;
stem(t_above, x_above, 'filled', 'LineWidth', 1.2);
title('Sampling Above Nyquist Rate, f_s = 1200 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
ylim([-2 2]);
grid on;
hold off;

% Aliasing demonstration
subplot(4,1,4);
plot(t, x, 'LineWidth', 1.2);
hold on;
plot(t, x_alias, '--', 'LineWidth', 1.5);
stem(t_below, x_below, 'filled', 'LineWidth', 1.2);

title('Aliasing Demonstration');
xlabel('Time (seconds)');
ylabel('Amplitude');
ylim([-2 2]);

legend('Original Signal', ...
       'Aliased Signal', ...
       'Sampled Points');

grid on;
hold off;
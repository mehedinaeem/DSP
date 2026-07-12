clc;
clear;
close all;

% Original signal frequency
f = 5;

% Phase shift
phi = pi/4;

% Continuous-time approximation
t = 0:0.001:1;
x = sin(2*pi*f*t + phi);

% Nyquist sampling rate
fs_nyquist = 2 * f;
t_nyquist = 0:1/fs_nyquist:1;
x_nyquist = sin(2*pi*f*t_nyquist + phi);

% Above Nyquist rate
fs_above = 20;
t_above = 0:1/fs_above:1;
x_above = sin(2*pi*f*t_above + phi);

% Below Nyquist rate
fs_below = 8;
t_below = 0:1/fs_below:1;
x_below = sin(2*pi*f*t_below + phi);

% Plot
figure;

% Original signal
subplot(4,1,1);
plot(t, x);
title('Original Continuous Sine Wave, f = 5 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Nyquist rate
subplot(4,1,2);
plot(t, x);
hold on;
stem(t_nyquist, x_nyquist, 'filled');
title('Sampling at Nyquist Rate, f_s = 10 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
hold off;

% Above Nyquist rate
subplot(4,1,3);
plot(t, x);
hold on;
stem(t_above, x_above, 'filled');
title('Sampling Above Nyquist Rate, f_s = 20 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
hold off;

% Below Nyquist rate
subplot(4,1,4);
plot(t, x);
hold on;
stem(t_below, x_below, 'filled');
title('Sampling Below Nyquist Rate, f_s = 8 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
hold off;

drawnow;
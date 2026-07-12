clc;
clear;
close all;

% Signal frequency
f = 2;

% Time duration
T = 1;

% Continuous-time approximation
t = 0:0.001:T;

% Input sine wave
x = sin(2*pi*f*t);

% Number of quantization bits
bits = 3;

% Number of quantization levels
L = 2^bits;

% Minimum and maximum signal values
x_min = -1;
x_max = 1;

% Quantization step size
delta = (x_max - x_min) / L;

% Uniform quantization
x_quantized = delta * round(x / delta);

% Limit the output to the signal range
x_quantized(x_quantized > x_max) = x_max;
x_quantized(x_quantized < x_min) = x_min;

% Plot
figure;

% Input sine wave
subplot(2,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Input Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');
ylim([-1.2 1.2]);
grid on;

% Original and quantized signals
subplot(2,1,2);
plot(t, x, 'LineWidth', 1.2);
hold on;
stairs(t, x_quantized, 'LineWidth', 1.5);
title('Original Signal vs Quantized Output');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Quantized Signal');
ylim([-1.2 1.2]);
grid on;
hold off;

drawnow;
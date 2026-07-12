clc;
clear;
close all;

% Generate the original sine wave
f = 2;
T = 1;
t = 0:0.001:T;
x = sin(2*pi*f*t);

% Quantizer settings
bits = 3;
L = 2^bits;

% Signal range
x_min = -1;
x_max = 1;

% Quantization step size
delta = (x_max - x_min) / L;

% Find quantization index
index = floor((x - x_min) / delta);

% Keep index within valid range
index(index >= L) = L - 1;
index(index < 0) = 0;

% Generate quantized signal
x_quantized = x_min + (index + 0.5) * delta;

% Calculate quantization error
error_signal = x - x_quantized;

% Calculate Mean Squared Error
MSE = mean(error_signal.^2);

% Display results
disp(['Number of quantization levels = ', num2str(L)]);
disp(['Quantization step size = ', num2str(delta)]);
disp(['Mean Squared Error = ', num2str(MSE)]);

% Plot
figure;

% Original and quantized signals
subplot(3,1,1);
plot(t, x, 'LineWidth', 1.2);
hold on;
stairs(t, x_quantized, 'LineWidth', 1.5);
title('Original Signal vs Quantized Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Quantized Signal');
grid on;
hold off;

% Quantization error
subplot(3,1,2);
plot(t, error_signal, 'LineWidth', 1.2);
title('Quantization Error Signal');
xlabel('Time (seconds)');
ylabel('Error');
grid on;

% Squared quantization error
subplot(3,1,3);
plot(t, error_signal.^2, 'LineWidth', 1.2);
title(['Squared Error, MSE = ', num2str(MSE)]);
xlabel('Time (seconds)');
ylabel('Squared Error');
grid on;

drawnow;
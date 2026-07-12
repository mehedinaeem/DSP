clc;
clear;
close all;

% Generate original sine wave
f = 2;
T = 1;
t = 0:0.001:T;
x = sin(2*pi*f*t);

% Signal range
x_min = -1;
x_max = 1;

% Bit resolutions
bits2 = 2;
bits4 = 4;
bits8 = 8;

% Number of levels
L2 = 2^bits2;
L4 = 2^bits4;
L8 = 2^bits8;

% Quantization step sizes
delta2 = (x_max - x_min) / L2;
delta4 = (x_max - x_min) / L4;
delta8 = (x_max - x_min) / L8;

% -----------------------------
% 2-bit quantization
% -----------------------------
index2 = floor((x - x_min) / delta2);
index2(index2 >= L2) = L2 - 1;
index2(index2 < 0) = 0;

xq2 = x_min + (index2 + 0.5) * delta2;

% -----------------------------
% 4-bit quantization
% -----------------------------
index4 = floor((x - x_min) / delta4);
index4(index4 >= L4) = L4 - 1;
index4(index4 < 0) = 0;

xq4 = x_min + (index4 + 0.5) * delta4;

% -----------------------------
% 8-bit quantization
% -----------------------------
index8 = floor((x - x_min) / delta8);
index8(index8 >= L8) = L8 - 1;
index8(index8 < 0) = 0;

xq8 = x_min + (index8 + 0.5) * delta8;

% Quantization errors
error2 = x - xq2;
error4 = x - xq4;
error8 = x - xq8;

% Mean Squared Errors
MSE2 = mean(error2.^2);
MSE4 = mean(error4.^2);
MSE8 = mean(error8.^2);

% Display results
fprintf('2-bit MSE = %.8f\n', MSE2);
fprintf('4-bit MSE = %.8f\n', MSE4);
fprintf('8-bit MSE = %.8f\n', MSE8);

% Plot quantized signals
figure;

subplot(4,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(t, x);
hold on;
stairs(t, xq2, 'LineWidth', 1.4);
title('2-bit Quantization, 4 Levels');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original', '2-bit Quantized');
grid on;
hold off;

subplot(4,1,3);
plot(t, x);
hold on;
stairs(t, xq4, 'LineWidth', 1.4);
title('4-bit Quantization, 16 Levels');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original', '4-bit Quantized');
grid on;
hold off;

subplot(4,1,4);
plot(t, x);
hold on;
stairs(t, xq8, 'LineWidth', 1.4);
title('8-bit Quantization, 256 Levels');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original', '8-bit Quantized');
grid on;
hold off;

% Plot quantization errors
figure;

subplot(3,1,1);
plot(t, error2);
title(['2-bit Quantization Error, MSE = ', num2str(MSE2)]);
xlabel('Time (seconds)');
ylabel('Error');
grid on;

subplot(3,1,2);
plot(t, error4);
title(['4-bit Quantization Error, MSE = ', num2str(MSE4)]);
xlabel('Time (seconds)');
ylabel('Error');
grid on;

subplot(3,1,3);
plot(t, error8);
title(['8-bit Quantization Error, MSE = ', num2str(MSE8)]);
xlabel('Time (seconds)');
ylabel('Error');
grid on;

drawnow;
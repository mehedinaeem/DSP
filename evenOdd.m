clc;
clear;
close all;

% Define the signal
n = -2:2;
x = [1 2 3 4 5];

% Time reversal
x_reverse = fliplr(x);

% Even component
x_even = (x + x_reverse) / 2;

% Odd component
x_odd = (x - x_reverse) / 2;

% Reconstruct the original signal
x_verify = x_even + x_odd;

% Plot all signals
figure;

% Original signal
subplot(4,1,1);
stem(n, x, 'filled');
title('Original Signal x[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Even component
subplot(4,1,2);
stem(n, x_even, 'filled');
title('Even Component x_e[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Odd component
subplot(4,1,3);
stem(n, x_odd, 'filled');
title('Odd Component x_o[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Verification
subplot(4,1,4);
stem(n, x_verify, 'filled');
title('Verification: x_e[n] + x_o[n]');
xlabel('n');
ylabel('Amplitude');
grid on;
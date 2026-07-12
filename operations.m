clc;
clear;
close all;

n=0:3;
x=[1 2 3 4];

n_shift = n+2;
x_shift = x;

x_scaled = 2*x;

n_reverse = -fliplr(n);
x_reverse = fliplr(x);

figure;

% Original signal
subplot(4,1,1);
stem(n, x, 'filled');
title('Original Signal x[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
stem(n_shift,x_shift, 'filled');
title('shifted');
grid on;
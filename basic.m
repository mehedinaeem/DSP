clc;
clear;
close all;

% Define discrete-time range
n = -10:10;

%% 1. Unit Step Signal u[n]
unit_step = double(n >= 0);

%% 2. Unit Impulse Signal delta[n]
unit_impulse = double(n == 0);

%% 3. Ramp Signal
ramp_signal = n .* double(n >= 0);

%% 4. Sine Wave
sine_wave = sin(0.5 * n);

%% 5. Cosine Wave
cosine_wave = cos(0.5 * n);

%% Plot all signals in separate subplots

figure;

% Unit Step
subplot(5,1,1);
stem(n, unit_step, 'filled');
title('Unit Step Signal u[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Unit Impulse
subplot(5,1,2);
stem(n, unit_impulse, 'filled');
title('Unit Impulse Signal \delta[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Ramp Signal
subplot(5,1,3);
stem(n, ramp_signal, 'filled');
title('Ramp Signal r[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Sine Wave
subplot(5,1,4);
stem(n, sine_wave, 'filled');
title('Sine Wave');
xlabel('n');
ylabel('Amplitude');
grid on;

% Cosine Wave
subplot(5,1,5);
stem(n, cosine_wave, 'filled');
title('Cosine Wave');
xlabel('n');
ylabel('Amplitude');
grid on;
clc;
clear;
close all;

% Fix random noise so result is repeatable
rng(1);

% Sampling settings
fs = 1000;
T = 1;
t = 0:1/fs:T;

% --------------------------------
% Generate different signal types
% --------------------------------

% 1. Sine wave
sine_signal = sin(2*pi*5*t);

% 2. Square wave
square_signal = square(2*pi*5*t);

% 3. Ramp signal
ramp_signal = t;

% 4. Random noise
noise_signal = randn(size(t));

% Store signals in a cell array
signals = {
    sine_signal
    square_signal
    ramp_signal
    noise_signal
};

% Actual signal names
actual_names = {
    'Sine Wave'
    'Square Wave'
    'Ramp Signal'
    'Random Noise'
};

% Number of signals
number_of_signals = length(signals);

% Create arrays for extracted features
mean_values = zeros(number_of_signals, 1);
variance_values = zeros(number_of_signals, 1);
std_values = zeros(number_of_signals, 1);
max_values = zeros(number_of_signals, 1);
min_values = zeros(number_of_signals, 1);
zero_crossing_rates = zeros(number_of_signals, 1);

% Store predicted classes
predicted_names = cell(number_of_signals, 1);

% --------------------------------
% Feature extraction
% --------------------------------

for i = 1:number_of_signals

    current_signal = signals{i};

    % Statistical features
    mean_values(i) = mean(current_signal);
    variance_values(i) = var(current_signal);
    std_values(i) = std(current_signal);
    max_values(i) = max(current_signal);
    min_values(i) = min(current_signal);

    % Zero-crossing rate
    zero_crossings = sum(current_signal(1:end-1) .* ...
                         current_signal(2:end) < 0);

    zero_crossing_rates(i) = ...
        zero_crossings / (length(current_signal) - 1);

    % --------------------------------
    % Basic rule-based classification
    % --------------------------------

    if mean_values(i) > 0.4

        predicted_names{i} = 'Ramp Signal';

    elseif variance_values(i) > 0.8 && ...
           max_values(i) > 2

        predicted_names{i} = 'Random Noise';

    elseif variance_values(i) > 0.8 && ...
           max_values(i) <= 1.1

        predicted_names{i} = 'Square Wave';

    else

        predicted_names{i} = 'Sine Wave';

    end

end

% --------------------------------
% Display feature table
% --------------------------------

results = table( ...
    actual_names, ...
    mean_values, ...
    variance_values, ...
    std_values, ...
    max_values, ...
    min_values, ...
    zero_crossing_rates, ...
    predicted_names);

disp(results);

% --------------------------------
% Plot all signals
% --------------------------------

figure;

subplot(4,1,1);
plot(t, sine_signal);
title('Sine Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(t, square_signal);
title('Square Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(4,1,3);
plot(t, ramp_signal);
title('Ramp Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(4,1,4);
plot(t, noise_signal);
title('Random Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;

drawnow;
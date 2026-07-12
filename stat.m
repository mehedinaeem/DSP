clc;
clear;
close all;

% Given discrete signal
x = [1 2 2 3 4 7 9];

% Number of samples
N = length(x);

%% MATLAB built-in calculations

mean_builtin = mean(x);

% Use population normalization: divide by N
variance_builtin = var(x, 1);
std_builtin = std(x, 1);

% Flag 1 uses moment-based population formulas
skewness_builtin = skewness(x, 1);
kurtosis_builtin = kurtosis(x, 1);

%% Manual calculations

% Mean
mean_manual = sum(x) / N;

% Difference from mean
deviation = x - mean_manual;

% Population variance
variance_manual = sum(deviation.^2) / N;

% Population standard deviation
std_manual = sqrt(variance_manual);

% Manual skewness
skewness_manual = ...
    sum(deviation.^3) / (N * std_manual^3);

% Manual kurtosis
kurtosis_manual = ...
    sum(deviation.^4) / (N * std_manual^4);

%% Display results

fprintf('STATISTICAL MEASURES\n');
fprintf('-------------------------------\n');

fprintf('Mean using built-in      = %.6f\n', mean_builtin);
fprintf('Mean using manual formula = %.6f\n\n', mean_manual);

fprintf('Variance using built-in      = %.6f\n', variance_builtin);
fprintf('Variance using manual formula = %.6f\n\n', variance_manual);

fprintf('Standard deviation built-in      = %.6f\n', std_builtin);
fprintf('Standard deviation manual formula = %.6f\n\n', std_manual);

fprintf('Skewness using built-in      = %.6f\n', skewness_builtin);
fprintf('Skewness using manual formula = %.6f\n\n', skewness_manual);

fprintf('Kurtosis using built-in      = %.6f\n', kurtosis_builtin);
fprintf('Kurtosis using manual formula = %.6f\n', kurtosis_manual);

%% Plot the signal

figure;

subplot(2,1,1);
stem(0:N-1, x, 'filled');
title('Given Discrete Signal');
xlabel('Sample Index n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
bar({'Mean', 'Variance', 'Std', 'Skewness', 'Kurtosis'}, ...
    [mean_builtin, variance_builtin, std_builtin, ...
    skewness_builtin, kurtosis_builtin]);

title('Statistical Measures of the Signal');
ylabel('Value');
grid on;

drawnow;
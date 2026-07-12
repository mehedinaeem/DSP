clc;
clear;
close all;

% Number of random samples
N = 10000;

% Generate white Gaussian noise
noise = randn(1, N);

% Calculate statistical properties
sample_mean = mean(noise);
sample_variance = var(noise);
sample_std = std(noise);

% Calculate minimum and maximum values
minimum_value = min(noise);
maximum_value = max(noise);

% Display calculated values
fprintf('Number of samples = %d\n', N);
fprintf('Sample mean = %.6f\n', sample_mean);
fprintf('Sample variance = %.6f\n', sample_variance);
fprintf('Sample standard deviation = %.6f\n', sample_std);
fprintf('Minimum value = %.6f\n', minimum_value);
fprintf('Maximum value = %.6f\n', maximum_value);

% Theoretical values
theoretical_mean = 0;
theoretical_variance = 1;
theoretical_std = 1;

fprintf('\nTheoretical mean = %.1f\n', theoretical_mean);
fprintf('Theoretical variance = %.1f\n', theoretical_variance);
fprintf('Theoretical standard deviation = %.1f\n', theoretical_std);

% Calculate errors from theoretical values
mean_error = abs(sample_mean - theoretical_mean);
variance_error = abs(sample_variance - theoretical_variance);
std_error = abs(sample_std - theoretical_std);

fprintf('\nMean error = %.6f\n', mean_error);
fprintf('Variance error = %.6f\n', variance_error);
fprintf('Standard deviation error = %.6f\n', std_error);

% Autocorrelation
[autocorrelation, lag] = xcorr(noise, 50, 'biased');

% Plot
figure;

% Show first 500 noise samples
subplot(3,1,1);
plot(1:500, noise(1:500));
title('White Gaussian Noise Signal');
xlabel('Sample number');
ylabel('Amplitude');
grid on;

% Histogram
subplot(3,1,2);
histogram(noise, 50, 'Normalization', 'pdf');
title('Histogram of White Gaussian Noise');
xlabel('Amplitude');
ylabel('Probability density');
grid on;

% Autocorrelation
subplot(3,1,3);
stem(lag, autocorrelation, 'filled');
title('Autocorrelation of White Gaussian Noise');
xlabel('Lag');
ylabel('Autocorrelation');
grid on;

drawnow;
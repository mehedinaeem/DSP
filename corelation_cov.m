clc;
clear;
close all;

% Define two discrete signals
x = [1 2 3 4];
y = [1 2 2 3];

% Sample indices
n = 0:length(x)-1;

% ---------------------------------
% Auto-correlation of x
% ---------------------------------
[Rxx, lags_auto] = xcorr(x, x);

% ---------------------------------
% Cross-correlation between x and y
% ---------------------------------
[Rxy, lags_cross] = xcorr(x, y);

% ---------------------------------
% Covariance
% ---------------------------------
C = cov(x, y);

% Extract covariance between x and y
covariance_xy = C(1,2);

% ---------------------------------
% Display results
% ---------------------------------
disp('Auto-correlation of x:');
disp(Rxx);

disp('Auto-correlation lags:');
disp(lags_auto);

disp('Cross-correlation between x and y:');
disp(Rxy);

disp('Cross-correlation lags:');
disp(lags_cross);

disp('Covariance matrix:');
disp(C);

fprintf('Covariance between x and y = %.4f\n', covariance_xy);

% Find maximum cross-correlation and corresponding lag
[max_corr, index] = max(Rxy);
best_lag = lags_cross(index);

fprintf('Maximum cross-correlation = %.4f\n', max_corr);
fprintf('Lag of maximum similarity = %d\n', best_lag);

% ---------------------------------
% Plot
% ---------------------------------
figure;

% Original signals
subplot(3,1,1);
stem(n, x, 'filled');
hold on;
stem(n, y, 'filled');
title('Original Signals');
xlabel('Sample Index n');
ylabel('Amplitude');
legend('x[n]', 'y[n]');
grid on;
hold off;

% Auto-correlation
subplot(3,1,2);
stem(lags_auto, Rxx, 'filled');
title('Auto-correlation of x[n]');
xlabel('Lag');
ylabel('R_{xx}');
grid on;

% Cross-correlation
subplot(3,1,3);
stem(lags_cross, Rxy, 'filled');
title('Cross-correlation Between x[n] and y[n]');
xlabel('Lag');
ylabel('R_{xy}');
grid on;

drawnow;
clc;
clear;
close all;

% Input discrete signal
x = [1 2 3 4];

% Number of samples
N = length(x);

% --------------------------------
% DFT using built-in FFT function
% --------------------------------
X_fft = fft(x);

% --------------------------------
% Manual DFT implementation
% --------------------------------
X_manual = zeros(1, N);

for k = 0:N-1

    for n = 0:N-1

        X_manual(k+1) = X_manual(k+1) + ...
            x(n+1) * exp(-1j*2*pi*k*n/N);

    end

end

% --------------------------------
% Compare the results
% --------------------------------
difference = abs(X_fft - X_manual);

% Display results
disp('DFT using built-in fft:');
disp(X_fft);

disp('DFT using manual implementation:');
disp(X_manual);

disp('Absolute difference:');
disp(difference);

% Check whether results are approximately equal
if max(difference) < 1e-10
    disp('Both DFT results are equal.');
else
    disp('The results are different.');
end

% --------------------------------
% Plot
% --------------------------------
k = 0:N-1;

figure;

% Original signal
subplot(3,1,1);
stem(0:N-1, x, 'filled');
title('Original Discrete Signal x[n]');
xlabel('Sample index n');
ylabel('Amplitude');
grid on;

% Magnitude using FFT
subplot(3,1,2);
stem(k, abs(X_fft), 'filled');
title('DFT Magnitude Using Built-in fft');
xlabel('Frequency index k');
ylabel('|X[k]|');
grid on;

% Magnitude using manual DFT
subplot(3,1,3);
stem(k, abs(X_manual), 'filled');
title('DFT Magnitude Using Manual Implementation');
xlabel('Frequency index k');
ylabel('|X[k]|');
grid on;

drawnow;
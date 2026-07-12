clc;
clear;
close all;

% Sampling frequency
fs = 1000;

% Total duration
T = 3;

% Time vector
t = 0:1/fs:T-1/fs;

% --------------------------------
% Stationary signal
% --------------------------------
stationary_signal = sin(2*pi*100*t) ...
    + 0.5*sin(2*pi*250*t);

% --------------------------------
% Non-stationary signal
% --------------------------------
nonstationary_signal = zeros(size(t));

% First second: 100 Hz
index1 = t < 1;
nonstationary_signal(index1) = ...
    sin(2*pi*100*t(index1));

% Second second: 250 Hz
index2 = t >= 1 & t < 2;
nonstationary_signal(index2) = ...
    sin(2*pi*250*t(index2));

% Third second: 400 Hz
index3 = t >= 2;
nonstationary_signal(index3) = ...
    sin(2*pi*400*t(index3));

% --------------------------------
% Spectrogram settings
% --------------------------------
window_length = 256;
overlap = 200;
nfft = 512;

% --------------------------------
% Plot time-domain signals
% --------------------------------
figure;

subplot(2,1,1);
plot(t, stationary_signal);
title('Stationary Signal in Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, nonstationary_signal);
title('Non-Stationary Signal in Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% --------------------------------
% Spectrogram of stationary signal
% --------------------------------
figure;

spectrogram(stationary_signal, ...
    hamming(window_length), ...
    overlap, ...
    nfft, ...
    fs, ...
    'yaxis');

title('Spectrogram of Stationary Signal');
colorbar;

% --------------------------------
% Spectrogram of non-stationary signal
% --------------------------------
figure;

spectrogram(nonstationary_signal, ...
    hamming(window_length), ...
    overlap, ...
    nfft, ...
    fs, ...
    'yaxis');

title('Spectrogram of Non-Stationary Signal');
colorbar;

drawnow;
clc;
clear;
close all;

% Sampling frequency
fs = 500;

% Butterworth filter settings
filter_order = 4;
cutoff_frequency = 10;

% Normalize cutoff frequency
normalized_cutoff = cutoff_frequency / (fs/2);

% Design Butterworth low-pass filter
[b, a] = butter(filter_order, normalized_cutoff, 'low');

% Plot magnitude and phase response
figure;
freqz(b, a, 1024, fs);
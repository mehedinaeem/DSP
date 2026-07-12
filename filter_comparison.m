clc;
clear;
close all;

% Sampling frequency
fs = 500;

% Cutoff frequency
fc = 50;

% Normalize cutoff frequency
Wn = fc / (fs/2);

% -----------------------------
% FIR filter design
% -----------------------------
fir_order = 40;
b_fir = fir1(fir_order, Wn, 'low');
a_fir = 1;

% -----------------------------
% IIR Butterworth filter design
% -----------------------------
iir_order = 4;
[b_iir, a_iir] = butter(iir_order, Wn, 'low');

% -----------------------------
% Frequency responses
% -----------------------------
[H_fir, f] = freqz(b_fir, a_fir, 2048, fs);
[H_iir, ~] = freqz(b_iir, a_iir, 2048, fs);

% Magnitude responses in dB
mag_fir = 20*log10(abs(H_fir));
mag_iir = 20*log10(abs(H_iir));

% Phase responses in degrees
phase_fir = unwrap(angle(H_fir))*180/pi;
phase_iir = unwrap(angle(H_iir))*180/pi;

% -----------------------------
% Stability check
% -----------------------------
fir_poles = roots(a_fir);
iir_poles = roots(a_iir);

fir_stable = all(abs(fir_poles) < 1);
iir_stable = all(abs(iir_poles) < 1);

fprintf('FIR filter stable = %d\n', fir_stable);
fprintf('IIR filter stable = %d\n', iir_stable);

% -----------------------------
% Plot
% -----------------------------
figure;

% Magnitude response
subplot(2,1,1);
plot(f, mag_fir, 'LineWidth', 1.3);
hold on;
plot(f, mag_iir, '--', 'LineWidth', 1.3);
xline(fc, ':', 'Cutoff');
title('Magnitude Response: FIR vs IIR');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('FIR Filter', 'IIR Filter');
xlim([0 150]);
grid on;
hold off;

% Phase response
subplot(2,1,2);
plot(f, phase_fir, 'LineWidth', 1.3);
hold on;
plot(f, phase_iir, '--', 'LineWidth', 1.3);
xline(fc, ':', 'Cutoff');
title('Phase Response: FIR vs IIR');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
legend('FIR Filter', 'IIR Filter');
xlim([0 150]);
grid on;
hold off;

drawnow;
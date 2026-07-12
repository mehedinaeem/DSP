clc;
clear;
close all;

f1 = 100;
f2 = 300;
T = 0.02;

% Continuous signal
t = 0:1/5000:T;
x = sin(2*pi*f1*t) + 0.5*cos(2*pi*f2*t);

% Sampling frequencies
fs1 = 600;     % Nyquist
fs2 = 1000;    % Above Nyquist
fs3 = 400;     % Below Nyquist

% Sampled signals
t1 = 0:1/fs1:T;
x1 = sin(2*pi*f1*t1) + 0.5*cos(2*pi*f2*t1);

t2 = 0:1/fs2:T;
x2 = sin(2*pi*f1*t2) + 0.5*cos(2*pi*f2*t2);

t3 = 0:1/fs3:T;
x3 = sin(2*pi*f1*t3) + 0.5*cos(2*pi*f2*t3);

% Aliased signal for below Nyquist case
f_alias = abs(f2 - fs3);
x_alias = sin(2*pi*f1*t) + 0.5*cos(2*pi*f_alias*t);

figure

subplot(3,1,1)
plot(t,x,'b','LineWidth',1.2)
hold on
stem(t1,x1,'r','filled')
title('Sampling at Nyquist Rate')
xlabel('Time')
ylabel('Amplitude')
grid on
legend('Original Signal','Sampled Points')

subplot(3,1,2)
plot(t,x,'b','LineWidth',1.2)
hold on
stem(t2,x2,'r','filled')
title('Sampling Above Nyquist Rate')
xlabel('Time')
ylabel('Amplitude')
grid on
legend('Original Signal','Sampled Points')

subplot(3,1,3)
plot(t,x,'b','LineWidth',1.2)
hold on
plot(t,x_alias,'k--','LineWidth',1.5)
stem(t3,x3,'r','filled')
title('Sampling Below Nyquist Rate with Aliasing')
xlabel('Time')
ylabel('Amplitude')
grid on
legend('Original Signal','Aliased Signal','Sampled Points')
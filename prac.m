clc;
clear;
close all;

n=-10:20;

u=double(n>=0);

%%-- stem(n,u,'filled');
%%title('unit step signal');
%%xlabel('n');
%%ylabel('amplitude');
%%grid on;

impulse=double(n==0);
ramp = n .* double(n>=0);
sin_w=sin(0.5*n);
sin_ww=sin(0.2*n);
cos_w=cos(0.5*n);

figure;

subplot(5,1,1);
stem(n,u,'filled');
xlabel('n');
ylabel('ampli');
title('step signal');
grid on;

subplot(5,1,2);
stem(n,impulse,'filled');
title('impulse signal');
grid on;

subplot(5,1,3);
stem(n,ramp,"filled");
title('ramp signal');
grid on;

subplot(5,1,4);
stem(n,sin_w,"filled");
title('sin wave');
grid on;

subplot(5,1,5);
stem(n,sin_ww,"filled");
title('sin wave');
grid on;

subplot(5,1,6);
stem(n,cos_w,"filled");
title('cos wave');
grid on;
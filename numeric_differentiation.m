function [vx,vy,ax,ay] = numeric_differentiation(t,x,y)
%NUMERIC_DIFFERENTIATION Summary of this function goes here
%   Detailed explanation goes here

figure();
title("Numeric Differentiation of Sampled Data");

tiledlayout(3,3);

% Plot position, as given
nexttile
plot(x,y);
axis equal
hold on;

% Filter position just slightly
%x = movmean(x,3);
%y = movmean(y,3);
%t = movmean(t,3);

xlabel("x (m)");ylabel("y (m)");
title("Position");
nexttile
plot(t,x);
xlabel("t (s)"); ylabel("x (m)");
nexttile
plot(t,y);
xlabel("t (s)"); ylabel("y (m)");

% Compute simple velocity
vx = diff(x)./diff(t);
vy = diff(y)./diff(t);

% correct the time array
t2 = t(1:end-1)+diff(t)/2;

% Plot velocity
nexttile
quiver(zeros(size(vx)),zeros(size(vy)),vx,vy,"off");
axis equal
xlabel("v_x (m/s)");ylabel("v_y (m/s)");
title("Velocity");
nexttile
plot(t2,vx);
xlabel("\Delta t (s)"); ylabel("v_x (m/s)");
nexttile
plot(t2,vy);
xlabel("\Delta t (s)"); ylabel("v_y (m/s)");

% Compute simple acceleration
ax = diff(vx)./diff(t2);
ay = diff(vy)./diff(t2);

% correct the time array
t3 = t2(1:end-1)+diff(t2)/2;

% Plot accelerations
nexttile
quiver(zeros(size(ax)),zeros(size(ay)),ax,ay,"off");
axis equal
xlabel("a_x (m/s^2)");ylabel("a_y (m/s^2)");
title("Acceleration");
nexttile
plot(t3,ax);
xlabel("\Delta^2 t (s)"); ylabel("x (m/s^2)");
nexttile
plot(t3,ay);
xlabel("\Delta^2 t (s)"); ylabel("y (m/s^2)");

% FFT on y velocity
S = ay;
L = length(ay);
if(mod(L,2)==1)
    L = L - 1; % Make L even
end
S = S(1:L);
Y = fft(S);
Fs = 1/mean(diff(t));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs/L*(0:(L/2));
figure();
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

end


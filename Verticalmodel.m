%% model of objects vertical position in terms of time
y0=0;
v0=10;
g=9.81; % m/s^2
y= @(t)y0+v0*t-.5*g*t.^2;
t= linspace(0,2,100);
figure ()
fplot(y)
xlabel ('time (s)'); ylabel ('Vertical position (m)'); title ('Position vs Time ')


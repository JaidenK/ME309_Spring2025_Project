%% model of objects vertical position in terms of time
y0=0;
v0=10;
g=9.81;
y= @(t)y0+v0*t+.5*g*t^2;

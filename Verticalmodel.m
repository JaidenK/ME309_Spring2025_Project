%% model of objects vertical position in terms of time
clear all, close all, clc 
datadir= "C:\Users\Richard\Downloads\Clips-20250402T185746Z-001\Clips";
filename="Throw_01.txt";
fullPath = fullfile(datadir, filename);
data =readmatrix(fullPath);
tsampled=data(:,1);
ysampled=data(:,3);
i_impact =find (ysampled==min(ysampled)); %changed from i to i_impact cuz general practice 4 meaningful names
% index in array, showing the minimum y value i.e. impact
t_impact = tsampled(i_impact);
% previous code, arranges data
y0=ysampled(1);
v0=(ysampled(2)-ysampled(1))/(tsampled(2)-tsampled(1)); % Y component for the velocity, rise over run
%%v0=10;commented out
g=9.81; % m/s^2
y= @(t)y0+v0*t-.5*g*t.^2;
t= linspace(0,t_impact,100);
figure ()
%fplot(y,[0 3])
plot(t,y(t));
xlabel ('time (s)'); ylabel ('Vertical position (m)'); title ('Position vs Time ')
hold on 
plot(data(:,1),data(:,3));
legend ('model','sample');

Error_1= (ysampled(1:i_impact)-y(tsampled(1:i_impact))); % evaluating model at sampled times,
% 1 starts data at point 1, colon will give range, i_impact was used as a limit 
figure; plot(Error_1.^2)
xlabel ("Sample");
ylabel ("error^2")
title ("Error about Y-Position")

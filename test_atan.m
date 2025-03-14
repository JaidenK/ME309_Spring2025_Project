% Demonstrate that I know how atan function works
clear all; close all; clc;

%t = -.3:.1:(pi/2+.3);
%t = -.3:.1:(pi+.2);
t = -pi/4:.1:(pi+.2);
x = 5*cos(t);
y = 1.1*sin(t);

x = x';
y = y';

%x = [1 2 3 4 5  6  7];
%y = [1 1 1 1 .5 .5 .5];
%theta = atan(y./x);
theta = atan2(y,x);
angle_deg = rad2deg(theta)

clf;
fimplicit(@(x,y)x.^2+y.^2-1); % unit circle
hold on; axis equal;
yline(0); xline(0);
scatter(x,y);
for i=1:length(x)
    %text(x(i),y(i),sprintf("(%g,%g)",x(i),y(i)));    
end
hold on
quiver(zeros(size(x)),zeros(size(y)),cos(theta),sin(theta));


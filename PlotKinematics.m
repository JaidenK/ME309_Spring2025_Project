function [hFig] = PlotKinematics(Model,t,Parameters)
%PLOTKINEMATICS Summary of this function goes here
%   Detailed explanation goes here

% Evaluate model at specified time 
pos = Model.r_of_t(t);
vel = Model.v_of_t(t);
acc = Model.a_of_t(t);

hFig = figure();

title("Model Results");

tiledlayout(3,4);

%% Position
nexttile(1)
plot(pos(1,:),pos(2,:));
axis equal; grid on; grid minor;
xlabel("r_x (m)");ylabel("r_y (m)");title("Position");

nexttile(2) 
plot(t,pos(1,:)); grid on; grid minor;
xlabel("t (s)");ylabel("r_x (m)");

nexttile(3) 
plot(t,pos(2,:)); grid on; grid minor;
xlabel("t (s)");ylabel("r_y (m)");

%% Velocity
nexttile(5) 
quiver(zeros(size(vel(1,:))),zeros(size(vel(2,:))),vel(1,:),vel(2,:));
axis equal; grid on; grid minor;
xlabel("v_x (m/s)");ylabel("v_y (m/s)");title("Velocity");

nexttile(6) 
plot(t,vel(1,:)); grid on; grid minor;
xlabel("t (s)");ylabel("v_x (m/s)");

nexttile(7) 
plot(t,vel(2,:)); grid on; grid minor;
xlabel("t (s)");ylabel("v_y (m/s)");

%% Accelerometer
nexttile(9) 
quiver(zeros(size(acc(1,:))),zeros(size(acc(2,:))),acc(1,:),acc(2,:));
axis equal; grid on; grid minor;
xlabel("a_x (m/s^2)");ylabel("a_y (m/s^2)");title("Acceleration");

nexttile(10) 
plot(t,acc(1,:)); grid on; grid minor;
xlabel("t (s)");ylabel("a_x (m/s^2)");

nexttile(11) 
plot(t,acc(2,:)); grid on; grid minor;
xlabel("t (s)");ylabel("a_y (m/s^2)");

%% Additional info
nexttile(4)
info = {sprintf("g: %g",Parameters.g); ...
    sprintf("r0: (%g,%g)",Parameters.r0(1),Parameters.r0(2)); ...
    sprintf("v0: (%g,%g)",Parameters.v0(1),Parameters.v0(2))};
text(0,0,info);
axis off

end


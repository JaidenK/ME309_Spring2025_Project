function [Data] = numeric_differentiation(Data)
%NUMERIC_DIFFERENTIATION Summary of this function goes here
%   Detailed explanation goes here


% Filter position just slightly
%x = movmean(x,3);
%y = movmean(y,3);
%t = movmean(t,3);

Data.vel=struct();
% Compute simple velocity
Data.vel.x = diff(Data.x)./diff(Data.t);
Data.vel.y = diff(Data.y)./diff(Data.t);

% correct the time array
t2 = Data.t(1:end-1)+diff(Data.t)/2;
Data.vel.t=t2;

Data.acc=struct();
% Compute simple acceleration
Data.acc.x = diff(Data.vel.x)./diff(t2);
Data.acc.y = diff(Data.vel.y)./diff(t2);

t3 = t2(1:end-1)+diff(t2)/2;
Data.acc.t=t3;
end
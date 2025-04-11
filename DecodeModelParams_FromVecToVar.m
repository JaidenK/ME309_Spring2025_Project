function [g,initial_position,initial_velocity,drag_coef] = DecodeModelParams_FromVecToVar(ModelParameters)

%g                = ModelParameters.g;
%inital_position  = ModelParameters.r0;
%initial_velocity = ModelParameters.v0;

g                = 9.81;                                    % m/s^2
initial_position = [ModelParameters(1) ModelParameters(2)]; % m, m
initial_velocity = [ModelParameters(3) ModelParameters(4)]; % m/s, m/s
drag_coef        = ModelParameters(5);                      % units???

end


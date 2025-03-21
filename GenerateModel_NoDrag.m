function [Model] = GenerateModel_NoDrag(ModelParameters)
Model = struct();

% Decode parameters
g  = ModelParameters.g;
r0 = ModelParameters.r0;
v0 = ModelParameters.v0;

% implement equations that were derived in the notes.
Model.a_of_t = @(t) [zeros(size(t)); -g*ones(size(t))];
Model.v_of_t = @(t) [v0(1)*ones(size(t)); v0(2)-g*t];
Model.r_of_t = @(t) [v0(1)*t + r0(1); -(1/2)*g*t.^2 + v0(2)*t + r0(2)];
end
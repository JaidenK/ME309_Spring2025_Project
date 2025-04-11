function [Model] = GenerateModel_NoDrag(ModelParameters)
Model = struct();

% Decode parameters
[g,r0,v0,~] = DecodeModelParams_FromVecToVar(ModelParameters);

% implement equations that were derived in the notes.
Model.acc_of_t = @(t) [zeros(size(t)); -g*ones(size(t))];
Model.vel_of_t = @(t) [v0(1)*ones(size(t)); v0(2)-g*t];
Model.pos_of_t = @(t) [v0(1)*t + r0(1); -(1/2)*g*t.^2 + v0(2)*t + r0(2)];
end
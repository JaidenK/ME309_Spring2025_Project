function [Model] = GenerateModel_NoDrag(ModelParameters)
Model = struct();
Model.Params = ModelParameters;
Model.Description = "Parabolic Model (No Drag)";

% Decode parameters
[g,r0,v0,~] = DecodeModelParams_FromVecToVar(ModelParameters);

% implement equations that were derived analytically in the notes.
Model.acc_of_t.x = @(t) zeros(size(t));
Model.acc_of_t.y = @(t) -g*ones(size(t));
Model.vel_of_t.x = @(t) v0(1)*ones(size(t));
Model.vel_of_t.y = @(t) v0(2)-g*t;
Model.pos_of_t.x = @(t) v0(1)*t + r0(1); 
Model.pos_of_t.y = @(t) -(1/2)*g*t.^2 + v0(2)*t + r0(2);

% Estimate time of impact
% Make sure the estimated impact time is positive by looping while it's
% negative.
Model.tImpact = -1;
for t0=5:100
    if(Model.tImpact > 0)
        break;
    end
    Model.tImpact = fzero(Model.pos_of_t.y,t0);
end

% Estimate location of impact
Model.xImpact = Model.pos_of_t.x(Model.tImpact);

% Estimate velocity of impact
Model.vImpact = vecnorm([Model.vel_of_t.x(Model.tImpact) Model.vel_of_t.y(Model.tImpact)]);

end
function [Model] = GenerateModel_LinearDrag(ModelParameters)
Model = struct();
Model.Params = ModelParameters;
Model.Description = "Linear Drag Model";

% Decode parameters
[g,r0,v0,b] = DecodeModelParams_FromVecToVar(ModelParameters);
m=1;
% implement equations that were derived analytically in the notes.
Model.acc_of_t.x = @(t) -(b*v0(1)/m)*exp(-(b*t)/m);
Model.acc_of_t.y = @(t) -((b*v0(2)+g*m)/m)*exp(-(b*t)/m);
Model.vel_of_t.x = @(t) v0(1)*exp(-(b*t)/m);
Model.vel_of_t.y = @(t) (exp(-(b*t)/m)*(b*v0(2)+g*m)-g*m)/b;
Model.pos_of_t.x = @(t) ((m*v0(1))/(b))*(1-exp(-b*t/m)) + r0(1); 
Model.pos_of_t.y = @(t) (m/b)*(v0(2)+m*g/b)*(1-exp(-b*t/m))-(m*g*t/b) + r0(2);

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
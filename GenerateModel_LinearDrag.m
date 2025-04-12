function [Model] = GenerateModel_LinearDrag(ModelParameters)
Model = struct();
Model.Params = ModelParameters;
Model.Description = "Linear Drag Model";

% Decode parameters
[g,r0,v0,b] = DecodeModelParams_FromVecToVar(ModelParameters);
m=1;
% implement equations that were derived analytically in the notes.
% Model.acc_of_t.x = @(t) zeros(size(t));
% Model.acc_of_t.y = @(t) -g*ones(size(t));
 Model.vel_of_t.x = @(t) v0(1)*exp(-(b*t)/m);
 Model.vel_of_t.y = @(t) (exp(-(b*t)/m)*(b*v0(2)+g*m)-g*m)/b;
Model.pos_of_t.x = @(t) ((m*v0(1))/(b))*(1-exp(-b*t/m)) + r0(1); 
Model.pos_of_t.y = @(t) (m/b)*(v0(2)+m*g/b)*(1-exp(-b*t/m))-(m*g*t/b) + r0(2);

% Constants
    % m = 1;
    % g = 9.81;
    % % params
    % x0 = [params(1) params(2)];
    % u = [params(3) params(4)];
    % b = params(5);
    % % Functions
    % fx = @(t) ((m*u(1))/(b))*(1-exp(-b*t/m)) + x0(1);
    % fy = @(t) (m/b)*(u(2)+m*g/b)*(1-exp(-b*t/m))-(m*g*t/b) + x0(2);

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
function [Model,Error,GradientDescentResults] = GradientDescent_v2(whichModelType,Data,ModelParams)
% https://en.wikipedia.org/wiki/Gradient_descent

GradientDescentResults = struct();
GradientDescentResults.MeanError = [];
GradientDescentResults.SumSquaredError = [];
GradientDescentResults.ParamGradients = [];
GradientDescentResults.ModelParams = [];
nDimensions = length(ModelParams);
%NudgeVector = zeros(size(ModelParams));
epsilon = 0.001;
gamma = 0.01;
minDragCoef = epsilon+0.001;
maxDragCoef = 1;
nGradientDescentIterations = 500;

for i=1:nGradientDescentIterations
    [Error] = ComputeError(Data,GenerateModel(whichModelType,ModelParams));
    GradientDescentResults.MeanError(i) = Error.Mean;
    GradientDescentResults.SumSquaredError(i) = Error.SumSquared;

    % Assume that we start with an initial guess which is based off the 
    % observed velocity/position. This means the first thing we should tune
    % is the drag coefficient. I happen to know that the drag coefficient
    % is the last element of the parameter array. This is NOT a robust 
    % solution if we want to change the order of the parameters.
    NudgeVector = zeros(size(ModelParams));
    NudgeVector(end) = 1;
    f = @(x)ErrorFunction(x,whichModelType,Data,ModelParams,NudgeVector);        
    [nudge_multiplier,~] = fminbnd(f,-1,1);
    ModelParams = ModelParams+nudge_multiplier*NudgeVector;

    % Use the standard gradient for the remainder of the parameters
    ParamGradient = zeros(size(ModelParams));
    for j=1:nDimensions
        NudgeVector = zeros(size(ModelParams));
        NudgeVector(j) = 1;
        f = @(x)ErrorFunction(x,whichModelType,Data,ModelParams,NudgeVector);        
        ParamGradient(j) = (f(epsilon)-f(-epsilon))/(2*epsilon);
    end
    GradientDescentResults.ParamGradients(i,:) = ParamGradient;
    ModelParams = ModelParams-gamma*ParamGradient;
    
    GradientDescentResults.ModelParams(i,:) = ModelParams;

    % Hack: force the drag coefficient to stay within reasonable bounds
    ModelParams(5) = max([ModelParams(5) minDragCoef]);
    ModelParams(5) = min([ModelParams(5) maxDragCoef]);
end

[Model] = GenerateModel(whichModelType,ModelParams);
[Error] = ComputeError(Data,Model);

end

function e = ErrorFunction(x,whichModelType,Data,ModelParams,NudgeVector)
    [Model] = GenerateModel(whichModelType,ModelParams+x.*NudgeVector);
    [Error] = ComputeError(Data,Model);
    e = Error.SumSquared;
end


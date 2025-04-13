function [Model,Error,GradientDescentResults] = GradientDescent_v1(whichModelType,Data,ModelParams)
% https://en.wikipedia.org/wiki/Gradient_descent

GradientDescentResults = struct();
GradientDescentResults.MeanError = [];
GradientDescentResults.ParamGradients = [];
nDimensions = length(ModelParams);
%NudgeVector = zeros(size(ModelParams));
epsilon = 0.001;
gamma = 0.01;
minDragCoef = epsilon+0.001;
nGradientDescentIterations = 300;

for i=1:nGradientDescentIterations
    [Error] = ComputeError(Data,GenerateModel(whichModelType,ModelParams));
    GradientDescentResults.MeanError(i) = Error.Mean;

    ParamGradient = zeros(size(ModelParams));
    % Figure out which direction to step in to by computing partial
    % derivatives.
    for j=1:nDimensions
        NudgeVector = zeros(size(ModelParams));
        NudgeVector(j) = 1;
        f = @(x)ErrorFunction(x,whichModelType,Data,ModelParams,NudgeVector);        
        ParamGradient(j) = (f(epsilon)-f(-epsilon))/(2*epsilon);
    end
    GradientDescentResults.ParamGradients(i,:) = ParamGradient;
    ModelParams = ModelParams-gamma*ParamGradient;

    % Hack: force the drag coefficient to stay within reasonable bounds
    ModelParams(5) = max([ModelParams(5) minDragCoef]);
end

[Model] = GenerateModel(whichModelType,ModelParams);
[Error] = ComputeError(Data,Model);

end

function e = ErrorFunction(x,whichModelType,Data,ModelParams,NudgeVector)
    [Model] = GenerateModel(whichModelType,ModelParams+x.*NudgeVector);
    [Error] = ComputeError(Data,Model);
    e = Error.SumSquared;
end


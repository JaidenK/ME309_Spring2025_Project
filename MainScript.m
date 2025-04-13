%% Input/Configuration
user_options;

%% Load the data
[TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber);
Data = FormatData(RawData,DownsamplingValue);

% Lump some info into the struct to make it easier to pass around to
% functions (rather than relying on workspace variables directly)
Data.Info = struct();
Data.Info.TestNumber = TestNumber;
Data.Info.Description = TestDescription;
Data.Info.DownsamplingValue = DownsamplingValue;

% Clear the old vars from workspace to enforce consistency with struct usage
clear TestNumber TestDescription DownsamplingValue
clear RawData % This is inserted into the Data struct in the FormatData function

% Compute velocity and accel from sampled data.
% This is expected to be noisy and innaccurate, but that noise serves to demonstrate
% the utility of our model.
[Data] = numeric_differentiation(Data);

% Generate model parameters based on the data. 
% Initial guess can come from the first 2 sample points.
if(forceInitialParameterEstimation || (ModelParams(1) == 0))
    disp("Estimating initial parameters.");
    ModelParams = EstimateInitialModelParams(Data);
else
    disp("Using initial parameters from database.");
end

[Model] = GenerateModel(whichModelType,ModelParams);
[Error] = ComputeError(Data,Model);

[Model,Error,GradientDescentResults] = GradientDescent_v2(whichModelType,Data,ModelParams,nGradientDescentIterations);

if(generatePlots)
    QuickPlot_SampledData_Position(Data);
    QuickPlot_Model_Position(Model);
    QuickPlot_Combined_Position(Model,Data,Error);
    QuickPlot_NumericDifferentiation_vel_acc(Data);
    QuickPlot_NumericVsModel(Data,Model);
    QuickPlot_GradientDescentResults_MeanError(Data,GradientDescentResults);
    QuickPlot_GradientDescentResults_ParamGradient(Data,GradientDescentResults);
end
% TODO: We should step through each sample data point and calculate the
% estimated impact location using the data up to that point. This can then
% be used to generate a histogram of the predicted landing locations to
% show how much it deviates over the arc. 


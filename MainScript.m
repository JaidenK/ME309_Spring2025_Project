clear all; close all; clc;

%% Input/Configuration
TestNumber = 5;
DownsamplingValue = 10;

%% Load the data
[TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber);
Data = FormatData(RawData,DownsamplingValue);
% Lump some info into the struct to make it easier to pass around to
% functions (rather than relying on workspace variables directly)
Data.Info = struct();
Data.Info.TestNumber = TestNumber;
Data.Info.Description = TestDescription;
Data.Info.DownsamplingValue = DownsamplingValue;
% Clear the old vars from workspace to enforce consistency with struct
% usage
clear TestNumber
clear TestDescription
clear DownsamplingValue
clear RawData % This is inserted into the Data struct in the FormatData function

% TODO
% Compute velocity and accel from sampled data.
% This is expected to be noisy and innaccurate, but that noise serves to demonstrate
% the utility of our model.
%[vx_sampled,vy_sampled,ax_sampled,ay_sampled,hFig_numdif] = numeric_differentiation(t_sampled,x_sampled,y_sampled);

% TODO
% Generate model parameters based on the data. 
% Initial guess can come from the first 2 sample points.
% Use linear regression or gradient descent to fine tune the parameters.
% For now I'm using the parameters found in my other repo branch.
if(ModelParams(1) == 0)
    ModelParams = EstimateInitialModelParams(Data);
end

% Generate Model
[Model] = GenerateModel_NoDrag(ModelParams);

[Error] = ComputeError(Data,Model);

QuickPlot_SampledData_Position(Data);
QuickPlot_Model_Position(Model);
QuickPlot_Combined_Position(Model,Data,Error);


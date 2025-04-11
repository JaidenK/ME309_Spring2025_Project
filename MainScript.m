%clear all; close all; clc;

%% Input/Configuration
TestNumber = 6;
DownsamplingValue = 10;
forceInitialParameterEstimation = false;

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

% Generate model parameters based on the data. 
% Initial guess can come from the first 2 sample points.
if(forceInitialParameterEstimation || (ModelParams(1) == 0))
    disp("Estimating initial parameters.");
    ModelParams = EstimateInitialModelParams(Data);
else
    disp("Using initial parameters from database.");
end

% TODO
% Use linear regression or gradient descent to fine tune the parameters.
% E.g. [Model,Error] = GradientDescent(Data,ModelParams,nIterations)
% Gradient descent algorithm shown here (messy):
% https://github.com/JaidenK/ME309_Spring2025_Project/blob/JaidensBranch/TrajEst_TopScript.m
% Linear regression would be better if we can figure out how to linearize
% the system.

% TODO 
% Model with linear drag
% https://www.youtube.com/watch?v=Tr_TpLk3dY8

[Model] = GenerateModel_NoDrag(ModelParams);
[Error] = ComputeError(Data,Model);

QuickPlot_SampledData_Position(Data);
QuickPlot_Model_Position(Model);
QuickPlot_Combined_Position(Model,Data,Error);

% TODO: Plot to compare numeric differentiation results with model (noise
% comparison)

% TODO: We should step through each sample data point and calculate the
% estimated impact location using the data up to that point. This can then
% be used to generate a histogram of the predicted landing locations to
% show how much it deviates over the arc. 


clear all; close all; clc;

%% Input/Configuration
TestNumber = 2;
DownsamplingValue = 5;

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

% Generate Model
[Model] = GenerateModel_NoDrag(ModelParams);

QuickPlot_SampledData_Position(Data);
QuickPlot_Model_Position(Model);


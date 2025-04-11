clear all; close all; clc;

%% Input/Configuration
TestNumber = 1;
DownsamplingValue = 5;

%%
[TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber);
SampledData = FormatData(RawData,DownsamplingValue);

% TODO
% Compute velocity and accel from sampled data.
% This is expected to be noisy and innaccurate and serves to demonstrate
% the utility of our model.
%[vx_sampled,vy_sampled,ax_sampled,ay_sampled,hFig_numdif] = numeric_differentiation(t_sampled,x_sampled,y_sampled);

% Generate Model
[Model] = GenerateModel_NoDrag(ModelParams);



QuickPlot_SampledData(SampledData);


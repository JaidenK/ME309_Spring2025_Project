clear all; close all; clc;

ModelParameters = struct();
ModelParameters.r0 = [0; 1];
ModelParameters.v0 = [2; 9];
ModelParameters.g = 9.81;

Model = GenerateModel_NoDrag(ModelParameters);

t = linspace(0,2,100);
PlotKinematics(Model,t,ModelParameters);

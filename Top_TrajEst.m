clear all; close all; clc;

r0 = [0; 0]; % [meters, meters];
v0 = [1; 1];
g = 9.81; 

ModelParameters = struct();
ModelParameters.r0 = [0; 0];
ModelParameters.v0 = [1; 1];
ModelParameters.g = 9.81;

Model = GenerateModel_NoDrag(ModelParameters);
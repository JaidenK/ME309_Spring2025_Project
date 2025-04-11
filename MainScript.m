clear all; close all; clc;

TestNumber = 1;
DownsamplingValue = 10;

[TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber);
[t_sampled,x_sampled,y_sampled,xchute_sampled,ychute_sampled,hasChuteData] = FormatData(RawData,DownsamplingValue);

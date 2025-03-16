function [t_sampled,x_sampled,y_sampled,x2_sampled,y2_sampled,hasChuteData] = data_extraction(data)
%DATA_EXTRACTION Summary of this function goes here
%   Detailed explanation goes here
t_sampled = data(:,1);
x_sampled = data(:,2);
y_sampled = data(:,3);
hasChuteData = false;
if(size(data,2)>3)
    x2_sampled = data(:,4);
    y2_sampled = data(:,5);
    hasChuteData = true;
end
end


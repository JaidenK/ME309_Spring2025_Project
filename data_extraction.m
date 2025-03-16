function [t_sampled,x_sampled,y_sampled,x2_sampled,y2_sampled,hasChuteData] = data_extraction(data)
%DATA_EXTRACTION Summary of this function goes here
%   Detailed explanation goes here


y_sampled = data(:,3);

% Find the impact index and cut off the rebound for simplicity.
% Assume the lowest y position is impact. This isn't true if it bounces a
% second time, closer to the camera
iImpact = find(y_sampled == min(y_sampled));

t_sampled = data(1:iImpact,1);
x_sampled = data(1:iImpact,2);
y_sampled = data(1:iImpact,3);
hasChuteData = false;
x2_sampled = zeros(size(x_sampled));
y2_sampled = zeros(size(y_sampled));
if(size(data,2)>3)
    x2_sampled = data(1:iImpact,4);
    y2_sampled = data(1:iImpact,5);
    hasChuteData = true;
end



end


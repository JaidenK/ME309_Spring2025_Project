function [t_sampled,x_sampled,y_sampled,xchute_sampled,ychute_sampled,hasChuteData] = FormatData(RawData,DownsamplingValue)
%FORMATDATA Summary of this function goes here
%   Detailed explanation goes here



y_sampled = RawData(:,3);

% Find the impact index and cut off the rebound for simplicity.
% Assume the lowest y position is impact. This isn't true if it bounces a
% second time, closer to the camera
iImpact = find(y_sampled == min(y_sampled));

t_sampled = RawData(1:iImpact,1);
x_sampled = RawData(1:iImpact,2);
y_sampled = RawData(1:iImpact,3);
hasChuteData = false;
xchute_sampled = zeros(size(x_sampled));
ychute_sampled = zeros(size(y_sampled));
if(size(RawData,2)>3)
    xchute_sampled = RawData(1:iImpact,4);
    ychute_sampled = RawData(1:iImpact,5);
    hasChuteData = true;
end


t_sampled = downsample(t_sampled,DownsamplingValue);
x_sampled = downsample(x_sampled,DownsamplingValue);
y_sampled = downsample(y_sampled,DownsamplingValue);
if(hasChuteData)
    xchute_sampled = downsample(xchute_sampled,DownsamplingValue);
    ychute_sampled = downsample(ychute_sampled,DownsamplingValue);
end



end


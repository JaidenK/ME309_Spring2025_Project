function [SampledData] = FormatData(RawData,DownsamplingValue)

% If we wanted to limit the data to only the first portion of the throw to
% simulate evaluating mid-flight, we'd do that somewhere in this function
% probably.

% Remove all rows containing NaN
RawData(any(isnan(RawData), 2), :) = []; % https://www.mathworks.com/matlabcentral/answers/31971-delete-rows-with-nan-records

y_sampled = RawData(:,3);

% Find the impact index and cut off the rebound for simplicity.
% Assume the lowest y position is impact. This isn't true if, for example,
% it bounces a second time closer to the camera
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

% Toss the data into a struct for organization
SampledData = struct();
SampledData.t = t_sampled;
SampledData.x = x_sampled;
SampledData.y = y_sampled;
SampledData.hasChute = hasChuteData;
if(SampledData.hasChute)
    SampledData.Chute = struct();
    SampledData.Chute.x = xchute_sampled;
    SampledData.Chute.y = ychute_sampled;    
end
% Does it make sense to store the raw data in this struct too?
SampledData.Raw = struct();
SampledData.Raw.t = RawData(:,1);
SampledData.Raw.x = RawData(:,2);
SampledData.Raw.y = RawData(:,3);
SampledData.Raw.iImpact = iImpact;

end


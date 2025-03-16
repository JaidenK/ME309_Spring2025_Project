function [data] = data_processing(data)
%DATA_PROCESSING Summary of this function goes here
%   Detailed explanation goes here
% Data Processing Algorithms
% - Remove duplicate frames. Essentially a low pass filter? Cull outliers?
% - Iteratively cull outliers until minimium number of fit points perfectly
% define the plot.
% - This data processing algorithm is a great example of an unanticipated
% issue that I could've forseen. 
figure(); 
ax1 = subplot(4,1,1);
xy_diff = diff(data(:,[2 3]));
plot(xy_diff(:,1),'DisplayName','diff(x)'); 
hold on; 
plot(xy_diff(:,2),'DisplayName','diff(y)');
xy_means = movmean(xy_diff,5,1);
plot(xy_means);
title("Data Processing Algo: Detecting frozen frames");
ylabel("element-wise difference (meters)");
legend;
ax2 = subplot(4,1,2);
xy_highpass = xy_means-xy_diff;
plot(xy_highpass);
hold on;
ax3 = subplot(4,1,3);
kernel = [-.25 -.25 1];
outliers = zeros(size(xy_highpass));
for i=(length(kernel)):size(outliers,1)
    rows = (i-length(kernel)+1):i;
    thresh = .02;
    outliers(i,1) = all((xy_highpass(rows,1).*kernel')>0) && (max(xy_highpass(rows,1)) > thresh);
    outliers(i,2) = all((xy_highpass(rows,2).*kernel')>0) && (max(xy_highpass(rows,2)) > thresh);
end
plot(outliers);
outliers = outliers(:,1) | outliers(:,2);
hold on;
iOutliers = find(outliers);
iiOutliers = zeros(size(iOutliers).*[length(kernel) 1]);
for i = 1:length(iOutliers)
    index = (length(kernel)*(i-1));
    iiOutliers(index+1) = iOutliers(i)-0;
    iiOutliers(index+2) = iOutliers(i)-1;
    iiOutliers(index+3) = iOutliers(i)-2;
end
ax4 = subplot(4,1,4);
% Remove the data
data(iiOutliers,:) = [];
xy_diff = diff(data(:,[2 3]));
plot(xy_diff(:,1)./diff(data(:,1))); 
hold on;
plot(xy_diff(:,2)./diff(data(:,1))); 

linkaxes([ax1 ax2 ax3 ax4],'x');

% Remove all rows containing NaN
data(any(isnan(data), 2), :) = []; % https://www.mathworks.com/matlabcentral/answers/31971-delete-rows-with-nan-records


end


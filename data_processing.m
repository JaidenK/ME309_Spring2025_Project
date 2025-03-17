function [data] = data_processing(data)
%DATA_PROCESSING Summary of this function goes here
%   Detailed explanation goes here
% Data Processing Algorithms
% - Remove duplicate frames. Essentially a low pass filter? Cull outliers?
% - Iteratively cull outliers until minimium number of fit points perfectly
% define the plot.
% - This data processing algorithm is a great example of an unanticipated
% issue that I could've forseen. 

% Remove all rows containing NaN
data(any(isnan(data), 2), :) = []; % https://www.mathworks.com/matlabcentral/answers/31971-delete-rows-with-nan-records

figure(); 
ax1 = subplot(2,1,1);
xy_diff = diff(data(:,[2 3]));
t = data(:,1);
t_mid = t(1:end-1) + diff(t)/2;
plot(t_mid,xy_diff(:,1)./diff(t),'DisplayName','v_x'); 
hold on; 
plot(t_mid,xy_diff(:,2)./diff(t),'DisplayName','v_y');
%xy_means = movmean(xy_diff,5,1);
%plot(xy_means);
yline(0,'DisplayName','0');
title("Data Processing Algo: Detecting frozen frames");
ylabel("v (m/s)");
legend;

%ax2 = subplot(2,1,2);
%xy_highpass = xy_means-xy_diff;
%plot(xy_highpass);
%ylabel("High pass");
%hold on;

%ax3 = subplot(4,1,3);
iOutliers = [];
for i = 1:length(xy_diff(:,1))    
    if(any(xy_diff(i,:)==0))
        iOutliers(end+1) = i+1;
    end
end
scatter(t(iOutliers),zeros(size(iOutliers)),'DisplayName','Outliers');
%disp(iOutliers);

%outliers = outliers(:,1) | outliers(:,2);
%ylabel("outliers")
%hold on;
%iOutliers = find(outliers);
%iiOutliers = zeros(size(iOutliers).*[length(kernel) 1]);
%for i = 1:length(iOutliers)
%    index = (length(kernel)*(i-1));
%    iiOutliers(index+1) = iOutliers(i)-0;
%    iiOutliers(index+2) = iOutliers(i)-1;
%    iiOutliers(index+3) = iOutliers(i)-2;
%end

ax4 = subplot(2,1,2);
% Remove the data
data(iOutliers,:) = [];
% Recompute time stuff
t = data(:,1);
t_mid = t(1:end-1) + diff(t)/2;
xy_diff = diff(data(:,[2 3]));
%t = data(1:end-1,1);
%plot(t,xy_diff(:,1)./diff(data(:,1))); 
plot(t_mid,xy_diff(:,1)./diff(t)); 
hold on;
%plot(t,xy_diff(:,2)./diff(data(:,1))); 
plot(t_mid,xy_diff(:,2)./diff(t)); 
yline(0);
%linkaxes([ax1 ax2 ax3 ax4],'x');
%linkaxes([ax1 ax4],'x');
linkaxes([ax1 ax4]);
ylabel("v (m/s)");
xlabel("t (s)");

end


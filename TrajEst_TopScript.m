clear all; close all; clc;

% Tracker Data
%input_file = "D:\CSUN\ME309\Project\GoogleDrive\Filming Day 1\Clips\Throw_01.txt";
%input_file = "D:\CSUN\ME309\Project\GoogleDrive\Filming Day 1\Clips\Throw_02.txt";
input_file = "D:\CSUN\ME309\Project\GoogleDrive\Filming Day 1\Clips\Throw_03.txt";
downsample_value = 5;

% Assume data is formatted as 3 columns ordered: t, x, y
% Assume time in seconds
data = readmatrix(input_file);
% Data Processing Algorithms
% - Remove duplicate frames. Essentially a low pass filter? Cull outliers?
% - Iteratively cull outliers until minimium number of fit points perfectly
% define the plot.
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
iOutliers = find(outliers)
iiOutliers = zeros(size(iOutliers))
for i = 1:length(iiOutliers)
    index = (length(kernel)*(i-1));
    iiOutliers(index+1) = iOutliers(i)-0;
    iiOutliers(index+2) = iOutliers(i)-1;
    iiOutliers(index+3) = iOutliers(i)-2;
end
ax4 = subplot(4,1,4);
% Remove the data
data(iiOutliers,:) = [];
xy_diff = diff(data(:,[2 3]));
plot(xy_diff(:,1)); 
hold on;
plot(xy_diff(:,2)); 

linkaxes([ax1 ax2 ax3 ax4],'x');

% Remove all rows containing NaN
data(any(isnan(data), 2), :) = []; % https://www.mathworks.com/matlabcentral/answers/31971-delete-rows-with-nan-records
t_sampled = data(:,1);
x_sampled = data(:,2);
y_sampled = data(:,3);
hasChuteData = false;
if(size(data,2)>3)
    x2_sampled = data(:,4);
    y2_sampled = data(:,5);
    hasChuteData = true;
end


% Plot raw data to confirm we're on the right track
hFig_raw = figure();
plot(x_sampled,y_sampled,'d');
hold on;
if(hasChuteData)
    quiver(x_sampled,y_sampled,x2_sampled-x_sampled,y2_sampled-y_sampled);
end
title("Sampled Positions");
ylim([0 max(y_sampled)+1]);
axis equal
xlabel("x (m)"); ylabel("y (m)");

% Calculate when the impact occurred based on a naive interpretation of
% the data.
t_impact_measured = t_sampled(y_sampled==min(y_sampled));
% Downsample for visual clarity

t_sampled = downsample(t_sampled,downsample_value);
x_sampled = downsample(x_sampled,downsample_value);
y_sampled = downsample(y_sampled,downsample_value);
if(hasChuteData)
    x2_sampled = downsample(x2_sampled,downsample_value);
    y2_sampled = downsample(y2_sampled,downsample_value);
end
% Cap samples to data near the expected impact time to avoid fitting to
% data after the bounce
t_sampled = t_sampled(t_sampled < t_impact_measured);
x_sampled = x_sampled(t_sampled < t_impact_measured);
y_sampled = y_sampled(t_sampled < t_impact_measured);
if(hasChuteData)
    x2_sampled = x2_sampled(t_sampled < t_impact_measured);
    y2_sampled = y2_sampled(t_sampled < t_impact_measured);
end

% Plot any trajectory
% Make initial guesses from first 2 samples.
x0 = [x_sampled(1) y_sampled(1)]; 
u = [(x_sampled(2)-x_sampled(1)) (y_sampled(2)-y_sampled(1))]/(t_sampled(2)-t_sampled(1)); 
b = 1;
nudge = zeros(1,5);
epsilon = 0.2;
params = [x0 u b];

xlims = get(gca,'XLim');
ylims = get(gca,'YLim');

hFig_traj = figure();
hold on;
axis equal

nudges = zeros(50,length(nudge));

for frameNo=1:50
    clf;

    nudges(frameNo,:) = nudge;
    params = params + nudge;

    [fx,fy] = GetComponentFunctions(params);
    t_impact = fzero(fy,max(t_sampled)); % Search for y=0 starting near end of data       
    fplot(fx,fy,[0 abs(t_impact)]);
    hold on;
    axis equal
    ylim(ylims);
    xlim(xlims);
    % Also plot the sampled points
    scatter(x_sampled,y_sampled);
    if(hasChuteData)
        quiver(x_sampled,y_sampled,x2_sampled-x_sampled,y2_sampled-y_sampled);
    end
    hold on;
    xlabel("x(t)"); ylabel("y(t)"); title("Estimated trajectory.");
    
    %title({"Trajectory w/ linear drag",sprintf("Error_{%d}: %g",frameNo,GetError(params,sampled_data))});

    % Plot the error
    nSamples = length(x_sampled);
    for i = 1:nSamples
        ti = t_sampled(i);
        xi = x_sampled(i);
        yi = y_sampled(i);
        plot([xi fx(ti)],[yi fy(ti)],'r');
    end
    
    % Compute gradient
    little_nudge = [0 0 0 0 0];
    err = [0 0 0 0 0];
    for i = 1:5
        littlest_nudge = [0 0 0 0 0];
        littlest_nudge(i) = epsilon;
        f = @(x)GetError(params+x.*littlest_nudge,[t_sampled x_sampled y_sampled]);        
        [nudge_val,err_val] = fminbnd(f,-1,1);
        err(i) = err_val;
        little_nudge(i) = nudge_val*epsilon;
    end
    
    i_min = find(err == min(err),1);
    nudge = [0 0 0 0 0];
    nudge(i_min) = nudge(i_min) + little_nudge(i_min);

    currentErr = GetError(params,[t_sampled x_sampled y_sampled]);
    
    text(10,10,{ ...
        sprintf("x0: %g, %g",params(1),params(2)), ...
        sprintf("v0: %g, %g",params(3),params(4)), ...
        sprintf("b: %g",params(5)), ...
        sprintf("err: %g",currentErr)
        },'Units','pixels' ...
        ,'VerticalAlignment','bottom');

    pause(1/24);
    if(currentErr < 0)
        break;
    end
end

hFig_nudges = figure();
% Witness the results of gradient descent
pcolor(log(abs([nudges zeros(size(nudges,1),1)])));
ylabel("iteration");
xlabel("parameter");
title("Nudges at every iteration")


function [fx,fy] = GetComponentFunctions(params)
    % Constants
    m = 1;
    g = 9.81;
    % params
    x0 = [params(1) params(2)];
    u = [params(3) params(4)];
    b = params(5);
    % Functions
    fx = @(t) ((m*u(1))/(b))*(1-exp(-b*t/m)) + x0(1);
    fy = @(t) (m/b)*(u(2)+m*g/b)*(1-exp(-b*t/m))-(m*g*t/b) + x0(2);
end

function [normalized_error] = GetError(params,sampled_data)
    [x,y] = GetComponentFunctions(params);

    nSamples = size(sampled_data,1);
    error = zeros(size(sampled_data(:,1)));
    for i = 1:nSamples
        ti = sampled_data(i,1);
        xi = sampled_data(i,2);
        yi = sampled_data(i,3);
        error(i) = norm([xi-x(ti) yi-y(ti)]);
    end
    normalized_error = sum(error.^2)/nSamples;
end
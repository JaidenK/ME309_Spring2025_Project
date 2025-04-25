function QuickPlot_ImpactHistogram(ImpactLocations,Data)

nBuckets = 50;
width = 2; % meters

figure();
histogram(ImpactLocations(ImpactLocations ~= 0),nBuckets); % 100 arbitrary. Just looks nice.
xline(Data.x(end)); % "actual" impact location
grid on
title({sprintf("Test %d Impact Location Histogram",Data.Info.TestNumber),"Impact location estimated on each frame of video."});
xlabel("x (m)");
xlim([Data.x(end) - width/2 Data.x(end) + width/2]);

end


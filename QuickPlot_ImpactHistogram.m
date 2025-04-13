function QuickPlot_ImpactHistogram(ImpactLocations,Data)

figure();
histogram(ImpactLocations,100); % 100 arbitrary. Just looks nice.
xline(Data.x(end)); % "actual" impact location
grid on
title({sprintf("Test %d Impact Location Histogram",Data.Info.TestNumber),"Impact location estimated on each frame of video."});
xlabel("x (m)");

end


function QuickPlot_ImpactError(ImpactLocations,Data)

figure();
plot(ImpactLocations);
yline(Data.x(end)); % "actual" impact location
grid on
title({sprintf("Test %d Impact Location Error",Data.Info.TestNumber),"Impact location estimated on each frame of video."});
xlabel("frame"); ylabel("Estimated Impact Location (m)");

end


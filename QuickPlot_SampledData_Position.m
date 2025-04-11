function QuickPlot_SampledData_Position(SampledData)

figure();

plot(SampledData.Raw.x,SampledData.Raw.y);
hold on;
scatter(SampledData.x,SampledData.y);

title({sprintf("Test %d Sampled Data",SampledData.Info.TestNumber),"XY Position",SampledData.Info.Description});
xlabel("x (m)"); ylabel("y (m)");
yline(0);
axis equal;
grid on;

end


function QuickPlot_SampledData(SampledData)

figure();

plot(SampledData.Raw.x,SampledData.Raw.y);
hold on;
scatter(SampledData.x,SampledData.y);

title({"Sampled Data","XY Position"});
xlabel("x (m)"); ylabel("y (m)");
end


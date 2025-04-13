function QuickPlot_GradientDescentResults_MeanError(Data,GradientDescentResults)

figure();
plot(GradientDescentResults.MeanError);
xlabel("iteration");ylabel("Mean Error (m)");

title({sprintf("Test %d",Data.Info.TestNumber),"Gradient Descent Mean Error"});

end


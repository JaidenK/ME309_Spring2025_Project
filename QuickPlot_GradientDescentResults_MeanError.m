function QuickPlot_GradientDescentResults_MeanError(Data,GradientDescentResults)

figure();
plot(GradientDescentResults.MeanError);
xlabel("iteration");ylabel("Mean Error (m)");
hold on
%yyaxis right
%plot(GradientDescentResults.SumSquaredError);
%ylabel("Sum Error^2 (m)");

title({sprintf("Test %d",Data.Info.TestNumber),"Gradient Descent Mean Error"});

end


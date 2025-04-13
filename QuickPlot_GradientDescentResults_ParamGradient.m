function QuickPlot_GradientDescentResults_ParamGradient(Data,GradientDescentResults)

figure();
ax1 = subplot(2,1,1);
plot(GradientDescentResults.ParamGradients);
xlabel("iteration");

title({sprintf("Test %d",Data.Info.TestNumber),"Gradient Descent","Parameter Gradient"});

ax2 = subplot(2,1,2);
plot(GradientDescentResults.ModelParams);
xlabel("iteration");

title("Model Parameters");

linkaxes([ax1 ax2],'x');


end


function QuickPlot_Combined_Position(Model,Data,Error)

figure();

t = linspace(0,Model.tImpact,60);

plot(Model.pos_of_t.x(t),Model.pos_of_t.y(t));
hold on;
scatter(Data.x,Data.y);
quiver(Model.pos_of_t.x(Data.t),Model.pos_of_t.y(Data.t),Error.x,Error.y,"off",'color',[1 0 0]);

title({sprintf("Test %d Model Fit Analysis",Data.Info.TestNumber),"XY Position",Model.Description,Data.Info.Description,sprintf("Mean Error: %g m",Error.Mean)});
xlabel("x (m)"); ylabel("y (m)");
yline(0);
axis equal;
grid on;

end


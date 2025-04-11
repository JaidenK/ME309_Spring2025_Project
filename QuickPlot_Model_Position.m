function QuickPlot_Model_Position(Model)

figure();

t = linspace(0,Model.tImpact,60);
plot(Model.pos_of_t.x(t),Model.pos_of_t.y(t));
hold on
scatter(Model.xImpact,0);

title({Model.Description,"XY Position",sprintf("x_{impact}: %g m, v_{impact}: %g m/s",Model.xImpact,Model.vImpact)});
xlabel("x (m)"); ylabel("y (m)");
yline(0);
axis equal;
grid on;

end


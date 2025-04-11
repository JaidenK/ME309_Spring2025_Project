function QuickPlot_Model_Position(Model)

figure();

t = linspace(0,Model.tImpact,60);
plot(Model.pos_of_t.x(t),Model.pos_of_t.y(t));

title({Model.Description,"XY Position"});
xlabel("x (m)"); ylabel("y (m)");
yline(0);
axis equal;
grid on;

end


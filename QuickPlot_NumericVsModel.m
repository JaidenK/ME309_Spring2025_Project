function QuickPlot_NumericVsModel(Data,Model)


t = linspace(0,Model.tImpact,60);
model_v_magnitude = vecnorm([Model.vel_of_t.x(t); Model.vel_of_t.y(t)]);
model_a_magnitude = vecnorm([Model.acc_of_t.x(t); Model.acc_of_t.y(t)]);

sampled_v_magnitude = vecnorm([Data.vel.x(:)'; Data.vel.y(:)']);
sampled_a_magnitude = vecnorm([Data.acc.x(:)'; Data.acc.y(:)']);
sampling_Hz = 1/mean(diff(Data.t));

figure();
tiledlayout(2,2);

nexttile([2 1]);
scatter(Data.x,Data.y);
hold on
plot(Model.pos_of_t.x(t),Model.pos_of_t.y(t));
xlabel("x (m)"); ylabel("y (m)");
grid on;
axis equal
yline(0);

ax1 = nexttile;
plot(Data.vel.t,sampled_v_magnitude);
hold on;
plot(t,model_v_magnitude);
xlabel("t (s)"); ylabel("|v| (m/s)");
grid on;
yline(0);

ax2 = nexttile;
plot(Data.acc.t,sampled_a_magnitude);
hold on;
plot(t,model_a_magnitude);
xlabel("t (s)"); ylabel("|a| (m/s)");
grid on;
yline(0);

linkaxes([ax1 ax2],'x');
sgtitle({sprintf("Test %d",Data.Info.TestNumber),"Numeric Differentiation vs Model",sprintf("Sampling interval=%d (%g Hz)",Data.Info.DownsamplingValue,sampling_Hz),Data.Info.Description});

end


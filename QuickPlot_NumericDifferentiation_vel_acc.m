function QuickPlot_NumericDifferentiation_vel_acc(Data)

figure();
ax1=subplot(2,2,1);
plot(Data.vel.t,Data.vel.x);
xlabel("t (s)");
ylabel("v_x (m/s)");
grid on;
yline(0);
ax2=subplot(2,2,2);
plot(Data.vel.t,Data.vel.y);
xlabel("t (s)");
ylabel("v_y (m/s)");
grid on;
yline(0);
ax3=subplot(2,2,3);
plot(Data.acc.t,Data.acc.x);
xlabel("t (s)");
ylabel("a_x (m/s^2)");
grid on
yline(0);
ax4=subplot(2,2,4);
plot(Data.acc.t,Data.acc.y);
xlabel("t (s)");
ylabel("a_y (m/s^2)");
grid on
yline(0);

linkaxes([ax1 ax2],'y');
linkaxes([ax3 ax4],'y');
linkaxes([ax1 ax2 ax3 ax4],'x');

sampling_Hz = 1/mean(diff(Data.t));
sgtitle({sprintf("Test %d Sampled Data",Data.Info.TestNumber),"Numeric Differentiation",sprintf("Sampling interval=%d (%g Hz)",Data.Info.DownsamplingValue,sampling_Hz),Data.Info.Description});


end
function AnimatedPlot_Combined_ImpactPrediction(FrameInfo,ImpactLocations)

figure();

xlims = [min(FrameInfo(end).Data.Raw.x) max(FrameInfo(end).Data.Raw.x)];
xlims = xlims + [-1 1];
ylims = [min(FrameInfo(end).Data.Raw.y) max(FrameInfo(end).Data.Raw.y)];
ylims = ylims + [-1 1];

% Make limits equal
% if(diff(xlims)>diff(ylims))
%     ylims = xlims;
% else
%     xlims = ylims;
% end

for frameNo = 1:length(FrameInfo)    
    clf;

    Data = FrameInfo(frameNo).Data;
    Model = FrameInfo(frameNo).Model;
    if(isempty(Data))
        continue;
    end

    t = linspace(0,Model.tImpact,60);
    
    plot(Model.pos_of_t.x(t),Model.pos_of_t.y(t));
    hold on;
    scatter(Data.x,Data.y);
    scatter(ImpactLocations(1:frameNo),zeros(frameNo,1),'x');
    
    title({sprintf("Test %d Impact Estimation Analysis",FrameInfo(end).Data.Info.TestNumber),FrameInfo(end).Model.Description,FrameInfo(end).Data.Info.Description});
    xlabel("x (m)"); ylabel("y (m)");
    yline(0);
    xlim(xlims);
    ylim(ylims);
    %axis equal;
    grid on;

    pause(1/60);
end

end


clear all; close all; clc;
drawAxes = false;

figure('color','white');
hold on;
%set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

% Draw axes
if(drawAxes)
    axis_points = [1 0; 0 1; -1 0; 0 -1] * 5;
    quiver(zeros(size(axis_points(:,1))),...
           zeros(size(axis_points(:,2))),...
           axis_points(:,1),...
           axis_points(:,2),'Color',[0.8 0.8 0.8]);
    text(axis_points(1,1),axis_points(1,2),"$+x$",'HorizontalAlignment','left','VerticalAlignment','middle','Interpreter','latex');
    text(axis_points(2,1),axis_points(2,2),"$+y$",'HorizontalAlignment','center','VerticalAlignment','bottom','Interpreter','latex');
    %text(axis_points(3,1),axis_points(3,2),"$-x$",'HorizontalAlignment','right','VerticalAlignment','middle','Interpreter','latex');
    %text(axis_points(4,1),axis_points(4,2),"$-y$",'HorizontalAlignment','center','VerticalAlignment','top','Interpreter','latex');
end

% Draw the point mass itself, located at the origin.
scatter(0,0,120,'filled','MarkerEdgeColor',[117, 23, 40]/255, ...
    'MarkerFaceColor',[148, 38, 57]/255,'LineWidth',1.5);

set(gca,'Box','off');
%set(gca,'XTick',[], 'YTick', []);


vec(1).forces = [0 -9.8];
%vec(1).text = {"$g$",sprintf("%g",norm(vec(1).forces))};
vec(1).text = {"$g$"};
vec(1).position = 1.2;

vec(2).forces = [5 -5];
%vec(2).text = {"$v$",sprintf("%g",norm(vec(2).forces))};
vec(2).text = {"$v$"};
vec(2).position = 1.2;

vec(3).forces = [-3 3];
%vec(3).text = {"$f_{drag}$",sprintf("%g",norm(vec(3).forces))};
vec(3).text = {"$f_{drag}$"};
vec(3).position = 1.5;

for i=1:length(vec)
    vec(i).hQuiv = quiver(0,0,vec(i).forces(1),vec(i).forces(2),"off");
    vec(i).hText = text(vec(i).forces(1)*vec(i).position,vec(i).forces(2)*vec(i).position,vec(i).text,'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex');
end

axis equal
axis off
lims = max(max(abs([vec(:).forces])))*[-1.5 1.5];
xlim(lims);
ylim(lims);
fontsize(16,'points');

% Animation. Requires function populated in workspace.
% frame_period = 1/60;
% for t=0:frame_period:t_impact    
%     vec(2).forces = [Dfx([t-0.1 t])/0.1 Dfy([t-0.1 t])/0.1];
%     vec(2).text = {"$v$",sprintf("%g",norm(vec(2).forces))};
% 
%     for i=1:length(vec)
%         vec(i).hQuiv.UData = vec(i).forces(1);
%         vec(i).hQuiv.VData = vec(i).forces(2);
%         vec(i).hText.String = vec(i).text;
%         vec(i).hText.Position = [vec(i).forces(1)*vec(i).position,vec(i).forces(2)*vec(i).position];
%     end
% 
%     pause(frame_period);
% end
clear all; close all; clc;



figure('color','white');
%set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

% Draw axes
axis_points = [1 0; 0 1; -1 0; 0 -1] * 5;
quiver(zeros(size(axis_points(:,1))),...
       zeros(size(axis_points(:,2))),...
       axis_points(:,1),...
       axis_points(:,2),'Color',[0.8 0.8 0.8]);
hold on;
text(axis_points(1,1),axis_points(1,2),"$+x$",'HorizontalAlignment','left','VerticalAlignment','middle','Interpreter','latex');
text(axis_points(2,1),axis_points(2,2),"$+y$",'HorizontalAlignment','center','VerticalAlignment','bottom','Interpreter','latex');
%text(axis_points(3,1),axis_points(3,2),"$-x$",'HorizontalAlignment','right','VerticalAlignment','middle','Interpreter','latex');
%text(axis_points(4,1),axis_points(4,2),"$-y$",'HorizontalAlignment','center','VerticalAlignment','top','Interpreter','latex');

% Draw the point mass itself, located at the origin.
scatter(0,0,120,'filled','MarkerEdgeColor',[117, 23, 40]/255, ...
    'MarkerFaceColor',[148, 38, 57]/255,'LineWidth',1.5);

set(gca,'Box','off');
%set(gca,'XTick',[], 'YTick', []);


vec(1).forces = [0 -9.8];
vec(1).text = {"$g$",sprintf("%g",norm(vec(1).forces))};
vec(1).position = 1.2;

vec(2).forces = [5 -5];
vec(2).text = {"$v$",sprintf("%g",norm(vec(2).forces))};
vec(2).position = 1.2;

vec(3).forces = [-3 3];
vec(3).text = {"$f_{drag}$",sprintf("%g",norm(vec(3).forces))};
vec(3).position = 1.5;

for i=1:length(vec)
    quiver(0,0,vec(i).forces(1),vec(i).forces(2),"off");
    text(vec(i).forces(1)*vec(i).position,vec(i).forces(2)*vec(i).position,vec(i).text,'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex');
end

axis equal
axis off
lims = max(max(abs([vec(:).forces])))*[-1.5 1.5];
xlim(lims);
ylim(lims);
fontsize(16,'points');



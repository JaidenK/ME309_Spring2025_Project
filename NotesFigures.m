% This document is used to generate qualitative diagrams for the notes pdf.
% By design it does not require any real data to generate the plots.

% Make Great MATLAB Figures for your Scientific Paper or your PhD Thesis
% https://youtu.be/wP3jjk1O18A

%% Fig 1
clear all; clc;

f1 = figure(1);
clf
set(f1,'color','white');
%set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

% Draw axes
axis_points = [20 0; 0 20; -5 0; 0 -5];
quiver(zeros(size(axis_points(:,1))),...
       zeros(size(axis_points(:,2))),...
       axis_points(:,1),...
       axis_points(:,2),'Color',[0.8 0.8 0.8]);
hold on;
text(axis_points(1,1),axis_points(1,2),"$+x$",'HorizontalAlignment','left','VerticalAlignment','middle','Interpreter','latex');
text(axis_points(2,1),axis_points(2,2),"$+y$",'HorizontalAlignment','center','VerticalAlignment','bottom','Interpreter','latex');
%text(axis_points(3,1),axis_points(3,2),"$-x$",'HorizontalAlignment','right','VerticalAlignment','middle','Interpreter','latex');
%text(axis_points(4,1),axis_points(4,2),"$-y$",'HorizontalAlignment','center','VerticalAlignment','top','Interpreter','latex');


% Position vector
r = [15 15];
% Draw the point mass
scatter(r(1),r(2),80,'filled','MarkerEdgeColor',[117, 23, 40]/255, ...
    'MarkerFaceColor',[148, 38, 57]/255,'LineWidth',1.5);
quiver(0,0,r(1),r(2),"off");
text(r(1)/2,r(2)/2,"$\bf r$",'HorizontalAlignment','left','VerticalAlignment','top');

% Velocity vector
v = [5 -5];
quiver(r(1),r(2),v(1),v(2),"off");
text(r(1)+v(1)/2,r(2)+v(2)/2,"$\bf v$",'HorizontalAlignment','left','VerticalAlignment','bottom');

% Drag vector
f_drag = -v;
quiver(r(1),r(2),f_drag(1),f_drag(2),"off");
text(r(1)+f_drag(1)/2,r(2)+f_drag(2)/2,"$F_{drag}$",'HorizontalAlignment','left','VerticalAlignment','bottom');

a_g = [0 -9.8];
quiver(r(1),r(2),a_g(1),a_g(2),"off");
text(r(1)+a_g(1)/2,r(2)+a_g(2)/2,"$g$",'HorizontalAlignment','left','VerticalAlignment','bottom');

axis off
%lims = max(max(abs([vec(:).forces])))*[-1.5 1.5];
lims = [-15 40];
%xlim(lims);
ylim(lims);
axis equal
fontsize(16,'points');
ApplyStyleGuide(f1);

%% Function Definitions
function ApplyStyleGuide(hfig)
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.65; % feel free to play with this ratio
    %set(findall(hfig,'-property','FontSize'),'FontSize',17) % adjust fontsize to your document
    fname = 'myfigure';

    set(findall(hfig,'-property','Box'),'Box','off') % optional
    set(findall(hfig,'-property','Interpreter'),'Interpreter','latex') 
    set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
    set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
    pos = get(hfig,'Position');
    set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
    %print(hfig,fname,'-dpdf','-painters','-fillpage')
    print(hfig,fname,'-dpng','-painters')
end

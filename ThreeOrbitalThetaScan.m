% Script to plot a series of admixtures between the 1s and 2p* orbitals for
% different phase factors.

% thets = [0 0.25 0.5 ; 0.75 1 1.25]; % multiples of pi
% thets = [0 0.3 0.5; 0.6 1 1.3];
% thets = [0 0.1 0.2; 0.3 0.4 0.5];
% thets = [0 0 0 0; 0.5 0.5 0.5 0.5; 1 1 1 1; 3/2 3/2 3/2 3/2];
thets = [1 1 1 1] .* 1.5;

% phis = [0 0.5 1 3/2; 0 0.5 1 3/2; 0 0.5 1 3/2; 0 0.5 1 3/2];
phis = [0 0.5 1 3/2];

% xlims = [-25 25];
% ylims = [-25 25];

xlims = [-8 8];
ylims = [-8 8];

cl = [0 0.01];

% figure
% hold on

threeDcalc = true;

sz = size(thets);

cmp = csvread('colmp4.csv');
p = 1;
for i=1:sz(1)
    for j=1:sz(2)
%         subplot(sz(1),sz(2),p)
        figure(p)
        set(gcf,'Position',[50 100 550 550])
        hold on
        [x,y,out] = MixedHydrogenPDF3state({'1s','2p-','2p+'},thets(i,j).*pi(),phis(i,j).*pi(),threeDcalc);
        if threeDcalc
            surf(x,y,out(:,:,101),'LineStyle','none')
        else
            surf(x,y,out,'LineStyle','none')
        end
        set(gca,'Position',[0 0 1 1])
%         hold on
        xlim(xlims)
        ylim(ylims)
        title(['\theta = ' num2str(thets(i,j)) '\pi, \phi = ' num2str(phis(i,j)) '\pi'])
        view(2)
        
        % Optimization to find the colormap limits
        contlvl = fminbnd(@(x) abs(pdfvolfract(x,out)-0.5),0,max(max(max(out))));
        cl = [0 2*contlvl];
        colormap(gca,cmp)
        p = p + 1;
        caxis(cl)
        
        % Plot a set of crosses for reference
        plot3(0,0,100,'x','MarkerSize',20,'LineWidth',5)
%         plot3(0,1,100,'xc','MarkerSize',20,'LineWidth',5)
        plot3([0 0 2 -2],[2 -2 0 0],[100 100 100 100],'xr','MarkerSize',20,'LineWidth',5)
        
        % Prettify the plot
        set(gca,'XTick',[],'YTick',[])
        set(gcf,'Renderer','ZBuffer') % required to prevent render errors on save
        
    end
    
end

% cmp = csvread('colmp.csv');
% figure
% surf(linspace(lims(1,1),lims(1,2),nsams(1)),linspace(lims(2,1),lims(2,2),nsams(2)),pdf,'LineStyle','none')
% view(2)
% colormap(gca,cmp)
% title([num2str(coeffs{1}) ' ' orbs{1} ' + ' num2str(coeffs{2}) ' ' orbs{2} ])
% xlim([-25 25])
% ylim([-25 25])
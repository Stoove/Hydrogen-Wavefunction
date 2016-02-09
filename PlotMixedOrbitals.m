% Script to plot a set of superpositions of the 1s and 2p+- Hydrogenic
% orbitals

% theta = -3.5*pi()/3;

orbs = {'1s0','2p+','2p-'};
% orbs = {'1s0','2p0'};
% coeffs = {1./sqrt(2),-1./sqrt(2)};
% coeffs = {exp(-1i.*theta)./sqrt(2),exp(1i.*theta)./sqrt(2)};
coeffs = {1./sqrt(2),i/2./sqrt(2),-1/2./sqrt(2)};
% coeffs = {1/sqrt(3),sqrt(2)/sqrt(3)};
% coeffs = {1,0};
% coeffs = {0,1};
% coeffs = {1,0,0};
% coeffs = {0,1,0};
% coeffs = {0,0,1};
% plane = 'xz';
plane = 'xy';
lims = [-8 8; -8 8];
nsams = [1000 1000];
% cl = [0 0.03];

psis = cell(1,2);
psitot = zeros(nsams);

for i=1:length(orbs)
    psis{i} = squeeze(coeffs{i}.*Hwavfn(HydrogenWavfnSettings(plane,orbs{i},lims,nsams)));
    psitot = psitot + psis{i};
end

pdf = psitot .* conj(psitot);

%% Optimization routine to find the 50% shell of the PDF

% optfun = ;

contlvl = fminbnd(@(x) abs(pdfvolfract(x,pdf)-0.5),0,max(max(pdf)));

%% Plot
% cmp = csvread('colmp.csv');
% cmp = csvread('colmp2.csv');
% cmp = csvread('colmp3.csv');
cmp = csvread('colmp4.csv');
figure('Position',[50 100 500 500])
hold on
surf(linspace(lims(1,1),lims(1,2),nsams(1)),linspace(lims(2,1),lims(2,2),nsams(2)),pdf','LineStyle','none')
plot3(0,0,100,'x','MarkerSize',10)
plot3(0,1,100,'xc','MarkerSize',10)
plot3(0,2,100,'xr','MarkerSize',10)
% contourf(linspace(lims(1,1),lims(1,2),nsams(1)),linspace(lims(2,1),lims(2,2),nsams(2)),pdf','LineStyle','none')
view(2)
colormap(gca,cmp)
% title([num2str(coeffs{1}) ' ' orbs{1} ' + ' num2str(coeffs{2}) ' ' orbs{2} ])
% xlim([-25 25])
% ylim([-25 25])
xlim([-8 8])
ylim([-8 8])
% A = median(reshape(pdf,nsams(1).*nsams(2),1));
cl = [0 2*contlvl];
caxis(cl)
set(gca,'XTick',[],'YTick',[],'Position',[0 0 1 1])
% xlim([-2 2])
% ylim([-2 2])
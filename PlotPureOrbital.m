% Script to model hydrogenic wavefunctions from literature, using two
% fan-made functions to calculat spherical harmonics and laguerre
% polynomials
% Wavefunctions are characterzed by the quantum numbers n, l, and m, and
% the polynomials: L[2l+1][n-l-1](r) [generalized Laguerre]
% and Y[l,m](theta,phi) [spherical harmonic]
%
% psi = R(n,l)(r) .* Y(l,m)(theta,phi)
% where R is the radial component and Y is the spherical component
% The objective is to compute |psi|^2 = psi.*conj(psi)
%
% Other parameters: Z, the electron number (normally 1); amu, the atomic
% radius, amu = me/mu * a0; mu, the reduced mass, mu = (mn*me)/(mn+me); me
% and mn, the mass of the electron and nucleus respectively (mu approx me);
% a0, the bohr radius.
%
% R has four components to be multiplied;
% sqrt( (2*Z/n/amu).^3 .* factorial(n-l-1)/(2*n*factorial(n+l)) )
% exp(-Z.*r./n./amu)
% (2*Z.*r/n/amu).^l
% L[2l+1][n-l-1](2*Z.*r/n/amu)
%
% The natural co-ordinates for the system are spherical polars, converted
% from cartesians by;
%
% r = sqrt(x.^2 + y.^2 + z.^2)
% theta = acos(z./sqrt(x.^2 + y.^2 + z.^2))
% phi = atan2(y,x)

Z = 1;
a0 = 1;
me = 1;
mn = 2000;
mu = (me.*mn)./(me + mn);
amu = me./mu.*a0;

n = 2;
l = 1;
m = 0;

% xlims = [-8 8];%.*0.125;
% ylims = [0 0];%.*0.125;
% zlims = [-8 8];%[-4 4].*0.125;
% nx = 1000;
% ny = 1;
% nz = 1000;

xlims = [-8 8];%.*0.125;
ylims = [-8 8];%.*0.125;
zlims = [-8 8];%[-4 4].*0.125;
nx = 200;
ny = 201;
nz = 200;

% xlims = [-8 8];%.*0.125;
% ylims = [-8 8];%.*0.125;
% zlims = [0 0];%[-4 4].*0.125;
% nx = 1000;
% ny = 1000;
% nz = 1;


%% Generate co-ordinates for the x-y plane

grids = zeros(nx,ny,nz);
x = repmat(reshape(linspace(xlims(1),xlims(2),nx),nx,1),[1 ny nz]);
y = repmat(reshape(linspace(ylims(1),ylims(2),ny),1,ny),[nx 1 nz]);
z = repmat(reshape(linspace(zlims(1),zlims(2),nz),1,1,nz),[nx ny 1]);

r = sqrt(x.^2 + y.^2 + z.^2);
theta = acos(z./sqrt(x.^2 + y.^2 + z.^2));
phi = atan2(y,x);

%% Calculate stages of R

r1 = sqrt( (2*Z/n/amu).^3 .* factorial(n-l-1)/(2*n*factorial(n+l)) );
r2 = exp(-Z.*r./n./amu);
r3 = (2*Z.*r/n/amu).^l;
r4 = polyval(LaguerreGen(n-l-1,2*l+1),2*Z.*r/n/amu);

R = r1.*r2.*r3.*r4;

%% Calculate spherical harmonic component

Y = compute_Ylm(l,m,theta,phi);

%% Produce total p.d.f.

psi = R.*Y;

out = psi.*conj(psi);

%% Plot

cmp = csvread('colmp4.csv');

figure
hold on
% surf(x,y,squeeze(out),'LineStyle','none')
surf(linspace(xlims(1),xlims(2),nx),linspace(zlims(1),zlims(2),nz),squeeze(out(:,101,:)).','LineStyle','none')
% surf(x,y,out,'LineStyle','none')
view(2)
% colormap(gca,cmp)

% Optimization to find the colormap limits
contlvl = fminbnd(@(x) abs(pdfvolfract(x,out)-0.5),0,max(max(max(out))));
cl = [0 2*contlvl];
colormap(gca,cmp)
caxis(cl)
% plot3(0,0,100,'x','MarkerSize',10)
% plot3(0,2,100,'xc','MarkerSize',10)
% plot3(0,4,100,'xr','MarkerSize',10)
plot3(0,0,100,'x','MarkerSize',20,'LineWidth',5)
plot3([0 0 2 -2],[2 -2 0 0],[100 100 100 100],'xr','MarkerSize',20,'LineWidth',5)

set(gca,'Position',[0 0 1 1],'XTick',[],'YTick',[])
set(gcf,'Renderer','ZBuffer')

xlim([-8 8])
ylim([-8 8])

%% Plot the real and imag parts of the wavfn

% cmp = csvread('colmp4.csv');

% figure
% hold on
% % surf(x,z,real(squeeze(psi)),'LineStyle','none')
% surf(x,y,real(squeeze(psi)),'LineStyle','none')
% % surf(x,y,out,'LineStyle','none')
% view(2)
% colormap(gca,'jet')
% 
% % Optimization to find the colormap limits
% % contlvl = fminbnd(@(x) abs(pdfvolfract(x,out)-0.5),0,max(max(out)));
% % cl = [0 2*contlvl];
% % colormap(gca,'jet')
% % caxis(cl)
% % plot3(0,0,100,'x','MarkerSize',10)
% % plot3(0,2,100,'xc','MarkerSize',10)
% % plot3(0,4,100,'xr','MarkerSize',10)
% 
% 
% 
% set(gca,'Position',[0 0 1 1],'XTick',[],'YTick',[])
% set(gcf,'Renderer','ZBuffer')
% 
% xlim([-8 8])
% ylim([-8 8])


% cmp = csvread('colmp4.csv');

% figure
% hold on
% % surf(x,z,imag(squeeze(psi)),'LineStyle','none')
% surf(x,y,imag(squeeze(psi)),'LineStyle','none')
% % surf(x,y,out,'LineStyle','none')
% view(2)
% colormap(gca,'jet')
% 
% % Optimization to find the colormap limits
% % contlvl = fminbnd(@(x) abs(pdfvolfract(x,out)-0.5),0,max(max(out)));
% % cl = [0 2*contlvl];
% % colormap(gca,'jet')
% % caxis(cl)
% % plot3(0,0,100,'x','MarkerSize',10)
% % plot3(0,2,100,'xc','MarkerSize',10)
% % plot3(0,4,100,'xr','MarkerSize',10)
% 
% set(gca,'Position',[0 0 1 1],'XTick',[],'YTick',[])
% set(gcf,'Renderer','ZBuffer')
% 
% xlim([-8 8])
% ylim([-8 8])


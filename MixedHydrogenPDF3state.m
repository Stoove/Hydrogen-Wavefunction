% Function to calculate the p.d.f. for a mixed orbital of two Hydrogenic
% wavefunctions (given) with a phase factor between them (theta).
% varargout{1} gives all state wavefunctions. xz plane

function [x,y,pdf,varargout] = MixedHydrogenPDF3state(orbs,theta,phi,varargin)

threeDflag = false;

if nargin > 3
    if varargin{1}
        threeDflag = true;
    end
end

% orbs = {'1s','2p-'};
% coeffs = {exp(-1i.*theta)./sqrt(2),exp(1i.*theta)./sqrt(2)};
coeffs = {1./sqrt(2)./sqrt(2),exp(-0.5i.*theta).*exp(1i.*phi)./2,exp(0.5i.*theta).*exp(1i.*phi)./2};
plane = 'xy';
lims = [-8 8; -8 8];
nsams = [1000 1000];

if threeDflag
    plane = 'xyz';
    lims = [lims;-8 8];
%     nsams = [nsams 1001];
%     nsams = [500 500 501];
%     nsams = [100 100 101];
    nsams = [200 200 201];
end

psis = cell(1,2);
psitot = zeros(nsams);

for i=1:length(orbs)
    if ~threeDflag
        psis{i} = squeeze(coeffs{i}.*Hwavfn(HydrogenWavfnSettings(plane,orbs{i},lims,nsams))).';
    else
        psis{i} = squeeze(coeffs{i}.*Hwavfn(HydrogenWavfnSettings(plane,orbs{i},lims,nsams)));
    end
    psitot = psitot + psis{i};
end

pdf = psitot .* conj(psitot);

x = linspace(lims(1,1),lims(1,2),nsams(1));
y = linspace(lims(2,1),lims(2,2),nsams(2));

if nargout > 3
    varargout{1} = psis;
end
if nargout > 4
    varargout{2:end} = 0;
end
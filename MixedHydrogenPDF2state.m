% Function to calculate the p.d.f. for a mixed orbital of two Hydrogenic
% wavefunctions (given) with a phase factor between them (theta) and equal
% state amplitudes (i.e. a 50-50 superposition).
%
% orbs - cell array with two entries, giving nlm identifiers (strings) for
% the two states you wish to superpose. For more info on nlm identifiers,
% see the Hydrogen-Wavefunction README (Note under HydrogenWavfnSettings.m)
%
% varargin{1} allows you to specify that the calculation should be done in
% 3D (at massively reduced resolution!)
%
% varargin{2} allows you to specify the plane to be calculated, in string
% form (e.g. 'xy','xz', or 'yz')
%
% varargout{1} outputs individual state wavefunctions.

function [x,y,pdf,varargout] = MixedHydrogenPDF2state(orbs,theta,varargin)

threeDflag = false;

%% varargin input handling and size checks, etc
if nargin > 2
    if varargin{1} % check for whether we're doing the 3D case
        threeDflag = true;
    end
    
    if nargin > 3
        plane = varargin{2};
        if strcmp(plane,'xyz') % This simple function not designed to support xyz
            error(['MixedHydrogenPDF2state:: Does not support "xyz" input for '...
                'varargin{2}! Use "xy" ,"xz", or "yz".'])
        end
    else
        plane = 'xy';
    end
    
end

% Check that theta is of size 1
if length(theta) ~= 1
    error('MixedHydrogenPDF2state:: Argument "theta" must be of size 1!')
end

coeffs = {1./sqrt(2),exp(1i.*theta)./sqrt(2)};
lims = [-8 8; -8 8];
nsams = [1000 1000];

if threeDflag % Implement different settings for the 3D case
    lims = [lims;-8 8];
    nsams = [200 200 200];
    
    if strcmp(plane,'xz')
        nsams(2) = nsams(2) + 1;
    elseif strcmp(plane,'xy')
        nsams(3) = nsams(3) + 1;
    end
    
    plane = 'xyz';
    
end

% Checking orbs is correct size and type
if (length(orbs) ~= 2) || ~isa(orbs,'cell')
    error(['MixedHydrogenPDF2state:: argument "orbs" must be cell array of '...
        'size 1x2 or 2x1.'])
end

%% Calculation steps

psis = cell(1,2);
psitot = zeros(nsams);

% Loop through each state, sum outputs of Hwavfn.m.
for i=1:2
    if ~threeDflag % different syntax required in 3D case
        psis{i} = squeeze(coeffs{i}.*Hwavfn(HydrogenWavfnSettings(plane,orbs{i},lims,nsams))).';
    else
        psis{i} = squeeze(coeffs{i}.*Hwavfn(HydrogenWavfnSettings(plane,orbs{i},lims,nsams)));
    end
    psitot = psitot + psis{i};
end

% Main result
pdf = psitot .* conj(psitot);

% Calculate axis outputs
x = linspace(lims(1,1),lims(1,2),nsams(1));
y = linspace(lims(2,1),lims(2,2),nsams(2));

if nargout > 3
    varargout{1} = psis;
end
if nargout > 4 % prevent errors in case extra outputs called for
    varargout{2:end} = 0;
end
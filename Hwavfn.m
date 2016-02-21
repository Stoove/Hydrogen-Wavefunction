% Function to calculate and return the orbital wavefunction for a
% hydrogenic atom given limits in cartesian co-ordinates and n,l,m
% Takes a struct with fields; n, l, m, lims (3x2 matrix), nsams (3x1 vect),
% Z, a0, me, mn. Last four are optional. Defaults to nlm=1 0 0.
%
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

function [psi] = Hwavfn(params)

%% Parse input params struct, assign vars, check validity, correct if bad.

% This involves unpacking the struct into shorter variables for code
% clarity.

sets = struct('Z',1,'a0',1,'me',1,'mn',2000,'n',1,'l',0,'m',0,'lims',[-4 4;-4 4;0 0],'nsams',[1000 1000 1]);

params = teststruc(params,sets);

Z = params.Z;
a0 = params.a0;
me = params.me;
mn = params.mn;
mu = (me.*mn)./(me + mn);
amu = me./mu.*a0;

% Ensure n, l, m, satisfy requirements
n = params.n;
n = CheckIsInteger(n,'n');
if n <= 0
    warning(['Hwavfn.m:: n <= 0! Settings n=0.'  char(10) 'See Hydrogen-Wavefunction README'...
        'for more information on proper notation.'])
end
l = params.l;
n = CheckIsInteger(l,'l');
if l >= n
    warning(['Hwavfn.m::  l >= n! Setting l = n-1' char(10) 'See Hydrogen-Wavefunction README'...
        'for more information on proper notation.'])
    l = n-1;
end
m = params.m;
n = CheckIsInteger(m,'m');
if m > l
    warning(['Hwavfn.m::  m > l! Setting m = l'  char(10) 'See Hydrogen-Wavefunction README'...
        'for more information on proper notation.'])
    m = l;
end

sz = size(params.lims);
if or(sz(1)~=3,sz(2)~=2)
    warning('Hwavfn.m:: lims argument must be 3x2. Using defaults.')
    params.lims = sets.lims;
end
xlim = params.lims(1,:);
ylim = params.lims(2,:);
zlim = params.lims(3,:);

sz = size(params.nsams);
if ~or(sz(1)==3 && sz(2)==1,sz(1)==1 && sz(2)==3)
    warning('Hwavfn.m::  nsams argument must be 3x1. Using defaults.')
    params.nsams = sets.nsams;
end
nx = params.nsams(1);
ny = params.nsams(2);
nz = params.nsams(3);

%% Generate co-ordinates for the x-y plane

x = repmat(reshape(linspace(xlim(1),xlim(2),nx),nx,1),[1 ny nz]);
y = repmat(reshape(linspace(ylim(1),ylim(2),ny),1,ny),[nx 1 nz]);
z = repmat(reshape(linspace(zlim(1),zlim(2),nz),1,1,nz),[nx ny 1]);

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

%% Produce output wavefunction

psi = R.*Y;
% Function to take requests for hydrogenic wavefunctions in different
% planes and return a settings list for Hwavfn.m
% plane - 'xy' or 'xz'
% orbital - orbital state in standard notation, string.
% lims - numeric array 2x2 giving limits of array along each direction in
% the plane
% nsams - numeric array 1x2 giving n.o. samples along each direction in the
% plane

function [params] = HydrogenWavfnSettings(plane,orbital,lims,nsams)

if ~ischar(plane)
    error('HydrogenWavfnSettings::plane::must be of type string.')
end
if ~ischar(orbital)
    error('HydrogenWavfnSettings::orbital::must be of type string.')
end
if length(orbital)>3 || length(orbital)<2
    error('HydrogenWavfnSettings::orbital::must be of length 2 or 3.')
end

sets = struct('Z',1,'a0',1,'me',1,'mn',2000,'n',1,'l',0,'m',0,'lims',[-4 4;-4 4;0 0],'nsams',[1000 1000 1]);

%% Determine the plane settings from the plane input

params = struct();

if strcmp(plane,'xy')
    params.lims = [lims;0 0];
    params.nsams = [nsams 1];
elseif strcmp(plane,'yz')
    params.lims = [0 0;lims(1,:);lims(2,:)];
    params.nsams = [1;nsams(1);nsams(2)];
elseif strcmp(plane,'xz')
    params.lims = [lims(1,:);0 0;lims(2,:)];
    params.nsams = [nsams(1);1;nsams(2)];
elseif strcmp(plane,'xyz')
    params.lims = [lims(1,:);lims(2,:);lims(3,:)];
    params.nsams = [nsams(1);nsams(2);nsams(3)];
else
    error('HydrogenWavfnSettings::plane::function currently recognizes ''xy'', ''yz'' and ''xz''.')
end

%% Determine the orbital settings from the notation

params.n = round(str2double(orbital(1)));

labels = {'s','p','d','f'};
for i=0:length(labels)-1
    if strcmp(orbital(2),labels{i+1})
        params.l = i;
        break
    end
end

flag = true; % Flag to say we have a numeric m
if length(orbital)>=3
    
    if length(orbital) == 3
        labels = {'+','-';+1,-1}; % Special case for simple + or -
        for i=1:2 % try looking for a + or - first
            if strcmp(orbital(3),labels{1,i})
                params.m = labels{2,i};
                flag = false; % No need to run numeric part
                break
            end
        end
    end
    
    % Determine which parts of string are the numeric part
    if length(orbital) > 3
        
        
        
    end
    
    if flag % Treat last char as numeric
        dum = str2double(orbital(end));
        if isnan(dum) % char was not numeric
            warning(['HydrogenWavfnSettings::orbital::final character in ' orbital ' not a number or ''+'' or ''-''.'])
            dum = 0;
        end
        params.m = dum;
    end
    
end
% if no m info, defaults to m=0 anyway.

%% Set output to defaults where there is no info

params = teststruc(params,sets);





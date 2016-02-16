% Function to scan an nlm identifier string and return n, l, and m numeric
% values

function [n,l,m] = nlmStringParse(str)

%% Use regular expressions to check that the string has what we want

len = length(str);

% expression: string of digits, one letter, check for sign: if so then zero
% or more numerics (if not then at least one numeric).
ex = '\d+[a-z]([+-]?)(?(1)[0-9]*|[0-9]+)';
[stPoint,enPoint] = regexp(str,ex);

% Check against requirements for input and warn user if any problems
if isempty(stPoint)
    error(['nlmStringParse:: Could not find a valid nlm string! must be ' ...
        'of the form:' char(10) 'n (integer, no sign)' char(10) 'l (single letter)' ...
        char(10) 'm (sign, or integer, or sign and integer).'])
elseif length(stPoint) > 1
    error(['nlmStringParse:: Too many entries in the nlm string!' char(10) ...
        'Try to make sure there is only one nlm identifier in the string.'])
elseif stPoint > 1
    warning(['nlmStringParse:: Entry appears to have some characters '...
        'at the start which were not required: "' str(1:stPoint-1) '".' ...
        ' Ignoring these inputs.'])
elseif enPoint < len
    warning(['nlmStringParse:: Entry appears to have some characters '...
        'at the end which were not required: "' str(enPoint+1:end) '".' ...
        ' Ignoring these inputs.'])
end

% Reassign str to the matching subset of str
str = str(stPoint:enPoint);

%% Use sanitized/correct string to determine nlm

% recalculate due to general case where str may be reassigned
len = length(str);

% Find the location of the l identifier

validChars = {'s','p','d','f','g','h','i','j','k','l','m','n','o','q', ...
    'r','t','u','v','w','x','y','z'};

identLoc = find(isletter(str),1);

% Evaluate l
l = [];
for j=1:length(validChars)
    if strcmp(str(identLoc),validChars{j})
        l = j-1;
        break
    end
end

if isempty(l)
    error(['nlmStringParse:: Could not assign an l value to string "' str(identLoc) ...
        '". Please check Hydrogen-Wavefunction documentation for correct notation.'])
end

% Evaluate n
n = str2num(str(1:identLoc-1));

% Find out if m is prefixed by a sign
% This method is a little roundabout, but makes most sense in terms of
% putting logical checks in sensible orders

mModifier = 1; % multiplying factor to deal with signs
mStart = identLoc+1; % starting point of numeric part of m
if strcmp(str(identLoc+1),'+')
    mStart = mStart + 1;
elseif strcmp(str(identLoc+1),'-')
    mStart = mStart + 1;
    mModifier = -1;
end

% evaluate m

if mStart > len % special case for +-1 notation
    m = mModifier;
else
    m = mModifier .* str2num(str(mStart:end));
end


% Function to check that the argument is an integer. If not, round and
% issue warning to user. Provide name of argument for warning.

function [arg] = CheckIsInteger(arg,name)

if abs(rem(arg,1)) > 0
    warning(['Argument ' name ' is non-integer!'  char(10) 'See Hydrogen-Wavefunction'...
        'README for more information on proper notation.'])
    arg = round(arg);
end
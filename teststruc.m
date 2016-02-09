% Function to test a structure and check if it has the required fields,
% updating to the given default settings in egstruc

function [strucout] = teststruc(input,egstruc)

% infnams = fieldnames(input);
egfnams = fieldnames(egstruc);

for i=1:length(egfnams)
    for j=1:length(egfnams)
        if ~isfield(input,egfnams{i})
            input.(egfnams{i}) = egstruc.(egfnams{i});
        end
    end
end

strucout = input;

%% Future implementation: check that the class of each field is the same as in egstruct
% tf = isa(input.(egfnams{i}),class(egfnams{i}));
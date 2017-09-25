% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 25, 2017
% Title: Carrier density as a function of Fermi level in bilayer graphene

function [n] = carrier_fermi_bilayer(ef, del)
% ef: Fermi level [J]
% del: energy asymmetry [J]
% n: carrier density [1/m^2]

%% initialization
% initialize necessary constants, variables, and functions
init_constant;      % initialize physical constants and parameters
init_variable;      % initialize variables
delta 	= del; 		% replace energy asymmetry
% conduction band minimum and valance band maximum
minmax  = gamma1*delta/(2*sqrt(gamma1^2 + delta^2)); 

%% calculate carrier density
num = length(ef);
n = 0*ef;
Einf = 1*qe; 		% integral upper bound
for i = 1:num
    Ef = ef(i);
    init_function;	% initialize functions
    n(i) = integral(@(E) dos_bilayer(E, delta).*f(E), minmax, Einf) - ...
    	integral(@(E) dos_bilayer(E, delta).*(1 - f(E)), -Einf, minmax);
end

end
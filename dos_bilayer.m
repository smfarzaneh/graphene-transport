% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Density of states of bilayer graphene 

function [DOS] = dos_bilayer(E, del)
% DOS: density of states [1/Jm^2]
% E: energy level [J]
% del: energy asymmetry [J]

%% initialization
% initialize necessary constants, variables, and functions
init_constant;        	% initialize physical constants and parameters
init_variable;        	% initialize variables
delta 	= del;			% replace energy asymmetry
init_function;        	% initialize functions

%% calculation
minmax  = gamma1*delta/(2*sqrt(gamma1^2 + delta^2));
num     = length(E); 
DOS     = zeros(num, 1);
[k1, k2, alpha1, alpha2] = momentum_energy_bilayer(E, del);
for i = 1:num
    if (abs(E(i)) >= minmax)
        if(k1(i) > 0)
            DOS(i) = DOS(i) + g*k1(i)/(2*pi)/abs(de(k1(i), 1, alpha1(i)));
        end 
        if(k2(i) > 0)
            DOS(i) = DOS(i) + g*k2(i)/(2*pi)/abs(de(k2(i), 1, alpha2(i)));
        end
    end
end        
end
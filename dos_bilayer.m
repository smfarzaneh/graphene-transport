% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Density of states of bilayer graphene 

function [DOS] = dos_bilayer(E)
% DOS: density of states [1/Jm^2]
% E: energy level [J]

%% initialization
% initialize necessary constants, variables, and functions
init_constant;           % initialize physical constants and parameters
init_variable;           % initialize variables
init_function;           % initialize functions

%% calculation
minmax  = gamma1*delta/(2*sqrt(gamma1^2 + delta^2));
num     = length(E); 
DOS     = zeros(num, 1);
for i = 1:num
    if (E(i) >= minmax)
        [k1, k2] = momentum_energy_bilayer(E(i));
        if(k1 > 0)
            DOS(i) = DOS(i) + k1/pi/de(k1, 1, 1);
        end 
        if(k2 > 0)
            DOS(i) = DOS(i) + k2/pi/de(k2, 1, 1);
        end
    end
end        
end
% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Momentum versus energy of bilayer graphene
% Note: This function only returns positive solutions (k >= 0).
% The negative values (k = -1) indicate that there is no solution.

function [k1, k2] = momentum_energy_bilayer(E)
% k1, k2: wavevectors [1/m]
% E: energy level [J]

%% initialization
% initialize necessary constants, variables, and functions
init_constant;      % initialize physical constants and parameters
init_variable;      % initialize variables

%% calculation
func    = @(E, pm) 1/(hbar^2*vf^2)*(E.^2 + delta^2/4 + ...
    pm*sqrt(E.^2*(delta^2 + gamma1^2) - gamma1^2*delta^2/4));
minmax  = gamma1*delta/(2*sqrt(gamma1^2 + delta^2));
num     = length(E); 
k1      = -ones(num, 1);
k2      = -ones(num, 1);
% check if there is any answer
for i = 1:num
    if (E(i) >= minmax || E(i) <= -minmax)
        temp = func(E(i), 1);
        if (temp >= 0); k1(i) = sqrt(temp); end
        temp = func(E(i), -1);
        if (temp >= 0); k2(i) = sqrt(temp); end
    end
end
end
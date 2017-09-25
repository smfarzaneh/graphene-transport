% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Momentum versus energy of bilayer graphene
% Note: This function only returns positive solutions (k >= 0).
% The negative values (k = -1) indicate that there is no solution.

function [k1, k2, alpha1, alpha2] = momentum_energy_bilayer(E, del)
% k1, k2: wavevectors [1/m]
% alpha1, alpha2: subband indices corresponding to k1 and k2
% E: energy level [J]
% del: energy asymmetry [J]

%% initialization
% initialize necessary constants, variables, and functions
init_constant;      % initialize physical constants and parameters
init_variable;      % initialize variables
delta 	= del; 		% replace energy asymmetry

%% calculation
func    = @(E, pm) 1/(hbar^2*vf^2)*(E.^2 + delta^2/4 + ...
    pm*sqrt(E.^2*(delta^2 + gamma1^2) - gamma1^2*delta^2/4));
sub1min = gamma1*delta/(2*sqrt(gamma1^2 + delta^2));
sub2min = sqrt(gamma1^2 + delta^2/4);
num     = length(E); 
k1      = 0*E - 1;
alpha1 	= 0*E;
k2      = 0*E - 1;
alpha2 	= 0*E;

% check if there is any answer
for i = 1:num
    if (abs(E(i)) >= sub1min)
    	if (abs(E(i)) < sub2min)
    		temp = func(E(i), -1);
	        if (temp >= 0) 
	        	k1(i) = sqrt(temp); 
	        	alpha1(i) = 1;
	        end
	        temp = func(E(i), 1);
	        if (temp >= 0) 
	        	k2(i) = sqrt(temp); 
	        	alpha2(i) = 1;
	        end
    	else
	        temp = func(E(i), -1);
	        if (temp >= 0) 
	        	k1(i) = sqrt(temp); 
	        	alpha1(i) = 2;
	        end
	        temp = func(E(i), 1);
	        if (temp >= 0) 
	        	k2(i) = sqrt(temp); 
	        	alpha2(i) = 1;
	        end
        end
    end
end
end
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
alpha1 	= 0*E + 1;
alpha2 	= 0*E + 1;

alpha1 	= alpha1.*heaviside(abs(E) - sub1min).*(1 - heaviside(abs(E) - delta/2)) + ...
	2*heaviside(abs(E) - sub2min);
alpha2 	= alpha2.*heaviside(abs(E) - sub1min);
k1 		= sqrt(abs(func(E, -1))).*heaviside(abs(E) - sub1min) + ... 
	(1 - heaviside(abs(E) - sub1min));
k2 		= sqrt(abs(func(E, 1))).*heaviside(abs(E) - sub1min) + ...
	(1 - heaviside(abs(E) - sub1min));
% the last terms in k1 and k2 expressions are to avoid division by zero errors.
% this extra term would not change the density of states at all because the alpha1 
% and alpha2 vectors will mask k1 and k2 accordingly.

end
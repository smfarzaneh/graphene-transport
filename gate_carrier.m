% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Calculate carrier density for a given voltage

function [n] = gate_carrier(v, tox, eox)
	% n: carrier density [1/m^2]
	% v: top gate voltage [V]
	% tox: oxide thickness [m]
	% eox: oxide relative permittivity [unitless]

	init_constant;         	% initialize physical constants and parameters

	n = eps0*eox/(tox*qe)*v;

end
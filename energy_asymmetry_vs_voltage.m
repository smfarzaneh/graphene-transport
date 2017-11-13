% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Calculate energy asymmetry of bilayer graphene for 
% a given voltage and carrier imbalance

function [del] = energy_asymmetry_vs_voltage(v, dn, tox, eox, nimp)
	% del: energy asymmetry [J]
	% v: top gate voltage [V]
	% dn: carrier imbalance [1/m^2]
	% tox: oxide thickness [m]
	% eox: oxide relative permittivity [unitless]
	% nimp: impurity density (positive for positive charged impurities) [1/m^2]

	init_constant;         	% initialize physical constants and parameters
	d = b; 					% distance between layers [m]
	ng = gate_carrier(v, tox, eox);
	del0 = qe^2*(ng - nimp)*d/(eps0*eox);
	del_correction = qe^2*dn*d/(2*eps0*eox);	

	del = del0 - del_correction;

end
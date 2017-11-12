% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Calculate energy asymmetry of bilayer graphene for 
% a given voltage and carrier imbalance

function [del] = energy_asymmetry_vs_voltage(v, dn, tox, eox)
	% del: energy asymmetry [J]
	% v: top gate voltage [V]
	% dn: carrier imbalance [1/m^2]
	% tox: oxide thickness [m]
	% eox: oxide relative permittivity [unitless]

	init_constant;         	% initialize physical constants and parameters
	d = b; 					% distance between layers [m]
	external_term = v*qe*d/(tox);
	internal_term = dn*qe^2*d/(2*eps0*eox);	

	del = external_term - internal_term;

end
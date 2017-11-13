% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Calculate energy asymmetry and the Fermi level of BLG 
% for given gate voltage and temperature 
% using self consistent Hartree approximation. 

function [ef, del, n] = self_consistent(v, tox, eox, T, nimp)
	% ef: Fermi level [J]
	% del: energy asymmetry [J]
	% v: top gate voltage [V]
	% tox: oxide thickness [m]
	% eox: oxide relative permittivity [unitless]
	% T: temperature [K]

	init_constant;         	% initialize physical constants and parameters
	ng = gate_carrier(v, tox, eox);
	ntot = ng + nimp;
 	
	% initial guess 
	dn = 0;

	% self consisten calculation
	iteration = 10;
	for i = 1:iteration
 		del = energy_asymmetry_vs_voltage(v, dn, tox, eox, nimp);
 		ef = fermi_bisection(ntot, del, T);
 		[dn, n1, n2] = carrier_imbalance(ef, del, T);
 	end

end
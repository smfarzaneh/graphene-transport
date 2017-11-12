% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: October 30, 2017
% Titl	e: calculate carrier imbalance between the two layers of BLG 
% using wavefunction amplitudes 

function [dn, n_1, n_2] = carrier_imbalance(fermi_level, energy_asymmetry, temperature)

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables
	Ef 		= fermi_level;
	delta 	= energy_asymmetry;
	T 		= temperature; 
	init_function;			% initialize functions
	
	% wavefunction amplitudes of the two layers
	amplitude_1 = @(k, s, alpha) ...
		abs(psi1(k, s, alpha)).^2 + ...
		abs(psi4(k, s, alpha)).^2;
	amplitude_2 = @(k, s, alpha) ...
		abs(psi2(k, s, alpha)).^2 + ...
		abs(psi3(k, s, alpha)).^2;

	% prepare the integrands
	integrand_electrons_1 = @(k) k.*( ...
		f(ek(k, 1, 1)).*amplitude_1(k, 1, 1) + ...
		f(ek(k, 1, 2)).*amplitude_1(k, 1, 2));

	integrand_electrons_2 = @(k) k.*( ...
		f(ek(k, 1, 1)).*amplitude_2(k, 1, 1) + ...
		f(ek(k, 1, 2)).*amplitude_2(k, 1, 2));	

	integrand_holes_1 = @(k) k.*( ...
		(1 - f(ek(k, -1, 2))).*amplitude_1(k, -1, 2) + ...
		(1 - f(ek(k, -1, 1))).*amplitude_1(k, -1, 1));

	integrand_holes_2 = @(k) k.*( ...
		(1 - f(ek(k, -1, 2))).*amplitude_2(k, -1, 2) + ...
		(1 - f(ek(k, -1, 1))).*amplitude_2(k, -1, 1));

	% evaluate integrals
	kcutoff = 10*pi/b; 		% cut-off momentum (integral upper bound)
	
	n_1 	= g/(2*pi)* ...
		integral(@(k) integrand_electrons_1(k) - integrand_holes_1(k), 0, kcutoff);
	
	n_2 	= g/(2*pi)* ...
		integral(@(k) integrand_electrons_2(k) - integrand_holes_2(k), 0, kcutoff);

	dn = n_1 - n_2;

end
% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 30, 2017
% Title: Quantum capacitance of bilayer graphene

function [cq] = quantum_capacitance(surface_potential, energy_asymmetry, temperature)
	% cq: quantum capacitance [F/m^2]
	% surface_potential: [V]
	% energy asymmetry [J]
	% temperature: [K]

	% initialization
	init_constant;
	init_variable;
	Ef = 0;
	delta = energy_asymmetry;
	T = temperature;
	init_function;
	psi_s = surface_potential;
	cq = 0;
	kcutoff = 10*pi/b;

	% loop over all subbands
	band_index = [-2, -1, 1, 2];
	for j = 1:length(band_index)
		s = sign(band_index(j));
		alpha = abs(band_index(j));
		cq = cq + g*qe^2/(2*pi)*integral(@(k) -k.*df(ek(k, s, alpha) - qe*psi_s), 0, kcutoff);

end 
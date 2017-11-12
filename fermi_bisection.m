% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Calculate Fermi level for a given carrier density
% using bisection method.

function [ef] = fermi_bisection(n, del, T)
	% ef: Fermi level [J]
	% n: carrier density [1/m^2]
	% del: energy asymmetry [J]
	% T: temperature [K]

	init_constant;         	% initialize physical constants and parameters
 	
 	% set parameters 
	ef_vect = [-1, 1];

	% calculate n1, n2 corresponding to ef(1) and ef(2)
	[dn, n_layar_1, n_layer_2] = carrier_imbalance(ef_vect(1)*qe, del, T);
	n1 = n_layar_1 + n_layer_2;
	[dn, n_layar_1, n_layer_2] = carrier_imbalance(ef_vect(2)*qe, del, T);
	n2 = n_layar_1 + n_layer_2;

	while (abs(ef_vect(2) - ef_vect(1)) > 1e-4)
		% calculate n_mid
		ef_mid = (ef_vect(1) + ef_vect(2))/2;
		[dn, n_layar_1, n_layer_2] = carrier_imbalance(ef_mid*qe, del, T);
		n_mid = n_layar_1 + n_layer_2;

		% bisect 
		if (sign(n_mid - n) == sign(n1 - n))
			ef_vect(1) = ef_mid;
			n1 = n_mid;
		else
			ef_vect(2) = ef_mid;
			n2 = n_mid;
		end
	end

	ef = ef_mid*qe;

end
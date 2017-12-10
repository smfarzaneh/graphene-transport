% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 30, 2017
% Title: Electrostatics of dual gated bilayer graphene

function [psi_s, CQ, nt, nb] = electrostatics(V, epsr1, epsr2, t1, t2, energy_asymmetry, temperature)

	init_constant;
	init_variable;
	delta = energy_asymmetry;
	T = temperature;

	C1 = eps0*epsr1/t1;
	C2 = eps0*epsr2/t2;

	% solve for surface potential self-consistently
	% initial guess
	CQ = C1;
	max_iteration = 20;
	for i = 1:max_iteration
		psi_s = V*C1/(C1 + C2 + CQ);
		CQ_new = quantum_capacitance(psi_s, delta, T);
		if(abs(CQ_new - CQ)/CQ < 1e-4)
			break
		end
		CQ = CQ_new;
	end

	nt = -V*C1*(C2 + CQ)/(C1 + C2 + CQ)/qe;
	nb = V*C1*C2/(C1 + C2 + CQ)/qe;

end
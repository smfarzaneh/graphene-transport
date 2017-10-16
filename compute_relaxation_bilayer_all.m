% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 20, 2017
% Title: Compute relaxation time in bilayer graphene 
% for a range of Fermi levels and a fixed energy asymmetry
% Note: The computed data will be used for derivation of conductivity vs. carrier density
% Note: Polarizability data must be computed beforehand 

function [] = compute_relaxation_bilayer_all()

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters

	% Set parameters
	del = [0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]*qe; % energy asymmetry [J]
	Ef = (0:0.001:0.099)*qe; % Fermi level [J]
	num_del = length(del);
	num_ef = length(Ef); 	

	% Compute and save to file for each value of Fermi level and energy asymmetry
	for j = 1:num_del
		
		tic;
		for i = 1:num_ef
			
			compute_relaxation_bilayer(-1, 2, Ef(i), del(j));
			compute_relaxation_bilayer(-1, 1, Ef(i), del(j));
			compute_relaxation_bilayer(1, 1, Ef(i), del(j));
			compute_relaxation_bilayer(1, 2, Ef(i), del(j));
		
		end
		t = toc;

		% Display end of computation  
		minutes = floor(t/60);
		seconds = floor(t) - minutes*60;
		disp(['Delta = ', num2str(del(j)/qe), ' Completed in ', num2str(minutes), ' minutes and ', num2str(seconds), ' seconds'])

	end

end
% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 20, 2017
% Title: Compute relaxation time in bilayer graphene 
% and save it to data/relaxation/
% Note: this function uses parallel for loop (parfor) 
% Note: the input arguments must be scalar

function [] = compute_relaxation_bilayer(s, alpha, ef, del)
% s: band index, s = +1, -1 for conduction and valence bands
% alpha: subband index, alpha = 1, 2 for first and second subbands
% ef: Fermi level [J]
% del: energy asymmetry [J]

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables
	Ef 		= ef; 			% replace Fermi level
	delta 	= del;			% replace energy asymmetry 
	init_function;			% initialize functions

	% Set numerical parameters 
	num_k 	= 200;
	kmin 	= pi/b/1e5; 
	kmax 	= pi/b/2;
	k 		= logspace(log10(kmin), log10(kmax), num_k)';
	Taui 	= zeros(num_k, 1); % impurity relaxation time
	Taud 	= zeros(num_k, 1); % defect relaxation time
	
	% Compute relaxation times
	for i = 1:num_k
		[Taui(i), Taud(i)] = relaxation_bilayer(k(i), s, alpha, Ef, delta);
	end
	
	% Save data to file
	directory = 'data/relaxation/';
	filename = strcat('relax', '_Ef', num2str(Ef/qe), '_del', num2str(delta/qe), '_T', num2str(T), '_band', num2str(s*alpha), '.csv');
	destination = strcat(directory, filename);
	M = [k, Taui, Taud];
	csvwrite(destination, M);
	disp([filename, ' was saved.'])

end



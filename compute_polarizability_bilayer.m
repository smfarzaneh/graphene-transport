% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 19, 2017
% Title: Compute polarizability of bilayer graphene 
% and save it to data/polarizability/
% Note: this function uses parallel for loop (parfor) 

function [] = compute_polarizability_bilayer()

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables
	init_function;			% initialize functions

	% Set numerical parameters 
	num 	= 50;
	qmin 	= pi/b/1e5; 
	qmax 	= pi/b/2;
	kcutoff = 10*pi/b; 		% cut-off momentum (integral upper bound)
	q 		= logspace(log10(qmin), log10(qmax), num)';
	Pi 		= zeros(num, 1); % polarizability vector

	% Compute
	tic;
	parfor i = 1:num
		Pi(i) = integral2(@(k, theta) k.*plrz(k.*exp(1j*theta), ...
                k.*exp(1j*theta) + q(i)), 0, kcutoff, 0, 2*pi);
	end
	t = toc;
	
	% Display end of computation  
	minutes = floor(t/60);
	seconds = floor(t) - minutes*60;
	disp(['Completed in ', num2str(minutes), ' minutes and ', num2str(seconds), ' seconds'])
	
	% Save data to file
	filename = strcat('polrz', '_Ef', num2str(Ef/qe), '_del', num2str(delta/qe), '_T', num2str(T), '.csv');
	M = [q, Pi];
	csvwrite(filename, M);
	disp([filename, ' was saved.'])

end



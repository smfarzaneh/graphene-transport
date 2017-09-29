% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 29, 2017
% Title: Compute carrier density over a wide range of Fermi levels
% for several values of energy asymmetry and save the data in data/carrier_fermi/

function [] = compute_carrier_fermi()

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters

	% Set parameters
	del = [0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]*qe; % energy asymmetry [J]
	num_del = length(del); 	

	% Compute and save to file for each value of Fermi level 
	tic;
	for i = 1:num_del
		compute_carrier_fermi(del(i));		
	end
	t = toc;

	% Display end of computation  
	minutes = floor(t/60);
	seconds = floor(t) - minutes*60;
	disp(['Ccompleted in ', num2str(minutes), ' minutes and ', num2str(seconds), ' seconds'])

end
% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 12, 2017
% Title: Compute energy asymmetry and the Fermi level and save to file. 

function [] = compute_self_consistent(temperature) 

	% set parameters
	T = temperature;
	tox = 3e-7;
	eox = 3.9;
	num = 50;
	v = linspace(0.001, 300, num)';
	ef = zeros(num, 1);
	del = zeros(num, 1);
	n = zeros(num, 1);

	% calculate 
	for i = 1:num
		clc 
		str = strcat('completed: ', num2str(floor(i/num*100)), '%');
		disp(str)	
		[ef(i), del(i), n(i)] = self_consistent(v(i), tox, eox, T);
	end
	clc
	disp('self consistent calculation done.')

	% Save data to file
	directory = 'data/delta_fermi/';
	filename = strcat('delta_fermi', '_T', num2str(T), '.csv');
	destination = strcat(directory, filename);
	M = [v, ef, del, n];
	csvwrite(destination, M);
	disp([filename, ' was saved.'])

end
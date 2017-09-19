% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 19, 2017
% Title: Calculate k-dependent momentum relaxation time 
% of electrons in bilayer graphene
% Note: All the inputs must be scalar

function [Taui, Taud] = relaxation_bilayer(k, s, alpha, ef, del)
% Taui: impurity relaxation time [s]
% Taud: defect relaxation time [s]
% k: wavevector [1/m]
% s: band index, s = +1, -1 for conduction and valence bands
% alpha: subband index, alpha = 1, 2 for first and second subbands
% ef: Fermi level [J]
% del: energy asymmetry [J]
	
	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables
	Ef 		= ef;			% replace Fermi level
	delta 	= del;			% replace energy asymmetry
	init_function;			% initialize functions

	% Load polarizability data from file
	filename = strcat('data/polarizability/polrz', ...
		'_Ef', num2str(Ef/qe), ...
		'_del', num2str(delta/qe), ...
		'_T', num2str(T), ...
		'.csv');
	M = csvread(filename);
	Q = M(:, 1); 			% first column: momentum [1/m]
	P = M(:, 2); 			% second column: polarizability [1/Jm^2]

	% interpolate polarizability 
	Pi      = @(q) pchip(Q, P, q);

	% prepare relaxation time integrands
	% impurity scattering
	relxi   = @(k, theta, s, alpha) ...
    	abs(V(2*k*abs(sin(theta/2)), Pi(2*k*abs(sin(theta/2))))).^2.* ...
    	overlap(k, k*exp(1j*theta), s, s, alpha, alpha).*(1 - cos(theta));
	% defect scattering
	relxd   = @(k, theta, s, alpha) ...
    	overlap(k, k*exp(1j*theta), s, s, alpha, alpha).*(1 - cos(theta));

    % compute relaxation time
	% impurity scattering rate
	Gammai   = @(k, s, alpha) ni/(2*pi*hbar)*k./abs(de(k, s, alpha)).* ...
	    integral(@(theta) relxi(k, theta, s, alpha), 0, 2*pi);
	% defect scattering rate
	Gammad   = @(k, s, alpha) ndvd/(2*pi*hbar)*k./abs(de(k, s, alpha)).* ...
	    integral(@(theta) relxd(k, theta, s, alpha), 0, 2*pi);
	% convert to relaxation time 
	Taui    = 1./Gammai(k, s, alpha);
	Taud    = 1./Gammad(k, s, alpha);

end




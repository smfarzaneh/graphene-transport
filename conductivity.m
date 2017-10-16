% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 29, 2017
% Title: Calculate conductivuty of bilayer graphene vs. carrier density

function [n, sigma] = conductivity(ni_scale, ndvd_scale, del)
	% ni_scale: relative charged impurity density 
	% ndvd_scale: relative defect density times its potential squared
	% del: energy asymmetry [J]

	%% initialization
	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable; 			% initialize variables 

	% set parameters
	delta = del;				% energy asymmetry [J]
	ef = (0:0.001:0.099)*qe; 	% Fermi levels [J]
	num_ef = length(ef); 		
	sigma = 0*ef;	 			% conductivity [S]

	% loop over all values of Fermi level
	for i = 1:num_ef
		
		% initialize functions
		Ef = ef(i);
		init_function;			% initialize functions
		
		% loop over all subbands
		band_index = [-2, -1, 1, 2];
		for j = 1:length(band_index)
			
			% load relaxation time data
			filename = strcat('data/relaxation/relax', ...
				'_Ef', num2str(Ef/qe), ...
				'_del', num2str(delta/qe), ...
				'_T', num2str(T), ...
				'_band', num2str(band_index(j)), ...
				'.csv');
			M = csvread(filename);
			k_vect = M(:, 1);
			relax_imp = M(:, 2); 	% impurity relaxation time 	
			relax_def = M(:, 3);	% defect relaxation time

			% rescale relaxation time data
			relax_imp = relax_imp/ni_scale;
			relax_def = relax_def/ndvd_scale;

			% calculate total relaxation time
			scatt_imp = 1./relax_imp;
			scatt_def = 1./relax_def;
			scatt_tot = scatt_imp + scatt_def;
			relax_tot = 1./scatt_tot;

			% interpolate relaxation time data
			tau_tot = @(x) pchip(k_vect, relax_tot, x);

			% calculate conductivity
			s = sign(band_index(j));
			alpha = abs(band_index(j));
			kcutoff = 10*pi/b; 		% cut-off momentum (integral upper bound)
			sigma_subband = g*qe^2/(4*pi)* ...
				integral(@(k) k.*vg(k, s, alpha).^2.* ...
					tau_tot(k).*(-df(ek(k, s, alpha))), 0, kcutoff);
			sigma(i) = sigma(i) + sigma_subband;

		end

	end

	% load carrier density vs. Fermi data
	filename = strcat('data/carrier_fermi/carrier', ...
			'_del', num2str(delta/qe), ...
			'_T', num2str(T), ...
			'.csv');
	M = csvread(filename);
	fermi = M(:, 1)/qe; 	% corresponding Fermi levels [eV]
	carrier = M(:, 2)/1e12; % carrier density [1e12 1/m^2]
	
	% interpolate the data points 
	carrier_ip = @(x) pchip(fermi, carrier, x);

	% calculate corrsponding carrier density
	n = carrier_ip(ef/qe);
	n = n*1e12; 			% rescale

end
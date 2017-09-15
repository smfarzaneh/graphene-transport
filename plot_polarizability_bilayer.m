% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Plot polarizability of bilayer graphene versus momentum

function [] = plot_polarizability_bilayer()

	% initialize necessary constants, variables, and functions
	init_constant;           % initialize physical constants and parameters
	init_variable;           % initialize variables

	% Prepare the figure
	figure('Units', 'inches', ...
		'PaperSize', [7, 2.6], ...
		'PaperPosition', [0, 0, 7, 2.6])
	ax1 = subplot(1, 2, 1);
	ax2 = subplot(1, 2, 2);
	hold(ax1, 'on')
	hold(ax2, 'on')
	grid(ax1, 'on')
	grid(ax2, 'on')
	axis([ax1 ax2],[0 0.3 0 10])

	% Plot for gapless bilayer graphene (delta = 0 and multiple Ef's)
	% We use set delta to 0.01 avoid integral divergence.
	delta = 0.01*qe; 		% energy asymmetry [J]
 	Ef = 0:0.1:0.5; 		% Fermi level [eV]
	for i = 1:length(Ef)
		% Load data from file
		filename = strcat('data/polarizability/polrz', ...
			'_Ef', num2str(Ef(i)), ...
			'_del', num2str(delta/qe), ...
			'_T', num2str(T), ...
			'.csv');
		M = csvread(filename);
		q = M(:, 1); 		% first column: momentum (q) [1/m]
		polrz = M(:, 2); 	% second column: polarizability [1/Jm^2]

		% Normalize vectors 
		q = q/(pi/b); 		% with respect to cut-off momentum, pi/b.
		polrz = polrz/N0;	% with respect to density of states at zero energy. 
		
		% Define finer grid for plotting.
		q_fine = linspace(0, 0.3, 100);
		polrz_fine = spline(q, polrz, q_fine); % interpolation

		% Plot
		plot(ax1, q_fine, polrz_fine, 'k', 'LineWidth', 1)
	end

	set(ax1, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 12, ...
	'FontName', 'Times New Roman')
	title(ax1, '$\Delta$ = 0 eV', 'Interpreter', 'latex')
	xlabel(ax1, 'Wavevector $q \times b/ \pi$', 'Interpreter', 'latex')
	ylabel(ax1, 'Polarizability $\Pi /N_0$', 'Interpreter', 'latex')

	% Plot for gapped bilayer graphene (delta = 0.8 and multiple Ef's)
	delta = 0.8*qe; 		% energy asymmetry [J]
 	Ef = 0.1:0.1:0.5; 		% Fermi level [eV]
	for i = 1:length(Ef)
		% Load data from file
		filename = strcat('data/polarizability/polrz', ...
			'_Ef', num2str(Ef(i)), ...
			'_del', num2str(delta/qe), ...
			'_T', num2str(T), ...
			'.csv');
		M = csvread(filename);
		q = M(:, 1); 		% first column: momentum (q) [1/m]
		polrz = M(:, 2); 	% second column: polarizability [1/Jm^2]

		% Normalize vectors 
		q = q/(pi/b); 		% with respect to cut-off momentum, pi/b.
		polrz = polrz/N0;	% with respect to density of states at zero energy. 
		
		% Define finer grid for plotting.
		q_fine = linspace(0, 0.3, 100);
		polrz_fine = spline(q, polrz, q_fine); % interpolation

		% Plot
		plot(ax2, q_fine, polrz_fine, 'k', 'LineWidth', 1)
	end

	set(ax2, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 12, ...
	'FontName', 'Times New Roman')
	title(ax2, '$\Delta$ = 0.8 eV', 'Interpreter', 'latex')
	xlabel(ax2, 'Wavevector $q \times b/ \pi$', 'Interpreter', 'latex')
	ylabel(ax2, 'Polarizability $\Pi /N_0$', 'Interpreter', 'latex')

	% Save the plot
	print -dpdf polrz_vs_momentum.pdf
	display('Polarizability plot was saved.')

end


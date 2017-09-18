% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Plot polarizability of bilayer graphene versus momentum

function [] = plot_polarizability_bilayer()

	%% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables
	init_function;			% initialize functions

	%% Plot for gapless bilayer graphene (delta = 0 and multiple Ef's)
	% We use set delta to 0.01 avoid integral divergence.

	% Prepare the figure
	figure('Units', 'inches', ...
		'PaperSize', [2.33, 2.33], ...
		'PaperPosition', [0, 0, 2.33, 2.33], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	grid(ax, 'on')
	axis(ax,[0 0.3 0 10])
	
	% Set parameters and plot
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
		
		% Define finer grid for plotting
		q_fine = linspace(0, 0.3, 100);
		polrz_fine = spline(q, polrz, q_fine); % interpolation

		% Plot
		plot(ax, q_fine, polrz_fine, 'LineWidth', 1)
	end

	% Set axes properties
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	title(ax, '$\Delta$ = 0 eV, $T$ = 300 K', 'FontSize', 9, 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $q \times b/ \pi$', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Polarizability $\Pi(q) /N_0$', 'FontSize', 9, 'Interpreter', 'latex')

	% Annotations
	annotation('arrow', [0.6, 0.6], [0.4, 0.8], 'HeadWidth', 6, 'HeadLength', 6)
	str1 = '$$E_f$$ = 0 eV';
	str2 = '$$E_f$$ = 0.5 eV';
	text(0.13, 2.5, str1, 'FontSize', 9, 'Interpreter', 'latex')
	text(0.13, 9, str2, 'FontSize', 9, 'Interpreter', 'latex')

	% Save the plot
	print -dpdf 'polrz_vs_momentum_delta0.pdf'
	message = strcat('polrz_vs_momentum_delta0.pdf', ' was saved.');
	disp(message)

	%% Plot for gapped bilayer graphene (delta = 0.8 and multiple Ef's)
	
	% Prepare the figure	
	figure('Units', 'inches', ...
		'PaperSize', [2.33, 2.33], ...
		'PaperPosition', [0, 0, 2.33, 2.33], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	grid(ax, 'on')
	axis(ax,[0 0.3 0 10])	

	% Set parameters and plot
	delta = 0.8*qe; 		% energy asymmetry [J]
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
		
		% Define finer grid for plotting
		q_fine = linspace(0, 0.3, 100);
		polrz_fine = spline(q, polrz, q_fine); % interpolation

		% Plot
		plot(ax, q_fine, polrz_fine, 'LineWidth', 1)
	end

	% Set axes properties
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	title(ax, '$\Delta$ = 0.8 eV, $T$ = 300 K', 'FontSize', 9, 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $q \times b/ \pi$', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Polarizability $\Pi(q) /N_0$', 'FontSize', 9, 'Interpreter', 'latex')

	% Annotations
	annotation('arrow', [0.6, 0.6], [0.4, 0.8], 'HeadWidth', 6, 'HeadLength', 6)
	str1 = '$$E_f$$ = 0 eV';
	str2 = '$$E_f$$ = 0.5 eV';
	text(0.13, 2.5, str1, 'FontSize', 9, 'Interpreter', 'latex')
	text(0.13, 9, str2, 'FontSize', 9, 'Interpreter', 'latex')

	% Save the plot
	print -dpdf 'polrz_vs_momentum_delta08.pdf'
	message = strcat('polrz_vs_momentum_delta08.pdf', ' was saved.');
	disp(message)

	%% Plot literature's analytic results vs. our numerical results
	
	% Prepare the figure	
	figure('Units', 'inches', ...
		'PaperSize', [2.33, 2.33], ...
		'PaperPosition', [0, 0, 2.33, 2.33], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	grid(ax, 'on')
	axis(ax,[0 0.3 0 10])

	% Set parameters and plot
	delta = 0.01*qe; 		% energy asymmetry [J]
 	Ef = 0.1*qe; 			% Fermi level [eV]
	
	% Load data from file
	% numerical polarizability
	filename = strcat('data/polarizability/polrz', ...
		'_Ef', num2str(Ef/qe), ...
		'_del', num2str(delta/qe), ...
		'_T', num2str(T), ...
		'.csv');
	M = csvread(filename);
	q = M(:, 1); 		% first column: momentum (q) [1/m]
	polrz = M(:, 2); 	% second column: polarizability [1/Jm^2]

	% Normalize vectors 
	q = q/(pi/b); 		% with respect to cut-off momentum, pi/b.
	polrz = polrz/N0;	% with respect to density of states at zero energy. 
	
	% Define finer grid for plotting
	q_fine = linspace(0, 0.3, 100);
	polrz_fine = spline(q, polrz, q_fine); % interpolation

	% Plot
	plot(ax, q_fine, polrz_fine, 'LineWidth', 1)

	% analytic polarizability
	% Find Fermi momentum (kF)
	kF = an_plrz_kf(Ef);
	polrz_an = an_plrz(q_fine*pi/b, kF);

	% Normalize vectors 
	polrz_an = polrz_an/N0;	% with respect to density of states at zero energy. 	

	% Plot
	plot(ax, q_fine, polrz_an, 'LineWidth', 1)

	% Set axes properties
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	title(ax, '$\Delta$ = 0 eV, $k_BT \ll E_f$', 'FontSize', 9, 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $q \times b/ \pi$', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Polarizability $\Pi(q) /N_0$', 'FontSize', 9, 'Interpreter', 'latex')

	% Annotations
	str1 = 'Numerical';
	str2 = 'Analytical';
	text(0.15, 5.6, str1, 'FontSize', 9, 'Rotation', 45, 'Interpreter', 'latex')
	text(0.15, 1.9, str2, 'FontSize', 9, 'Interpreter', 'latex')

	% Save the plot
	print -dpdf 'polrz_vs_momentum_analytic_numerical.pdf'
	message = strcat('polrz_vs_momentum_analytic_numerical.pdf', ' was saved.');
	disp(message)

end


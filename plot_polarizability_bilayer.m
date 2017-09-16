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
		'PaperSize', [2.6, 2.6], ...
		'PaperPosition', [0, 0, 2.6, 2.6])
	ax = gca;
	hold(ax, 'on')
	grid(ax, 'on')
	axis(ax,[0 0.3 0 10])

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
		plot(ax, q_fine, polrz_fine, 'LineWidth', 1)
	end

	% Set axes properties.
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 10, ...
	'FontName', 'Times New Roman')
	title(ax, '$\Delta$ = 0 eV', 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $q \times b/ \pi$', 'Interpreter', 'latex')
	ylabel(ax, 'Polarizability $\Pi(q) /N_0$', 'Interpreter', 'latex')

	% Annotations
	annotation('arrow', [0.6, 0.6], [0.4, 0.8], 'HeadWidth', 6, 'HeadLength', 6)
	str1 = '$$E_f$$ = 0 eV';
	str2 = '$$E_f$$ = 0.8 eV';
	text(0.13, 2.5, str1, 'FontSize', 10, 'Interpreter', 'latex')
	text(0.13, 9, str2, 'FontSize', 10, 'Interpreter', 'latex')

	% Save the plot
	print -dpdf 'polrz_vs_momentum_delta0.pdf'
	message = strcat('polrz_vs_momentum_delta0.pdf', ' was saved.');
	disp(message)

	% Prepare the figure	
	figure('Units', 'inches', ...
		'PaperSize', [2.6, 2.6], ...
		'PaperPosition', [0, 0, 2.6, 2.6])
	ax = gca;
	hold(ax, 'on')
	grid(ax, 'on')
	axis(ax,[0 0.3 0 10])	

	% Plot for gapped bilayer graphene (delta = 0.8 and multiple Ef's)
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
		
		% Define finer grid for plotting.
		q_fine = linspace(0, 0.3, 100);
		polrz_fine = spline(q, polrz, q_fine); % interpolation

		% Plot
		plot(ax, q_fine, polrz_fine, 'LineWidth', 1)
	end

	% Set axes properties.
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 10, ...
	'FontName', 'Times New Roman')
	title(ax, '$\Delta$ = 0.8 eV', 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $q \times b/ \pi$', 'Interpreter', 'latex')
	ylabel(ax, 'Polarizability $\Pi(q) /N_0$', 'Interpreter', 'latex')

	% Annotations
	annotation('arrow', [0.6, 0.6], [0.4, 0.8], 'HeadWidth', 6, 'HeadLength', 6)
	str1 = '$$E_f$$ = 0 eV';
	str2 = '$$E_f$$ = 0.8 eV';
	text(0.13, 2.5, str1, 'FontSize', 10, 'Interpreter', 'latex')
	text(0.13, 9, str2, 'FontSize', 10, 'Interpreter', 'latex')
	
	% Save the plot
	print -dpdf 'polrz_vs_momentum_delta08.pdf'
	message = strcat('polrz_vs_momentum_delta08.pdf', ' was saved.');
	disp(message)

end


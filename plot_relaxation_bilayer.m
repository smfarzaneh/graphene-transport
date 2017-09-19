% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 19, 2017
% Title: Plot k-dependent momentum relaxation time  
% of electrons in bilayer graphene

function [] = plot_relaxation_bilayer()

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters
	init_variable;         	% initialize variables

	% Set numerical parameters 
	num_k 	= 200;
	kmax    = pi/b/4;
	kmin    = kmax/1e5;
	k       = logspace(log10(kmin), log10(kmax), num_k)';

	% Plot impurity relaxation time vs. momentum (k)
	% for different values of energy asymmetry 
	
	% Prepare the figure
	figure('Units', 'inches', ...
		'PaperSize', [2.33, 2.33], ...
		'PaperPosition', [0, 0, 2.33, 2.33], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	axis(ax,[0 0.2 1e10 1e13])
	
	% Set parameters
	Ef = 0.3*qe;  					% Fermi level [J]
	delta = [0.01*qe, 0.4*qe, 0.8*qe]; % energy asymmetry [J]
	num_delta = length(delta); 	
	Taui = zeros(num_k, num_delta); % impurity relaxation time
	Taud = zeros(num_k, num_delta); % defect relaxation time
	
	% Compute relaxation times
	for i = 1:length(delta)
		for j   = 1:length(k)
			[Taui(j, i), Taud(j, i)] = relaxation_bilayer(k(j), 1, 1, Ef, delta(i));
		end
	end

	% Ploting
	for i = 1:length(delta)
		Gami    = 1./Taui(:, i);
		plot(ax, k/pi*b, Gami, 'LineWidth', 1)
	end

	% Set axes properties
	set(gca, 'YScale', 'log')
	grid(ax, 'on')
	grid(ax, 'off')
	grid(ax, 'on')
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	title(ax, '$E_f$ = 0.1 eV', 'FontSize', 9, 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $k \times b/ \pi$', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Scattering rate $1/\tau_i(k)$', 'FontSize', 9, 'Interpreter', 'latex')
	leg = legend('$\Delta = 0.0$ eV', '$\Delta = 0.4$ eV', '$\Delta = 0.8$ eV');
	set(leg,'Interpreter','latex')

	% Save the plot
	print -dpdf 'relax_vs_momentum_impurity_ef01.pdf'
	message = strcat('relax_vs_momentum_impurity_ef01.pdf', ' was saved.');
	disp(message)

	% Plot defect relaxation time vs. momentum (k)
	% for different values of energy asymmetry 
	
	% Prepare the figure
	figure('Units', 'inches', ...
		'PaperSize', [2.33, 2.33], ...
		'PaperPosition', [0, 0, 2.33, 2.33], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	axis(ax,[0 0.2 1e12 1e15])

	% Ploting
	for i = 1:length(delta)
		Gamd    = 1./Taud(:, i);
		plot(ax, k/pi*b, Gamd, 'LineWidth', 1)
	end

	% Set axes properties
	set(gca, 'YScale', 'log')
	grid(ax, 'on')
	grid(ax, 'off')
	grid(ax, 'on')
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	title(ax, '$E_f$ = 0.1 eV', 'FontSize', 9, 'Interpreter', 'latex')
	xlabel(ax, 'Wavevector $k \times b/ \pi$', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Scattering rate $1/\tau_d(k)$', 'FontSize', 9, 'Interpreter', 'latex')
	leg = legend('$\Delta = 0.0$ eV', '$\Delta = 0.4$ eV', '$\Delta = 0.8$ eV');
	set(leg,'Interpreter','latex')

	% Save the plot
	print -dpdf 'relax_vs_momentum_defect_ef01.pdf'
	message = strcat('relax_vs_momentum_defect_ef01.pdf', ' was saved.');
	disp(message)

	
end

% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: October 16, 2017
% Title: Plot conductivity of bilayer graphene vs. carrier density

function [] = plot_conductivity()

	% Initialize necessary constants, variables, and functions
	init_constant;         	% initialize physical constants and parameters

	% set parameters 
	ni_scale = 1;
	ndvd_scale = 1;
	del = [0.01, 0.1, 0.2, 0.3]*qe;
	carrier = logspace(12, 16.3, 100);
	num_del = length(del);
	num_car = length(carrier);
	conduct = zeros(num_del, num_car);

	% Prepare the figure
	figure('Units', 'inches', ...
		'PaperSize', [3.4, 3.4], ...
		'PaperPosition', [0, 0, 3.4, 3.4], ...
		'visible', 'off')
	ax = gca;
	hold(ax, 'on')
	axis(ax,[-2 2 0 100])

	% calculate
	for i = 1:num_del
		[n, sigma] = conductivity(ni_scale, ndvd_scale, del(i));
		func = @(x) pchip(n/1e16, sigma/sig0, x);
		conduct(i, :) = func(carrier/1e16);
	end
	disp('Calculations done.')
	
	% concatenate 
	carrier = [-fliplr(carrier), carrier];
	conduct = [fliplr(conduct), conduct];

	% plot 
	for i = 1:num_del
		plot(ax, carrier/1e16, conduct(i, :), 'LineWidth', 1)
	end

	% Set axes properties
	grid(ax, 'on')
	set(ax, ...
	'Units', 'normalized', ...
	'FontUnits', 'points', ...
	'FontWeight', 'normal', ...
	'FontSize', 9, ...
	'FontName', 'Times New Roman')
	xlabel(ax, 'Carrier density $n$ ($\times 10^{12}\,$1/cm$^2$)', 'FontSize', 9, 'Interpreter', 'latex')
	ylabel(ax, 'Conductivity $\sigma/\sigma_0$', 'FontSize', 9, 'Interpreter', 'latex')
	leg = legend('$\Delta = 0.0$ eV', '$\Delta = 0.1$ eV', '$\Delta = 0.2$ eV', '$\Delta = 0.3$ eV', 'Location','north');
	set(leg,'Interpreter','latex')

	% Save the plot
	print -dpdf 'conductivity_vs_carrier_for_delta.pdf'
	message = strcat('conductivity_vs_carrier_for_delta.pdf', ' was saved.');
	disp(message)
	close all;

end
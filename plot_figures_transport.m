% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 19, 2017
% Title: Plot all the figures related to electronic transport 
% in bilayer graphene

function [] = plot_figures_transport()

	% Plot polarizability figures
	plot_polarizability_bilayer();

	% Plot momentum relaxation time figures
	% it actually plots scattering rates
	plot_relaxation_bilayer()

	% Plot conductivity figures
	plot_conductivity()

end
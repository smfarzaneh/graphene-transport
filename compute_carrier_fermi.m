% MATLAB R2015a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 25, 2017
% Title: Compute carrier density over a wide range of Fermi levels
% for a given energy asymmetry and save the data in data/carrier_fermi/

function [] = compute_carrier_fermi(del)
% del: energy asymmetry [J]

%% initialization

% initialize necessary constants, variables, and functions
init_constant;      % initialize physical constants and parameters
init_variable;      % initialize variables
delta 	= del; 		% replace energy asymmetry

% conduction band minimum and valance band maximum
minmax  = gamma1*delta/(2*sqrt(gamma1^2 + delta^2)); 


%% calculations 

% calculate carrier density for a wide range of Fermi levels
fermi = linspace(0.01*qe, 0.8*qe, 50);
carrier = carrier_fermi_bilayer(fermi, del);

% concatenate with negative values
fermi = [-fliplr(fermi), fermi]';
carrier = [-fliplr(carrier), carrier]';

% Save data to file
directory = 'data/carrier_fermi/';
filename = strcat('carrier', '_del', num2str(delta/qe), '_T', num2str(T), '.csv');
destination = strcat(directory, filename);
M = [fermi, carrier];
csvwrite(destination, M);
disp([filename, ' was saved.'])

end
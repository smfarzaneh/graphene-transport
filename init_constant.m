% MATLAB R2015a script
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Physical constatns and parameters of graphene 

qe      = 1.602176462e-19;      % electron charge [C]
kB      = 1.380650300e-23;      % Boltzmann constant [J/K]
eps0 	= 8.854187817e-12;      % permitivity of free space, [F/m]
h 		= 6.626068760e-34;      % Planck constant [J.s]
hbar    = h/(2*pi);             % reduced Planck constant [J.s]      
a       = 1.42e-10;             % carbon-carbon distance [m]
b       = sqrt(3)*a;            % Graphene lattice constant [m]
gamma0  = 3*qe;                 % intra layer hopping parameter [J]
vf      = gamma0*3*a/(2*hbar);  % Fermi velocity [m/s]
gamma1  = 0.4*qe;               % inter layer hopping parameter [J]
gs      = 2;                    % spin degeneracy
gv      = 2;                    % valley degeneracy
g       = gs*gv;                % spin and valley degeneracy
m       = gamma1/(2*vf^2);      % effective mass [Kg]
N0      = g*m/(2*pi*hbar^2);    % density of states [1/J*m^2] 
d       = 0.35e-9;              % interlayer distance [m]
sig0    = qe^2/h;               % quantum conductance [S]
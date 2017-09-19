% MATLAB R2015a script
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: Intrinsics and extrinsic variables of graphene

% Fermi level [J]
Ef      = 0.3*qe;      
% energy asymmetry [J]
delta   = 0.8*qe;
% temperature [K]
T       = 300;          
% impurity concentration [1/m^2] (sarma2011electronic)
ni      = 1e15;        
% disorder scattering parameter (sarma2011electronic)
ndvd    = 1*qe^2*1e-20;     
% substrate (SiO2) relative permittivity
epsr    = 3.9;
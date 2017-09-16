% MATLAB R2015a script
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: September 10, 2017
% Title: functions definition
% Note: some physical constants and variabels must be defined beforehand;
% to do this, run init_constant.m and init_variable.m first. 

% Fermi function, E: energy
f       = @(E) 1./(1 + exp((E - Ef)./(kB*T)));
% derivative of Fermi function
df      = @(E) -1/(kB*T)*exp((E - Ef)./(kB*T)).*f(E).^2;

%% bandstructure
% monolayer dispersion
phi     = @(k) hbar*vf*k;
% auxiliary function
Lambda  = @(k) sqrt(gamma1^4/4 + abs(phi(k)).^2.*(delta^2 + gamma1^2));
% band structure
% k: complex wavevector, s: band index, alpha: subband index
ek      = @(k, s, alpha) s*sqrt(gamma1^2/2 + delta^2/4 + abs(phi(k)).^2 ...
    + (-1)^alpha.*Lambda(k));
% derivative of bandstructure
de      = @(k, s, alpha) s*hbar^2*vf^2*k.* ...
    (2 + (-1)^alpha*(gamma1^2 + delta^2))./(2*ek(k, s, alpha));

%% un-normalized wavefunction
% eigenvector of the 4x4 Hamiltonian corresponding to 
% wavevector k, band s, and sub-band alpha
% first component
Upsi1   = @(k, s, alpha) ...
    gamma1*(conj(phi(k))).*(ek(k, s, alpha) - delta/2);
% second component
Upsi2   = @(k, s, alpha) ...
    phi(k).*((ek(k, s, alpha) + delta/2).^2 - abs(phi(k)).^2);
% third component
Upsi3   = @(k, s, alpha) ...
    (ek(k, s, alpha) - delta/2).* ...
    ((ek(k, s, alpha) + delta/2).^2 - abs(phi(k)).^2);
% fourth component
Upsi4   = @(k, s, alpha) ...
    gamma1*(ek(k, s, alpha) - delta/2).*(ek(k, s, alpha) + delta/2);

%% norm of the un-normalized wavefunction
Unorm   = @(k, s, alpha) sqrt( ...
    conj(Upsi1(k, s, alpha)).*Upsi1(k, s, alpha) + ...
    conj(Upsi2(k, s, alpha)).*Upsi2(k, s, alpha) + ...
    conj(Upsi3(k, s, alpha)).*Upsi3(k, s, alpha) + ...
    conj(Upsi4(k, s, alpha)).*Upsi4(k, s, alpha));

%% normalized wavefunctions
% first component
psi1    = @(k, s, alpha) ...
    Upsi1(k, s, alpha)./Unorm(k, s, alpha);
% second component
psi2    = @(k, s, alpha) ...
    Upsi2(k, s, alpha)./Unorm(k, s, alpha);
% third component
psi3    = @(k, s, alpha) ...
    Upsi3(k, s, alpha)./Unorm(k, s, alpha);
% fourth component
psi4    = @(k, s, alpha) ...
    Upsi4(k, s, alpha)./Unorm(k, s, alpha);

%% wavefunctions overlap
overlap = @(k, kp, s, sp, alpha, alphap) abs( ...
    conj(psi1(kp, sp, alphap)).*psi1(k, s, alpha) + ...
    conj(psi2(kp, sp, alphap)).*psi2(k, s, alpha) + ...
    conj(psi3(kp, sp, alphap)).*psi3(k, s, alpha) + ...
    conj(psi4(kp, sp, alphap)).*psi4(k, s, alpha)).^2;

%% polarizability integrand
% for individual sub-bands
plrzi   = @(k, kp, s, sp, alpha, alphap) -g/(2*pi)^2* ...
    (f(ek(k, s, alpha)) - f(ek(kp, sp, alphap)))./ ...
    (ek(k, s, alpha) - ek(kp, sp, alphap)).* ...
    overlap(k, kp, s, sp, alpha, alphap);
% sum over all the bands and subbands
plrz    = @(k, kp) ...
    plrzi(k, kp, 1, 1, 1, 1) + ...
    plrzi(k, kp, 1, 1, 1, 2) + ...
    plrzi(k, kp, 1, 1, 2, 1) + ...
    plrzi(k, kp, 1, 1, 2, 2) + ...
    plrzi(k, kp, 1, -1, 1, 1) + ...
    plrzi(k, kp, 1, -1, 1, 2) + ...
    plrzi(k, kp, 1, -1, 2, 1) + ...
    plrzi(k, kp, 1, -1, 2, 2) + ...
    plrzi(k, kp, -1, 1, 1, 1) + ...
    plrzi(k, kp, -1, 1, 1, 2) + ...
    plrzi(k, kp, -1, 1, 2, 1) + ...
    plrzi(k, kp, -1, 1, 2, 2) + ...
    plrzi(k, kp, -1, -1, 1, 1) + ...
    plrzi(k, kp, -1, -1, 1, 2) + ...
    plrzi(k, kp, -1, -1, 2, 1) + ...
    plrzi(k, kp, -1, -1, 2, 2);

% analytic polarizability of bilayer graphene 
% reference: hwang2008screenning
an_plrz_f   = @(q, kf) ...
    (2*kf.^2 + q.^2)./(2*kf.^2.*q).*sqrt(q.^2 - 4*kf.^2) + ...
    log((q - sqrt(q.^2 - 4*kf.^2))./(q + sqrt(q.^2 - 4*kf.^2)));

an_plrz_g   = @(q, kf) ...
    1./(2*kf.^2).*sqrt(4*kf.^4 + q.^4) - ...
    log((kf.^2 + sqrt(kf.^4 + q.^4/4)))./(2*kf.^2));

an_plrz     = @(q, kf) ...
    N0*(an_plrz_g(q, kf) - an_plrz_f(q, kf).*heaviside(q - 2*kf));

%% density of states
dos     = @(k, s, alpha) ...
    g/(2*pi)*abs((2*ek(k, s, alpha))./ ...
    (hbar^2*vf^2*(2 + (-1)^alpha*(delta^2 + gamma1^2)./(Lambda(k)))));

%% impurity scattering functions
% bare coulomb interaction
v       = @(q) (2*pi*qe^2)./(4*pi*eps0*epsr*abs(q));
% coulomb scattering potential
vi      = @(q) v(q).*exp(-abs(q)*d);
% dielectric function of bilayer graphene 
die     = @(q, pie) 1 + v(q).*pie;
% impurity scattering potential
V       = @(q, Pie) vi(q)./die(q, Pie);
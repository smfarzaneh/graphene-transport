% MATLAB R2017a function
% S. M. Farzaneh, farzaneh@nyu.edu
% Created: November 9, 2017
% Title: check if carrier_imbalance and carrier_fermi_bilayer give the same result

function [] = test_carrier() 

	% initialize
	init_constant;         	

	% set parameters 
	num = 50;
	ef  = linspace(0, 0.5*qe, num);
	del = 0.4*qe;

	% calculate carrier density of individual layers using carrier_imbalance
	dn = zeros(num); 
	n1 = zeros(num);
	n2 = zeros(num);
	for i = 1:num
		[dn(i), n1(i), n2(i)] = carrier_imbalance(ef(i), del, 300);
	end
	n = n1 + n2;
	disp('carrier_imbalance done.')

	% calculate total carrier density using carrier_fermi_bilayer
	np = carrier_fermi_bilayer(ef, del);
	disp('carrier_fermi_bilayer done.')

	% plot 
	semilogy(ef/qe, abs(dn), 'LineWidth', 2) 
	hold on
	semilogy(ef/qe, abs(n1), 'LineWidth', 2)
	semilogy(ef/qe, abs(n2), 'LineWidth', 2)
	semilogy(ef/qe, abs(n1 + n2), 'LineWidth', 2)
	semilogy(ef/qe, abs(np), '--', 'LineWidth', 2)
	leg = legend('$\delta n$', '$n_1$', '$n_2$', '$n_{new}$', '$n_{old}$');
	set(leg,'Interpreter','latex')
	axis([ef(1)/qe, ef(num)/qe, 1e10, 1e18])
	print -dpdf 'test_carrier.pdf'
	close all

	disp('test_carrier.pdf saved.')


	Ef = 0.1*qe;
	delta = 0.4*qe; 
	init_function
	% wavefunction amplitudes of the two layers
	amplitude_1 = @(k, s, alpha) ...
		abs(psi1(k, s, alpha)).^2 + ...
		abs(psi4(k, s, alpha)).^2;
	amplitude_2 = @(k, s, alpha) ...
		abs(psi2(k, s, alpha)).^2 + ...
		abs(psi3(k, s, alpha)).^2;

	% test wavefunction amplitudes 
    k = linspace(0, pi/b, 100);
    amp_1 = amplitude_1(k, -1, 2) + amplitude_2(k, -1, 2);
    amp_2 = amplitude_1(k, -1, 1) + amplitude_2(k, -1, 1);
    amp_3 = amplitude_1(k, 1, 1) + amplitude_2(k, 1, 1);
    amp_4 = amplitude_1(k, 1, 2) + amplitude_2(k, 1, 2);
    plot(k, amplitude_1(k, 1, 2), k, amplitude_2(k, 1, 2)) %, k, amp_2, k, amp_3, k, amp_4, k, amp_tot)
    % axis([0, pi/b, -1, 5])
    print -dpdf 'test-amplitude.pdf'
    close all

    disp('test-amplitude.pdf saved.')

end
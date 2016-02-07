%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       ReturnSpectralGap.m
%%% Function:   ReturnSpectralGap(n, lambda_h_min, lambda_h_max,
%%%                 lambda_h_interval, lambda_v, linespec)
%%% Purpose:    Returns spectral gap values for a Hamiltonian with a
%%% slope 1 lattice of size n, for a given lambda_v and range of 
%%% varying lambda_h values. Similar function for slope 2 Hamiltonians.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function evalues = ReturnSpectralGap(n, lambda_h_min, lambda_h_max, lambda_h_interval, lambda_v, linespec)

% Initialize eigenvalues array
evalues = [];

for lambda_h = lambda_h_min:lambda_h_interval:lambda_h_max
		
	% Compute the Hamiltonian and diagonalize
	H = Ham1(n, lambda_h, lambda_v);
	D = eig(H);
	
	% Take the absolute value of all eigenvalues
	D = abs(D);
	
	% Sort the eigenvalues in ascending order
	Dsorted = sort(D);

	% Select the second smallest eigenvalue by absolute value
	selected = D(2);
	
	% Add to the eigenvalues matrix
	evalues = [evalues D(2)];
	
end

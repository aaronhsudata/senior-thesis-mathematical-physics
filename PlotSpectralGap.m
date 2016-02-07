%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       PlotSpectralGap.m
%%% Function:   PlotSpectralGap(n, lambda_h_min, lambda_h_max,
%%%                 lambda_h_interval, lambda_v, linespec)
%%% Purpose:    Calculates and plots the spectral gap for the slope 1
%%% Hamiltonian of lattice size n, for a given lambda_v and varying
%%% lambda_h's and the desired linespec. Note: Should be used after the
%%% command "hold on". Similar function for slope 2 Hamiltonians.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PlotSpectralGap(n, lambda_h_min, lambda_h_max, lambda_h_interval, lambda_v, linespec)

% Initialize evalues and lambdas arrays
evalues = [];
lambdas = [];

for lambda_h = lambda_h_min:lambda_h_interval:lambda_h_max
		
	% Construct the Hamiltonian and diagonalize
	H = Ham1(n, lambda_h, lambda_v);
	D = eig(H);
	
	% Take the absolute value of all eigenvalues
	D = abs(D);
	
	% Sort the eigenvalues in ascending order
	Dsorted = sort(D);

	% Select the second smallest eigenvalue by absolute value
	selected = D(2);
	
	% Add to the evalues matrix
	evalues = [evalues D(2)];
	
end

% Plot the spectral gaps
plotname = sprintf('\\lambda_v = %g', lambda_v);
plot(lambda_h_min:lambda_h_interval:lambda_h_max, evalues, linespec,'DisplayName',plotname);
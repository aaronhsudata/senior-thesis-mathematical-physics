%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       PlotNormRatioByN.m
%%% Function:   PlotNormRatioByN(max_n, lambda_h, lambda_v, linespec)
%%% Purpose:    Calculates and plots the norm ratio of the ground state
%%% eigenvector for slope 1 Hamiltonians of sizes 2 to max_n, with 
%%% given lambdas and the specified linespec. Note: Should be used 
%%% after the command "hold on". Similar function for slope 2
%%% Hamiltonians
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PlotNormRatioByN(max_n, lambda_h, lambda_v, linespec)

% Initialize results array
results = [];

% Perform computations
for n = 2:max_n
	
	% Calculate the Hamiltonian
	H = Ham1(n, lambda_h, lambda_v);
	
	% Compute the ground state
	groundstate = GroundState(H);
	
	% Calculate the ground state's (infinity-norm)/(2-norm)
	normratio = NormRatio(groundstate);
	
	% Add to results array
	results = [results normratio];

end

% Plot the results
plotname = sprintf('\\lambda_h = %g, \\lambda_v = %g', lambda_h, lambda_v);
plot(2:max_n, results, linespec, 'DisplayName', plotname);
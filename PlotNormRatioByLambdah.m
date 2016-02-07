%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       PlotNormRatioByLambdah.m
%%% Function:   PlotNormRatioByLambdah(n, lambda_h_min, lambda_h_max,
%%%                 lambda_h_interval, lambda_v, linespec)
%%% Purpose:    Computes and plots the norm ratio of the ground state 
%%% for Hamiltonians with slope 1 lattices of sizes 2 to max_n,
%%% with the given lambdas. Note: Should be used after the command
%%% "hold on". Similar function for slope 2 lattices.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PlotNormRatioByLambdah(n, lambda_h_min, lambda_h_max, lambda_h_interval, lambda_v, linespec)

% Initialize results array
results = [];

% Perform computations
for lambda_h = lambda_h_min:lambda_h_interval:lambda_h_max
	
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
plotname = sprintf('\\lambda_v = %g', lambda_v);
plot(lambda_h_min:lambda_h_interval:lambda_h_max, results, linespec,'DisplayName',plotname);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       MultipleDensityPlots.m
%%% Function:   MultipleDensityPlots(n, lambda_h_min, lambda_h_max,
%%%                 interval_h, lambda_v_min, lambda_v_max, interval_v
%%%                 resolution)
%%% Purpose:    Creates density plots for a Hamiltonian with a slope
%%% 1 lattice of size n with a range of lambda_h and lambda_v values.
%%% Plotting resolution was specified at 0.01 to generate plots in the
%%% paper. Note: Please create the 'DensityPlot_results' folder in the
%%% Matlab current directory first. Similar function for slope 2
%%% lattices. Returns 1 if successful.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Create density plots for a range of lambda_h and lambda_v values.
function success = MultipleDensityPlots(n, lambda_h_min, lambda_h_max, interval_h, lambda_v_min, lambda_v_max, interval_v, resolution)

% Reset graphical environment
close all;

% Create list of lambdas to use
lambda_h_list = lambda_h_min:interval_h:lambda_h_max;
lambda_v_list = lambda_v_min:interval_v:lambda_v_max;

% Replace all zeroes by small non-zero values
for i = 1:length(lambda_h_list)
	if lambda_h_list(i) == 0
		lambda_h_list(i) = 0.000001;
	end
	if lambda_v_list(i) == 0
		lambda_v_list(i) = 0.000001;
	end
end

i = 1;

% Compute the number of plots to be created
fprintf('A total of %g plots will be created and saved.\n', length(lambda_h_list)*length(lambda_v_list));

% Main execution loop; create a density plot for every pair of lambda_h, lambda_v
for lambda_h = lambda_h_list
	for lambda_v = lambda_v_list
		temp = DensityPlot1(n, lambda_v, lambda_h, resolution, 0, 1);
		fprintf('Plot number %g complete.\n', i);
		i = i+1;
	end
end

% Reset graphical environment
close all;

% Return success code
success = 1;

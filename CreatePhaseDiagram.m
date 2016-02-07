%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       CreatePhaseDiagram.m
%%% Function:   CreatePhaseDiagram(n, lambda_h_min, lambda_h_max,
%%%                 interval_h, lambda_v_min, lambda_v_max, interval_v)
%%% Purpose:    Assists the user in creating phase diagrams for density
%%% plots created with MultipleDensityPlots. Saves the classification
%%% data in the file "classification.mat". Note: Arguments used should
%%% be the same as those used in the MultipleDensityPlots function. To
%%% recreate a phase diagram from the "classification.mat" file, use
%%% the function RecreatePhaseDiagram.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = CreatePhaseDiagram(n, lambda_h_min, lambda_h_max, interval_h, lambda_v_min, lambda_v_max, interval_v)

% Set up graphical environment
close all;

% Initialize results matrix
results = zeros(length(lambda_h_min:interval_h:lambda_h_max), length(lambda_v_min:interval_v:lambda_v_max));

% Note: lambda_h values vary across rows
%		lambda_v values vary across columns

% Main execution loop; display a density plot for every pair of lambda_h, lambda_v and request a classification

% First lambda_h goes into first row
results_row = 1;

for lambda_h = lambda_h_min:interval_h:lambda_h_max
	
	% First lambda_v goes into first column
	results_col = 1;

	for lambda_v = lambda_v_min:interval_v:lambda_v_max
			
		% Display density plot
		currentfile = sprintf('densityplot_lv_%4.2f_lh_%4.2f_n_%g.jpg', lambda_h, lambda_v, n);
		fullname = fullfile(pwd,'DensityPlot_results',currentfile);
		I = imread(fullname);
		imshow(I);
		
		% Request classification
		class = input('Please classify this density plot configuration:\n', 's');
		
		% Store classification
		results(results_row, results_col) = class;
		
		% Increment results column index
		results_col = results_col+1;		
        
	end
	
	% Increment results row index
	results_row = results_row+1;
    
end

% Convert results matrix to a character array
results = char(results)

% Plot the phase diagram
close all;
figure;
hold on;
size(results)
j = 1;
for j = 1:size(results(:,1))			% Iterate through values of lambda_h
	k = 1;
	for k = 1:size(results(:,2))		% Iterate through values of lambda_v
		marker = 'o';
		if results(j,k) == 'c'			% Corner (near)
			color = 'm';
		elseif results(j,k) == 'd'		% Diagonal boundary
			color = 'y';
		elseif results(j,k) == 'f'		% Far corner
			color = 'c';
		elseif results(j,k) == 'r'		% Right boundary
			color = 'r';
		elseif results(j,k) == 'b'		% Bottom boundary
			color = 'g';
		elseif results(j,k) == 's'		% Scattered
			color = 'k';			
		elseif results(j,k) == 'e';		% Bottom right corner
			color = 'b';				
		else
			color = 'k';
			marker = 'd';
		end
		scatter(j, k, color, marker);
		k = k+1;
	end
	j = j+1;
end

% Save data
save('classification.mat', 'results');

% Reset graphical environment
hold off;
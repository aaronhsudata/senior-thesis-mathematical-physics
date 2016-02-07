%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       RecreatePhaseDiagram.m
%%% Function:   RecreatePhaseDiagram(n, lambda_h_min, lambda_h_max,
%%%                 interval_h, lambda_v_min, lambda_v_max,
%%%                 interval_v, results)
%%% Purpose:    Recreates a phase diagram from density plots created
%%% previously with MultipleDensityPlots and classified with
%%% CreatePhaseDiagram. Loads the user classification data from the
%%% array results. Note: Load the 'classification.mat' data first and
%%% specify the loaded variable name as parameter "results". Other
%%% arguments used should be the same as those originally used in the
%%% MultipleDensityPlots function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = RecreatePhaseDiagram(n, lambda_h_min, lambda_h_max, interval_h, lambda_v_min, lambda_v_max, interval_v, results)

% Set up graphical environment
close all;
h = 1;
figure(h);
hold on;

% Plot the phase diagram
j = 1;                                  % Start at row 1
results = transpose(results);           % Correct which one is lambda_h, which one is lambda_v
for j = 1:size(results(:,1))			% Iterate through values of lambda_h
	k = 1;
	for k = 1:size(results(:,2))		% Iterate through values of lambda_v
		marker = 'o';
		if results(j,k) == 'c'			% Corner (near)
			color = 'g';
            marker = 'o';
		elseif results(j,k) == 'd'		% Diagonal boundary
			color = 'y';
            marker = 'x';
		elseif results(j,k) == 'f'		% Far corner
			color = 'b';
            marker = 'square';
		elseif results(j,k) == 'r'		% Right boundary
			color = 'm';
            marker = 'pentagram';
		elseif results(j,k) == 'b'		% Bottom boundary
			color = 'c';
            marker = '*';
		elseif results(j,k) == 's'		% Scattered
			color = 'k';
            marker = 'd';
		elseif results(j,k) == 'e';		% Bottom right corner
			color = 'r';
            marker = '^';
        else                            % Errors
			color = 'k';
			marker = 'd';
		end
		scatter(j, k, color, marker);
		k = k+1;
	end
	j = j+1;
end

% Set axes and background color
set(findobj(gcf,'type','axes'), 'XTickLabel', [0:0.2:lambda_h_max + 0.1])
set(findobj(gcf,'type','axes'), 'YTickLabel', [0:0.2:lambda_v_max + 0.1])
set(gcf,'color','w');

% Annotate plot
xlabel('\lambda_h');
ylabel('\lambda_v');
title('Phase Diagram of Density Plot State by \lambda_h, \lambda_v');

% Reset graphics environment
hold off;
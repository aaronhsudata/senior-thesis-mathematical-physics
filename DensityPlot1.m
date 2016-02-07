%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       DensityPlot1.m
%%% Function:   DensityPlot1(n, lambda_v, lambda_h, resolution, show,
%%%                 save)
%%% Purpose:    Creates a density plot indicating the probability of 
%%% the particle being found at each site on the slope 1 lattice of
%%% size n, with Hamiltonian lambda parameters as specified. Plotting
%%% resolution was specified at 0.01 to generate plots in the paper. 
%%% Probability is indicated by both size and color. If save == 1,
%%% saves the plot as a .jpg file. if show == 1, displays the image. 
%%% Note: Please create the 'DensityPlot_results' folder in the Matlab
%%% current directory firstif saved plots are desired. Similar function
%%% for slope 2 lattices.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function h = DensityPlot1(n, lambda_v, lambda_h, resolution, show, save)

% Set up graphical environment
close all
h = 1;
figure(h);
set(h, 'color', 'white');
if show == 0
	set(h, 'Visible', 'off');
end
hold on

% Initialize results matrix
results = [];
plotnorm_list = [];

% Generate the list of vertices
lastvertex = nchoosek(n+1, 2);
L = VertexList1(lastvertex);

% Compute the Hamiltonian
H = Ham1(n, lambda_h, lambda_v);

% Diagonalize the Hamiltonian
[V, D] = eig(H);

% Generate rounded norms for plotting
for i = 1:length(V(1,:))
	
	% Calculate the norm squared
	normsq = norm(V(i), 2)^2;
	
	% Round the norm for plotting
	normsq_r = round(normsq * 1000) / 1000;
	plotnorm = 1000 * normsq_r;
	plotnorm_list = [plotnorm_list plotnorm];
    
end


% Set plotting parameters
size = linspace(2, 500, 1000);		% to vary circle size
color = linspace(1, 101, 1000);		% to vary circle color

% Plot each vertex
for i = 1:length(V(1,:))

	% Plot in a scatterplot
	scatter(L(2,i), L(3,i), size(plotnorm_list(i)+1), color(plotnorm_list(i)+1));
	axis([-1 n+1 -1 n+1])
	
end

% Plotting annotations
plotname = sprintf('Probability Density Plot for \\lambda_v = %g, \\lambda_h = %g (lattice columns = %g)', lambda_v, lambda_h, n);
% title(plotname);              % Uncomment if plot title is desired
xlabel('Lattice column number');
ylabel('Lattice row number');

% Save the figure
if save == 1
	filename = sprintf('densityplot_lv_%4.2f_lh_%4.2f_n_%g.jpg', lambda_v, lambda_h, n);
	fullname = fullfile(pwd,'DensityPlot_results',filename);
	I = getframe(h);
	set(h, 'units', 'inches', 'PaperPosition', [0 0 4 3]);
	imwrite(I.cdata, fullname, 'Quality',100);
end

% Reset graphical environment
hold off
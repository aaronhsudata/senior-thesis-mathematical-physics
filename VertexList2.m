%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       VertexList2.m
%%% Function:   VertexList2(last_n)
%%% Purpose:    Creates a list of all vertex coordinates with
%%% corresponding lattice site numbers up to the last point last_n
%%% for a lattice of slope 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function vertex_list = VertexList2(last_n)

% Initialize variables
old_x = 0;
old_y = 0;
vertex_list = [];

for vertexnum = 1:last_n
	
	% If next point is below y = 2x, add the next point up
	if old_y + 1 <= 2*old_x
		new_x = old_x;
		new_y = old_y + 1;
		
	% If next point is above y = 2x, add the next point in the next column
	elseif old_y + 1 > 2*old_x
		new_x = old_x + 1;
		new_y = 0;
	end
	
	% Record new_x, new_y corresponding to n
	temp = [vertexnum, old_x, old_y]';
	vertex_list = horzcat(vertex_list, temp);
	
	% Set new variables as old variables to prepare for the next loop
	old_y = new_y;
	old_x = new_x;
    
end

% Uncomment to plot the resulting lattice
% scatter(vertex_list(2,:), vertex_list(3,:))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       Ham1.m
%%% Function:   Ham1(n, lambda_v, lambda_h)
%%% Purpose:    Creates the Hamiltonian operator for a lattice of n
%%% points and slope 1 with nearest-neighbor interaction weights
%%% lambda_v and lambda_h.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H = Ham1(n, lambda_v, lambda_h)

% Initialize vector of edges
listofhedges = [1;2];
listofvedges = [];

% Loop through each column of the lattice except the last; this gives all edges besides vertical edges for outermost column of lattice
for latticecol = 2:(n-1)
	
	% Edge for boundary vertex
    boundary = nchoosek(latticecol+1,2);                            % Calculate the boundary point
		
		% Edge going to the right
		start = boundary;											% Calculate the starting point
		finish = (boundary + latticecol);							% Calculate the ending point
		boundaryedge = [start, finish]';							% Put together the edge
		listofhedges(1:2,size(listofhedges,2)+1) = boundaryedge;	% Append the edge to the list of edges
		
	% Edges for non-boundary vertices
	for current = (nchoosek(latticecol,2)+1):nchoosek(latticecol+1,2)-1
	
		% Edge going above
		start = current;
		finish = current+1;
		aboveedge = [start, finish]';
		listofvedges(1:2,size(listofvedges,2)+1) = aboveedge;
		
		% Edge going to the right
		start = current;
		finish = (current + nchoosek(latticecol+1,2) - nchoosek(latticecol,2));
		rightedge = [start, finish]';
		listofhedges(1:2,size(listofhedges,2)+1) = rightedge;
			
	end
end

% Create vertical edges of the last column of the lattice
for current = (nchoosek(n,2)+1):nchoosek(n+1,2)-1

    % Edge going above
    start = current;
    finish = current+1;
    aboveedge = [start, finish]';
    listofvedges(1:2,size(listofvedges,2)+1) = aboveedge;
    
end
	
% Create a Hamiltonian of zeroes
vertexmax = nchoosek(n+1,2);
H = zeros(vertexmax);

% Update Hamiltonian entries for vertical edges
for p = 1:size(listofvedges,2);
	x = listofvedges(1,p);
	y = listofvedges(2,p);
	H(x,x) = H(x,x) + 1;
	H(y,y) = H(y,y) + lambda_v^2;
	H(x,y) = H(x,y) - lambda_v;
	H(y,x) = H(y,x) - lambda_v;
end

% Update Hamiltonian entries for horizontal edges
for p = 1:size(listofhedges,2);
	x = listofhedges(1,p);
	y = listofhedges(2,p);
	H(x,x) = H(x,x) + 1;
	H(y,y) = H(y,y) + lambda_h^2;
	H(x,y) = H(x,y) - lambda_h;
	H(y,x) = H(y,x) - lambda_h;
end
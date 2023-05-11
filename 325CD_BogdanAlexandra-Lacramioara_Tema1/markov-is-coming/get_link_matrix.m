function [Link] = get_link_matrix (Labyrinth)
	% Labyrinth -> the matrix of all encodings

  	% Link -> the link matrix associated with the given labyrinth

  	% Get the number of rows and columns in the labyrinth
  	nr_rows = rows(Labyrinth);
  	nr_cols = columns(Labyrinth);
  	
  	% Calculate the total number of states (including yes and no states)
  	states = nr_rows * nr_cols + 2;
  	
  	% Initialize the link matrix with sparse zeros
  	Link = sparse(states, states);
  	
  	% Set indices for yes and no states
  	yes = states - 1;
  	no = states;
  	
  	% Loop through each position in the labyrinth
  	for i = 1:nr_rows
      	for j = 1:nr_cols
          	% Get the binary representation of the current position
          	V = dec2bin(Labyrinth(i,j), 4);
          	
          	% Calculate the current state index
          	cs = (i - 1) * nr_cols + j;
          	
          	% Count the number of valid directions to move
          	elems = sum(V == '0');
          	
          	% Update the link matrix based on valid directions
          	if V(1) == '0'   % can go up (1=wall)
              	if i == 1       % exit with success, yes state
                  	Link(cs, yes) = 1/elems;
              	else
                  	Link(cs, (i - 2) * nr_cols + j) = 1/elems;
              	endif
          	endif
          	
          	if V(2) == '0'   % can go down (1=wall)
              	if i == nr_rows       % exit with success, yes state
                  	Link(cs, yes) = 1/elems;
              	else
                  	Link(cs, i * nr_cols + j) = 1/elems;
              	endif
          	endif
          	
          	if V(3) == '0'   % can go right (1=wall)
              	if j == nr_cols       % exit with insuccess, no state
                  	Link(cs, no) = 1/elems;
              	else
                  	Link(cs, (i - 1) * nr_cols + j + 1) = 1/elems;
              	endif
          	endif
          	
          	if V(4) == '0'   % can go left (1=wall)
              	if j == 1       % exit with insuccess, no state
                  	Link(cs, no) = 1/elems;
              	else
                  	Link(cs, (i - 1) * nr_cols + j - 1) = 1/elems;
              	endif
          	endif
      	endfor
  	endfor
  	
  	% Set the yes and no states to have self-loops with probability 1
  	Link(yes, yes) = 1;
  	Link(no, no) = 1;
  	
endfunction

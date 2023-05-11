function [G, c] = get_Jacobi_parameters (Link)
	% Link -> the link matrix (edge with probabilities matrix)

  % G -> iteration matrix
	% c -> iteration vector

  % TODO: get_Jacobi_parameters
  
  % Get the size of the original matrix
  [m, n] = size(Link);

  % Create a new sparse matrix without the last 2 rows and columns
  G = sparse(m-2, n-2);
  c = sparse(n-2, 1);

  % Copy the relevant elements from the original matrix to the new matrix
  for i = 1:m-2
      for j = 1:n-2
          G(i,j) = Link(i,j);
      end
  endfor
  for j = 1:n-2
      c(j) = Link(j, n-1);
  endfor

endfunction

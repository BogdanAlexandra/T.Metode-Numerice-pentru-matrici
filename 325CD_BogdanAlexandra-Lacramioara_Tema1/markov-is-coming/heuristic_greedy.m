function [path] = heuristic_greedy (start_position, probabilities, Adj)
	% start_position -> the starting point in the labyrinth
	% probabilities -> vector of associated probabilities: including WIN and LOSE
	% Adj -> adjacency matrix
	
	% path -> the states chosen by the algorithm
  
  % TODO: heuristic_greedy implementation

  % path -> the states chosen by the algorithm
  path = [start_position];
  visited = zeros(1, length(probabilities));
  visited(start_position) = 1;
  
  while !isempty(path)
    position = path(end); % last element of the path vector
    if position == length(probabilities) - 1 % position is the WIN state
      return;
    endif
    unvisited_neigh = find(Adj(position,:) & !visited); % unvisited neighbors
    if isempty(unvisited_neigh)
      path(end) = []; % erase position from the end of the path
    else
      [~,max_prob_neigh] = max(probabilities(unvisited_neigh)); % neighbor with greatest probability to reach WIN
      neigh = unvisited_neigh(max_prob_neigh);
      visited(neigh) = 1;
      path = [path, neigh];
    endif
  endwhile
  
  % return empty path (since there is no path to the WIN state)
  path = [];
  
  % print path with a newline after every value
  for i = 1:length(path)
    fprintf("%d\n", path(i));
  endfor

endfunction


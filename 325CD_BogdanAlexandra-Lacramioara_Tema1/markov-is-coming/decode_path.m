function [decoded_path] = decode_path (path, lines, cols)
	% path -> vector containing the order of the states that arrived
	% 		 to a winning position
	% lines -> numeber of lines
	% cols -> number of columns
	
	% decoded_path -> vector of pairs (line_index, column_index)
  %                 corresponding to path states
  % hint: decoded_path does not contain indices for the WIN state

  % TODO: decode_path implementation

    decoded_path = zeros(length(path) - 1, 2); % allocate space for decoded path
    for i = 1:length(path) - 1 % iterate through path vector
        if path(i) != length(lines) * length(cols) % skip WIN state
            row_index = ceil(path(i) / cols); % calculate row index
            column_index = mod(path(i) - 1, cols) + 1 ; % calculate column index
            decoded_path(i, :) = [row_index, column_index]; % store as pair in decoded path
        endif
    endfor


endfunction
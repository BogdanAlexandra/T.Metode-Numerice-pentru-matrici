   function [Adj] = get_adjacency_matrix(Labyrinth)
      % Labyrinth -> the matrix of all encodings

      % Adj -> the adjacency matrix associated to the given labyrinth

   % Get number of rows and columns of the labyrinth
   [nr_rows, nr_cols] = size(Labyrinth);

   % Compute number of states, 2 for yes and no states
   states = nr_rows * nr_cols + 2;

   % Initialize adjacency matrix with sparse matrix
   Adj = sparse(states, states);

   % Compute indices for yes and no states
   yes = states - 1;
   no = states;

   % Loop through each cell in the labyrinth
   for i = 1:nr_rows
      for j = 1:nr_cols
         % Get binary encoding of current cell
         binary_value = dec2bin(Labyrinth(i,j), 4);

         % Compute current state index
         current_state = (i-1) * nr_cols + j;

         % Check if can go up (1=wall)
         if binary_value(1) == '0'
               % Check if at top row
               if i == 1
                  % Exit with success, connect to yes state
                  Adj(current_state, yes) = 1;
               else
                  % Connect to state above
                  Adj(current_state, (i-2)*nr_cols + j) = 1;
               endif
         endif

         % Check if can go down (1=wall)
         if binary_value(2) == '0'
               % Check if at bottom row
               if i == nr_rows
                  % Exit with success, connect to yes state
                  Adj(current_state, yes) = 1;
               else
                  % Connect to state below
                  Adj(current_state, i*nr_cols + j) = 1;
               endif
         endif

         % Check if can go right (1=wall)
         if binary_value(3) == '0'
               % Check if at rightmost column
               if j == nr_cols
                  % Exit with insuccess, connect to no state
                  Adj(current_state, no) = 1;
               else
                  % Connect to state to the right
                  Adj(current_state, (i-1)*nr_cols + j + 1) = 1;
               endif
         endif

         % Check if can go left (1=wall)
         if binary_value(4) == '0'
               % Check if at leftmost column
               if j == 1
                  % Exit with insuccess, connect to no state
                  Adj(current_state, no) = 1;
               else
                  % Connect to state to the left
                  Adj(current_state, (i-1)*nr_cols + j - 1) = 1;
               endif
         endif
      endfor
   endfor

   % Connect yes state to itself
   Adj(yes,yes) = 1;

   % Connect no state to itself
   Adj(no,no) = 1;

   endfunction

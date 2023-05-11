function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  % InitialMatrix -> the matrix that must be transformed

  % FeatureMatrix -> the matrix with all training examples
  
  % Define a lookup table for transforming values
  lookup_table = containers.Map(
    {'yes', 'no', 'semi-furnished', 'unfurnished', 'furnished'},
    {1, 0, [1, 0], [0, 1], [0, 0]});

  % Initialize FeatureMatrix with size m x (n+1)
  [m, n] = size(InitialMatrix);
  FeatureMatrix = zeros(m, n+1);
  
for i = 1:m
    for j = 1:n
        value = InitialMatrix{i,j};
        if lookup_table.isKey(value)
                FeatureMatrix(i,[j, j + 1]) = lookup_table(value);
            else
                FeatureMatrix(i,j) = value;
        endif
    endfor
endfor



endfunction

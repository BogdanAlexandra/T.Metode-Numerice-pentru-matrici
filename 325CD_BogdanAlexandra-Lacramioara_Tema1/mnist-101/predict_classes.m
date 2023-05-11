function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)
  % X -> the test examples for which the classes must be predicted
  % weights -> the trained weights (after optimization)
  % [input|hidden|output]_layer_size -> the sizes of the three layers
  
  % classes -> a vector with labels from 1 to 10 corresponding to
  %            the test examples given as parameter
  
  % TODO: predict_classes implementation
  
  m = size(X, 1);
  Theta1 = reshape(weights(1:hidden_layer_size * (input_layer_size + 1)),
                 hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(weights((1 + (hidden_layer_size * (input_layer_size + 1))):end),
                 output_layer_size, (hidden_layer_size + 1));
  
  % compute output for each input in X
   % Initialize input layer a1
    a1 = zeros(m, input_layer_size + 1);
    a1(:,1) = 1;

    % Set values for input layer a1
    for i = 1:m
      a1(i, 2:end) = X(i, :);
    endfor

    % Compute hidden layer a2 and its values using sigmoid activation function
    z2 = a1 * Theta1';
    a2 = zeros(size(z2, 1), hidden_layer_size + 1);
    a2(:,1) = 1;
    for i = 1:size(z2, 1)
        a2(i, 2:end) = sigmoid(z2(i, :));
    endfor

    % Compute output layer a3 and its values using sigmoid activation function
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);
  probabilities = a3';
  classes = zeros(size(probabilities, 2), 1);
  
  for i = 1:size(probabilities, 2)
  [~, max_index] = max(probabilities(:, i));
  classes(i) = max_index;
endfor

endfunction

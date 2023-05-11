function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)

  % params -> vector containing the weights from the two matrices
  %           Theta1 and Theta2 in an unrolled form (as a column vector)
  % X -> the feature matrix containing the training examples
  % y -> a vector containing the labels (from 1 to 10) for each
  %      training example
  % lambda -> the regularization constant/parameter
  % [input|hidden|output]_layer_size -> the sizes of the three layers
  
  % J -> the cost function for the current parameters
  % grad -> a column vector with the same length as params
  % These will be used for optimization using fmincg
  
  % TODO: cost_function implementation
   
  % TODO1: get Theta1 and Theta2 (from params). Hint: reshape

    % Reshape the params vector into matrices Theta1 and Theta2
    Theta1 = reshape(params(1:hidden_layer_size * (input_layer_size + 1)),
                 hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(params((1 + (hidden_layer_size * (input_layer_size + 1))):end),
                 output_layer_size, (hidden_layer_size + 1));

    % Get the number of training examples
    m = size(X,1);

    % Initialize cost function J and gradient vectors
    J = 0;
    Theta1_grad = zeros(size(Theta1));
    Theta2_grad = zeros(size(Theta2));

    % Convert the labels y into binary vectors Y
    Y = zeros(m, output_layer_size);
    for i = 1:m
       Y(i, y(i)) = 1;
    endfor
    
  % TODO2: Forward propagation

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
    h = a3;

    % Compute the regularization term p
    p = 0;
    for j = 1:size(Theta1, 2)
        if j > 1
            p = p + sum(Theta1(:, j) .^ 2);
        endif
    endfor

    for j = 1:size(Theta2, 2)
        if j > 1
           p = p + sum(Theta2(:, j) .^ 2);
        endif
    endfor

  
  % TODO3: Compute the error in the output layer and perform backpropagation

    % Compute the error in the output layer delta3
    delta3 = a3.-Y;

    % Compute the error in the hidden layer delta2
    delta2 = (delta3*Theta2(:,2:end)).*sigmoidGradient(z2);

    Delta1 = (delta2'*a1);
    Delta2 = (delta3'*a2);

    Theta1_reg = Theta1; 
    Theta1_reg(:,1) = 0;
    Theta2_reg = Theta2; 
    Theta2_reg(:,1) = 0;
    p1 = (lambda/m) * Theta1_reg;
    p2 = (lambda/m) * Theta2_reg;

  
  % TODO4: Determine the gradients

    Theta1_grad = Delta1 / m + p1;
    Theta2_grad = Delta2 / m + p2;
  
  % TODO5: Final J and grad
    J = (-1/m) * sum(sum(Y .* log(h) + (1 - Y) .* log(1 - h))) + (lambda/(2*m)) * (sum(sum(Theta1(:, 2:end) .^ 2)) + sum(sum(Theta2(:, 2:end) .^ 2)));
    grad = [Theta1_grad(:) ; Theta2_grad(:)];
endfunction

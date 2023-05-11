function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  % X -> the loaded dataset with all training examples
  % y -> the corresponding labels
  % percent -> fraction of training examples to be put in training dataset
  
  % X_[train|test] -> the datasets for training and test respectively
  % y_[train|test] -> the corresponding labels
  
  % Example: [X, y] has 1000 training examples with labels and percent = 0.85
  %           -> X_train will have 850 examples
  %           -> X_test will have the other 150 examples

  % shuffle the dataset
  m = size(X, 1);
  shuffled_indices = randperm(m);
  X = X(shuffled_indices, :);
  y = y(shuffled_indices);
  
  % split the dataset into training and test sets
  train_size = floor(percent * m);
  X_train = X(1:train_size, :);
  y_train = y(1:train_size);
  X_test = X(train_size+1:end, :);
  y_test = y(train_size+1:end);
end

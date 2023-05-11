Homework 1 - Numerical Methods 

Student: Bogdan Alexandra - Lăcrămioara
Group: 325CD

Impressions 
---------------------------

* I believe that the assignment was helpful in understanding the importance of using some algorithms and how they can be applied in practical, everyday life situations. I particularly enjoyed task 3 because I could see firsthand how these concepts can be used in the real world. Additionally, I appreciated the fact that the assignment was well-structured and had clear instructions for each task. 

* Difficulty: medium

* The issues I faced while solving this assignment were timeouts, especially at task 1.

Task 1. Markov is coming...
---------------------------

> parse_labyrinth

    *  The parse_labyrinth function reads a labyrinth matrix from a file specified by file_path. It reads the matrix dimensions from the first line, removes newline characters, and stores each line as a row in the Labyrinth matrix. The function returns the resulting matrix.

> get_adjacency_matrix

    * The get_adjacency_matrix function takes a Labyrinth matrix and returns an adjacency matrix Adj. It initializes Adj as a sparse matrix and calculates the total number of states. Then, for each cell in the Labyrinth, it determines if there is a path up, down, left, or right, and creates edges in the Adj matrix accordingly. If there is no path in a certain direction, it creates edges to either a WIN or LOSE state. Finally, self-loops are created on the WIN and LOSE states.

> get_link_matrix 

    * The get_link_matrix function takes in a matrix Labyrinth and returns a link matrix Link. It first calculates the number of rows and columns in the labyrinth and the total number of states. It initializes the Link matrix with sparse zeros and sets indices for yes and no states. It then loops through each position in the labyrinth and calculates the current state index. For each position, it determines the number of valid directions to move and updates the Link matrix based on those directions. If a direction is valid, it creates an edge in the Link matrix from the current state to the new state corresponding to the adjacent cell in the labyrinth. If a direction is not valid, it creates an edge to either the WIN state or LOSE state. Finally, it creates self-loops on the yes and no states in the Link matrix.

> get_Jacobi_parameters

    *  The get_Jacobi_parameters function creates two sparse matrices, G and c, from the input link matrix. The dimensions of G are (m-2) x (n-2), where m and n are the number of rows and columns in the input matrix Link. The dimensions of c are (n-2) x 1. The -2 is used to exclude the last two rows and columns of the input matrix which correspond to the terminating states (WIN and LOSE) that are not included in the iteration process. Then, the function loops through each element in G and assigns it the corresponding probability value from Link. The loop iterates through rows 1 to m-2 and columns 1 to n-2.Similarly, the function loops through each element in c and assigns it the corresponding probability value from Link. The loop iterates through columns 1 to n-2. Finally, the function returns the two output matrices, G and c. 

> perform_iterative

    *  The initial solution x is set to the input x0. The difference err is initialized to a large value tol + 1.
    The number of iterations performed steps is set to 0. The function performs iterations until the difference err is less than the tolerance tol or the maximum number of iterations max_steps is reached. Within each iteration, the previous solution x_prev is saved to compute the difference, the new solution x is computed using the iteration formula G * x + c, the difference err between the previous and the new solution is computed using the Euclidean norm, and the number of iterations performed steps is incremented. The function returns the final solution x, the last computed difference err, and the actual number of iterations performed steps.

> heuristic_greedy

    *  The heuristic_greedy function implements a greedy algorithm to find the shortest path to a WIN state in a labyrinth represented by an adjacency matrix. The algorithm starts at the given start_position and selects the unvisited neighbor with the highest probability of reaching the WIN state. The visited neighbors are marked to avoid cycles, and the algorithm continues until it reaches the WIN state or there are no more unvisited neighbors. The function returns the path to the WIN state as a vector of states. If there is no path to the WIN state, the function returns an empty path. Finally, the function prints the path with a newline after every state value.


> decode_path 

    * The implementation of the function involves iterating through the path vector and calculating the row and column indices of each state using the given number of lines and cols. The WIN state is skipped, and the pairs of indices are stored in the decoded_path vector.


Task 2. Linear Regression
-------------------------

> parse_data_set_file

    * This function reads data from a file containing a matrix with specified dimensions and a label for each row. It initializes a cell array with the same dimensions as the matrix and reads the data from the file into it. NaN values in the file are replaced with an empty string in the cell array. The function returns both the cell array and a vector of labels.

> prepare_for_regression

    *  The function first initializes a lookup table that maps 'yes', 'no', 'semi-furnished', 'unfurnished', 'furnished' to the numerical values presented in the theoretical brief. I chose this storage method to optimize the algorithm. It then initializes FeatureMatrix as a matrix with size m x (n+1), where m and n are the number of rows and columns in InitialMatrix, respectively. The function then loops through each element in InitialMatrix and checks if its value exists in the lookup table. If it does, the corresponding numerical value is added to FeatureMatrix in the current and next column. If it does not exist in the lookup table, the original value is added to FeatureMatrix in the current column. The resulting FeatureMatrix contains all the training examples with numerical values suitable for regression analysis.



Task 3. MNIST 101
-----------------

> load_dataset 

    *  The function load_dataset loads a dataset from a .mat file located at a relative path provided as the input parameter. The function returns the training examples as X and their corresponding labels as y. The implementation of the function first loads the data from the provided path using the load function. Then, it extracts the training examples and their labels from the loaded data and assigns them to X and y, respectively. Finally, the function returns X and y.

> split_dataset

    *  Firstly, the function shuffles the dataset to avoid any biases. It generates a random permutation of the indices of the dataset and rearranges both X and y based on these indices. Next, the function computes the size of the training dataset by multiplying percent with the number of examples in X and rounding down to the nearest integer using the floor function. It then creates the training and test datasets by selecting the first train_size examples in the shuffled X and y arrays as X_train and y_train, respectively. The remaining examples are used to create X_test and y_test. Lastly, the function returns the four variables X_train, y_train, X_test, and y_test.

> initialize_weights

    * So, first I figured out the value of epsilon using the theory we were given for this topic. Then, the next thing I did was to randomly generate weights within the range of (-epsilon, epsilon).

> cost_function

    * The first step of the implementation is to reshape the weights vector into the matrices Theta1 and Theta2. Then, the implementation converts the labels y into binary vectors Y using a loop. The forward propagation step starts by reshaping the input parameter vector params into the two weight matrices Theta1 and Theta2, which correspond to the weights between the input and hidden layers and the weights between the hidden and output layers, respectively. Next, the input matrix X is passed through the network to compute the output h. The input layer a1 is initialized with a bias unit and the input features X, and then the hidden layer a2 is computed by applying the sigmoid activation function to the product of a1 and Theta1. Another bias unit is added to a2, and the output layer a3 is computed by applying the sigmoid activation function to the product of a2 and Theta2. Finally, h is set to the output of the output layer a3. The backpropagation step starts by computing the error in the output layer delta3, which is the difference between the predicted output h and the true labels Y. The error in the hidden layer delta2 is then computed by multiplying delta3 with Theta2 and applying the sigmoid gradient function to the result. The gradients for the two weight matrices Theta1 and Theta2 are then computed by multiplying the corresponding errors with their respective activation matrices, adding the regularization term, and dividing by the number of training examples m. Finally, the cost function J is computed by summing the cross-entropy loss between the predicted output h and the true labels Y, and the regularization term. The column vector grad is then computed by unrolling the gradients for Theta1 and Theta2 into a single vector.

> predict_classes

    * This function takes as input the test examples X, the weights, and the sizes of the input, hidden, and output layers. The output is a vector of labels from 1 to 10 corresponding to the test examples given as a parameter. To predict the classes, the function first extracts the trained weights for the input and output layers. It then performs forward propagation by computing the output for each input in X. The forward propagation steps are explained in more detail in the function cost_function. Finally, the function selects the class with the highest probability for each input and returns the corresponding vector of labels.



Bibliography
-----------------
 * https://www.mathworks.com/help/matlab/ref/norm.html
 * https://www.hepeng.me/how-to-implement-a-neural-network-in-octave-and-what-is-back-propagation/
 * https://towardsdatascience.com/forward-propagation-in-neural-networks-simplified-math-and-code-version-bbcfef6f9250
 * https://github.com/trekhleb/machine-learning-octave/tree/master/neural-network
 * https://medium.com/@samuellynnevans/a-simple-vectorised-neural-network-in-octave-in-11-lines-of-code-b17ed9894f48

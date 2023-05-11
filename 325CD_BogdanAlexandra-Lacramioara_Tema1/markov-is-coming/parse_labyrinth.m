function [Labyrinth] = parse_labyrinth(file_path)
    % file_path -> the relative path to a file that needs to
    %              be loaded_graphics_toolkits

    % Labyrinth -> the matrix of all encodings for the labyrinth's walls

    % Labyrinth -> the matrix of all encodings for the labyrinth's walls

% TODO: parse_labyrinth implementation

fid = fopen(file_path);
if fid == -1
        error('Failed to open the file.');
endif

dims = fscanf(fid, "%d", 2);  % Read the dimensions
n = dims(1);
m = dims(2);

A = fscanf(fid, "%c", Inf);   % Read the matrix as a character array
fclose(fid);
A = strtrim(A(:, 2:end)); % Remove first and last columns, which are newline character

lines_from_A = strsplit(A, "\n"); % split the string into lines
Labyrinth = zeros(n, m);

for i = 1:n
    line = lines_from_A{i};
    line_data = sscanf(line, "%d");
    Labyrinth(i,:) = line_data;
endfor

% Check if the last element of Labyrinth is a linefeed character
if Labyrinth(end) == 10
    Labyrinth(end) = []; % Remove the last element
endif

endfunction

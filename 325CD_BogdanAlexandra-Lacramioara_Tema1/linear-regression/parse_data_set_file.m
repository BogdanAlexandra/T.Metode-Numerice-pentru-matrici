function [Y, InitialMatrix] = parse_data_set_file(file_path)

    % Open the file for reading
    fid = fopen(file_path, 'r');
    if fid == -1
        error('Failed to open the file.');
    endif
    
    % Read the first line with the matrix dimensions
    matrix_size = fscanf(fid, '%d', 2);
    m = matrix_size(1);
    n = matrix_size(2);
    
    % Read the rest of the file into a cell array
    file_data = textscan(fid, '%s', 'Delimiter', '\n');
    file_data = file_data{1};
    
    % Initialize InitialMatrix as a cell with size m x n
    InitialMatrix = cell(m, n);
    Y = zeros(m, 1);
    for i = 1:m
        data = strsplit(file_data{i}, ' ');
        Y(i) = str2double(data{1});
        for j = 2:n+1
            value = str2double(data{j});
            if isnan(value)
                value = data{j};
            endif
         InitialMatrix{i, j-1} = value;
        endfor
    endfor

    % Close the file
    fclose(fid);
endfunction

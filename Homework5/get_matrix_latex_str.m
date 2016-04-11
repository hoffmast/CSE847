function  [ mat_str ] = get_matrix_latex_str( mat, fmt, transpose )
%print_matrix_latex Prints the matrix in a format for latex
%   Returns a string for printing the provided matrix into latex.
%   If transpose is true, the function will transpose the matrix and add
%   the transpose tick mark (') at the end of the matrix string. Default
%   value for transpose is false. This function can work on 2d matrices and
%   on vectors only. The fmt parameter is input into num2str to format each
%   number. The default is the empty string.

%% Set default input parameters
if nargin < 2
    fmt = '';
end

if nargin < 3
    transpose = false;
end

if transpose
    mat = mat';
end

%% Began saving matrix into string form
mat_str = '\begin{bmatrix}';
for r = 1:(size(mat,1)-1)
    for c = 1:(size(mat,2)-1)
        
        mat_str = [mat_str num2str(mat(r,c),fmt) ' & '];
    end
    mat_str = [mat_str num2str(mat(r,end),fmt) '\\'];
end

% Get last row of matrix
for c = 1:(size(mat,2)-1)
    mat_str = [mat_str num2str(mat(end,c),fmt) ' & '];
end
mat_str = [mat_str num2str(mat(end,end),fmt) '\end{bmatrix}'];

% Add transpose tick if desired
if transpose
    mat_str = [mat_str ''''];
end

end


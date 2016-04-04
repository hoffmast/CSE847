function [ w_opt ] = ridge_regression( X, t, lambda )
%ridge_regression This function returns the optimal w weights vector based on an
% implementation of the ridge regression optimization function: min {1/2
% ||Xw-y||^2_2 + \lambda/2||w||^2_2
%
%   X = data matrix. # of rows = N = # of data samples. # of cols = M = #
%   of features
%   t = target values vector
%   lambda = regularization term

%% Find optimal w
N = size(X,1);
M = size(X,2);

% Perform SVD
[U, S, V] = svd(X);

% Obtain optimal w
w_opt = zeros(1,M);
if size(t,2) == 1
    w_opt = zeros(M,1);
end
for i = 1:M
    sigma_i = S(i,i);
    u_i = U(:,i);
    v_i = V(:,i);
    w_opt = w_opt + ((sigma_i * u_i' * t)/(sigma_i^2 + lambda))* v_i;
end



end


function [ MSE ] = compute_mean_squared_error( w_opt, X, y )
%compute_training_error 
%   This function computes the mean squared error given the data in X, the
%   target values in y and the optimal weights in w_opt.

% Estimate the target values based on given w
y_est = X * w_opt;
N = size(X,1);

MSE = 0;
for i = 1:N
    MSE = MSE + (y(i) - y_est(i))^2;
end
MSE = MSE / N;


end


function [ lambda_opt ] = k_fold_cross_validation( X, y, Lambda, k )
%k_fold_cross_validation 
%   Performs K-fold cross-validation on the given data and returns the
%   optimal lambda

% Find the cross-validation error for each lambda
cv_errors = zeros(1,numel(Lambda));
for i = 1:numel(Lambda)
    cv_errors(i) = compute_cross_validation_error_lambda(X, y, Lambda(i), k);
end

% Find the optimal lambda as the lambda giving minimum cross validation
% error
[min_error, idx] = min(cv_errors);
lambda_opt = Lambda(idx);

end


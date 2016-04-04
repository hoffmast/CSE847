function [ cv_error_overall ] = compute_cross_validation_error_lambda( X, y, lambda, k  )
%compute_cross_validation_error_lambda 
%   Returns the overall cross-validation error from the given lambda

%% Compute the cross-validation error for each of the k-folds
cv_errors = zeros(1,k);
size_of_fold = ceil(size(X,1) / k);
for i = 1:k
   
    % Partition data into the data in the ith fold and the data not in ith fold
    D_k_begin = ((i-1)*size_of_fold + 1);
    D_k_end = min(i*size_of_fold,size(X,1));
    D_k = X(D_k_begin:D_k_end,:);
    D_minus_k = [X(1:D_k_begin-1,:) ; X(D_k_end+1:end,:)];
    y_k = y(D_k_begin:D_k_end);
    y_minus_k = [y(1:D_k_begin-1) ; y(D_k_end+1:end)];
    
    % Perform ridge regression and calculate cross-validation error for the
    % kth fold, using D_minus_k as training data and D_k as training data
    w_opt = ridge_regression( D_minus_k, y_minus_k, lambda );
    cv_errors(i) = compute_mean_squared_error( w_opt, D_k, y_k );
end

% Compute the overall cross-validation error
cv_error_overall = sum(cv_errors) / k;

end


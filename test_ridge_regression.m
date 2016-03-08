
%%
% This script tests the ridge_regression implementation for the last
% homework problem.
%

%% Test the Ridge Regression on various lambdas (Problem 3.2 on homework)

% Load data
load('diabetes.mat');

% Compute the MSE for each lambda value on training and testing data
Lambda = [1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1, 10];
ntests = numel(Lambda);
training_error = zeros(ntests,1);
testing_error = zeros(ntests,1);
for i = 1:ntests
    w_opt = ridge_regression(x_train, y_train, Lambda(i));
    training_error(i) = compute_mean_squared_error(w_opt, x_train, y_train);
    testing_error(i) = compute_mean_squared_error(w_opt, x_test, y_test);
end

%% Test the cross-validation, having it choose the optimal lambda (Problem 3.3 on homework)
k = 5;
lambda_opt = k_fold_cross_validation( x_train, y_train, Lambda, k );

% Plot results on graph
figure;
error_min = min([training_error ; testing_error]);
error_max = max([training_error ; testing_error]);
semilogx(Lambda, training_error,'xb');
hold on;
semilogx(Lambda, testing_error,'og');
semilogx(lambda_opt*[1,1], [error_min, error_max], '-r');
legend('training error', 'testing error',[num2str(k) '-fold cross-validation optimal lambda']);
xlabel('\lambda values');
ylabel('mean squared error (MSE)');

% Print out table
for i = 1:numel(Lambda)
    fprintf('%.2e & %.2e & %.2e \\\\\n', Lambda(i), training_error(i), testing_error(i));
end



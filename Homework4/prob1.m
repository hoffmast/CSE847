%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob1.m
%
% This program attempts to complete Problem 1, "Logistic Regression:
% Experiment" of Homework #4 for CSE 847, Spring 2016, MSU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Setup parameters
data_file = fullfile('..','spam_email','data.txt');
labels_file = fullfile('..','spam_email','labels.txt');
data = load(data_file);
data = [data , ones(size(data,1),1)]; % <-- Add bias
labels = load(labels_file);
training_data_sizes = [200, 500, 800, 1000, 1500, 2000]';
accuracy = zeros(size(training_data_sizes));
aucs = zeros(size(training_data_sizes));
w = zeros(numel(training_data_sizes), size(data,2));
p = zeros(numel(training_data_sizes), (4601-2000));

%% Train the logistic regressor on different training data sizes & get accuracies
data_test = data(2001:4601,:);
labels_test = labels(2001:4601);
for i = 1:numel(training_data_sizes)
    
    % Train the logistic regressor
    n = training_data_sizes(i);
    data_train = data(1:n,:);
    labels_train = labels(1:n);
    weights = logistic_train(data_train, labels_train);
%     weights = glmfit(data_train(:,1:end-1),labels_train,'binomial');
    w(i,:) = weights;
    
    % Compute the predicted values and the testing accuracy
    predictions = sigmf(data_test * weights,[1 0]);
    p(i,:) = predictions;
    accuracy(i) = get_testing_accuracy(labels_test, predictions);
    [~,~,~,auc] = perfcurve(labels_test, predictions,1);
    aucs(i) = auc;
    
%     CP = classperf(labels_test,round(predictions));
%     accuracy(i) = CP.CorrectRate;
end

%% Plot the results
figure;
plot(training_data_sizes, accuracy, 'o-');
title('Problem 1: Logistic Regression');
xlabel('n (training data size)');
ylabel('Testing Accuracy');

figure;
plot(training_data_sizes, aucs, 'o-');
title('Problem 1: Logistic Regression');
xlabel('n (training data size)');
ylabel('AUC');
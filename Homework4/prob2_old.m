%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob2_old.m
%
% This program attempts to complete Problem 2, "Sparse Logistic Regression:
% Experiment" of Homework #4 for CSE 847, Spring 2016, MSU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Add SLEP files to path
addpath(fullfile('..','SLEP','SLEP','functions','L1','L1R'));
addpath(fullfile('..','SLEP','SLEP','functions'));
addpath(fullfile('..','SLEP','SLEP','opts'));
addpath(fullfile('..','SLEP','SLEP','CFiles'));
addpath(fullfile('..','SLEP','SLEP'));
addpath(fullfile('..','SLEP'));


%% Setup parameters
data_file = fullfile('..','spam_email','data.txt');
labels_file = fullfile('..','spam_email','labels.txt');
data = load(data_file);
labels = load(labels_file);
data_train = data(1:50,:);
labels_train = labels(1:50);
data_test = data(2001:4601,:);
labels_test = labels(2001:4601);
par = [0.01, 0.02, 0.05, 0.1, 0.2];
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.1;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.01;
par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.0001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.00001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.000001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.0000001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.000000001;
neg_one = false;

w = zeros(numel(par),size(data,2));
b = zeros(numel(par),1);
p = zeros(numel(par), (4601-2000));

%% Adjust the training set

% Get all positive and negative samples
pos_idx = find(labels(1:2000) == 1);
neg_idx = find(labels(1:2000) == 0);
num_class_samples = 500;

% Obtain 25 pos and 25 neg samples, with labels
data_train = zeros(num_class_samples*2,size(data,2));
labels_train = zeros(num_class_samples*2,1);
for i = 1:num_class_samples
    data_train(i,:) = data(pos_idx(i),:);
    labels_train(i) = 1;
    data_train(num_class_samples*2 - i + 1,:) = data(neg_idx(i),:);
end

% Shuffle data points for better distribution
idx = randperm(num_class_samples*2);
data_train = data_train(idx,:);
labels_train = labels_train(idx);

%% Adjust the labels
neg_idx = find(labels_train == 0);
labels_train(neg_idx) = -1;
neg_idx = find(labels_test == 0);
labels_test(neg_idx) = -1;
neg_one = true;


%% Train logistic regressor on values for the L1 regularization and get accuracies
accuracy = zeros(size(par));
num_feats = zeros(size(par));
num_feats_plus_bias = zeros(size(par));
for i = 1:numel(par)
    
    % Train the logistic regressor
    [weights, bias] = logistic_l1_train(data_train, labels_train, par(i));
    w(i,:) = weights;
    b(i) = bias;
    
    % Count the number of nonzero features
    num_feats(i) = sum(weights ~= 0);
    num_feats_plus_bias(i) = num_feats(i) + (bias ~= 0);
    
    % Compute the predicted values and the testing accuracy
    predictions = sigmf((data_test * weights) + bias,[1 0]);
%     predictions = sigmf((data_test * weights),[1 0]);
    p(i,:) = predictions;
    accuracy(i) = get_testing_accuracy(labels_test, predictions, true, neg_one);
end

%% Plot the results
figure;
plot(par, accuracy, 'o-');
title('Problem 2: Sparse Logistic Regression');
xlabel('l_1 regularization parameter');
ylabel('Testing Accuracy');

figure;
plot(par, num_feats, 'o-');
title('Problem 2: Sparse Logistic Regression');
xlabel('l_1 regularization parameter');
ylabel('Number of Features');

figure;
plot(par, num_feats_plus_bias, 'o-');
title('Problem 2: Sparse Logistic Regression');
xlabel('l_1 regularization parameter');
ylabel('Number of Features (plus bias)');
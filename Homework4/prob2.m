%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob2.m
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

% Get the data and labels
data_file = fullfile('..','alzheimers','ad_data.mat');
data = load(data_file);
data_train = data.X_train;
data_test = data.X_test;
label_train = data.y_train;
label_test = data.y_test;
clear data;

% Setup other parameters
par  = [0, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
par  = [0, 0.0001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
w = zeros(numel(par),size(data_train,2)); % all weights
b = zeros(numel(par),1); % all biases
p = zeros(numel(par), size(data_test,1)); % all predictions
fars = zeros(numel(par), numel(label_test)+1);
gars = zeros(numel(par), numel(label_test)+1);

% par = [0.01, 0.02, 0.05, 0.1, 0.2];
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.1;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.01;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.0001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.00001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.000001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.0000001;
% par = [0.01, 0.02, 0.05, 0.1, 0.2]*0.000000001;

%% Train logistic regressor on values for the L1 regularization and get accuracies
accuracy = zeros(size(par));
aucs = zeros(size(par));
num_feats = zeros(size(par));
num_feats_plus_bias = zeros(size(par));
for i = 1:numel(par)
    
    % Train the logistic regressor
    [weights, bias] = logistic_l1_train(data_train, label_train, par(i));
    w(i,:) = weights;
    b(i) = bias;
    
    % Count the number of nonzero features
    num_feats(i) = sum(weights ~= 0);
    num_feats_plus_bias(i) = num_feats(i) + (bias ~= 0);
    
    % Compute the predicted values
%     predictions = sigmf((data_test * weights) + bias,[1 0]);
    predictions = (data_test * weights) + bias;
%     predictions = sigmf((data_test * weights),[1 0]);
    p(i,:) = predictions;
    
    % Compute the accuracy and AUC
%     cp = classperf(label_test,class_choice_pn1(predictions));
    cp = classperf(label_test >= 0,predictions >=0);
    accuracy(i) = cp.CorrectRate;
    [far,gar,thres,auc] = perfcurve(label_test, predictions,1);
%     [~,~,~,auc] = perfcurve(label_test, predictions/max(abs(predictions)),1);
%     [~,~,~,auc] = perfcurve(label_test, class_choice_pn1(predictions),1);
%     [~,~,~,auc] = perfcurve(label_test, double(predictions >= 0),1);
%     [~,~,~,auc] = perfcurve(label_test, sigmf(predictions,[1,0]),1);
    aucs(i) = auc;
    if numel(far) == size(fars,2)
       fars(i,:) = far;
       gars(i,:) = gar;
    end
end

%% Plot the results
figure;
plot(par, accuracy, 'o-');
title('Problem 2: Sparse Logistic Regression');
xlabel('l_1 regularization parameter');
ylabel('Testing Accuracy');

figure;
plot(par, aucs, 'o-');
title('Problem 2: Sparse Logistic Regression');
xlabel('l_1 regularization parameter');
ylabel('Area Under Curve (AUC)');

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

% Plot ROC curves
figure;
legend_labs = cell(1,size(fars,1));
j = 1;
i = 1;
while j <= 4 && i <= size(fars,1)
   
    plot(fars(i,:),gars(i,:),'-o');
    legend_labs{i} = ['Par = ' num2str(par(i))];
    hold on;
    i = i + 1;
    j = j + 1;
end
j = 1;
while j <= 4 && i <= size(fars,1)
   
    plot(fars(i,:),gars(i,:),'-x');
    legend_labs{i} = ['Par = ' num2str(par(i))];
    hold on;
    i = i + 1;
    j = j + 1;
end
j = 1;
while j <= 4 && i <= size(fars,1)
   
    plot(fars(i,:),gars(i,:),'-v');
    legend_labs{i} = ['Par = ' num2str(par(i))];
    hold on;
    i = i + 1;
    j = j + 1;
end
j = 1;
while j <= 4 && i <= size(fars,1)
   
    plot(fars(i,:),gars(i,:),'-^');
    legend_labs{i} = ['Par = ' num2str(par(i))];
    hold on;
    i = i + 1;
    j = j + 1;
end
title('ROCs for various regularization terms');
xlabel('False Accept Rates (FARs)');
ylabel('Genuine Accept Rates (GARs)');
legend(legend_labs);
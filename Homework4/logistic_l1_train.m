%% Code provided by Dr. Jhou, slightly modified to add the path to SLEP
function [w, c] = logistic_l1_train(data, labels, par)
% OUTPUT w is equivalent to the first d dimension of weights in logistic train
%        c is the bias term, equivalent to the last dimension in weights in logistic train.

% Add path to SLEP
% addpath(fullfile('..','..','SLEP','SLEP','functions','L1','L1R'));
% addpath(fullfile('..','..','SLEP','SLEP'));
% addpath(fullfile('..','..','SLEP'));
% run(fullfile(fileparts(mfilename('fullpath')), ...
%     '..','..','SLEP','mexC.m'));

% Specify the options (use without modification).
opts.rFlag = 1; % range of par within [0, 1].
opts.tol = 1e-6; % optimization precision
opts.tFlag = 4; % termination options.
opts.maxIter = 5000; % maximum iterations.
% opts = [];
[w, c] = LogisticR(data, labels, par, opts);

end
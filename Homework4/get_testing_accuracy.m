function [ acc ] = get_testing_accuracy( labels, predictions, to_round, neg_one )
% get_testing_accuracy Returns the testing accuracy on the given predictions
%   Returns the testing accuracy on the given predictions. If to_round is
%   true, it changes each prediction to the class label it would assign the
%   data to (i.e. rounds to 1 or 0), giving the classification accuracy. It
%   does not round if to_round is false. The default is true;
%   If neg_one is true, then labels should be +1/-1. If neg_one is false
%   (default), then the labels should be +1/0.

% Set defaults
if nargin == 2
    to_round = true;
end
if nargin < 4
    neg_one = false;
end

% Find accuracy
if ~neg_one
    
    % Labels 1/0
    if to_round
        predictions = round(predictions);
    end

    acc = 1 - mean(abs(labels - predictions));
else
   
    % Labels +1/-1
    pos_idx = find(predictions >= 0);
    neg_idx = find(predictions < 0);
    predictions(pos_idx) = 1;
    predictions(neg_idx) = -1;
    acc = sum(predictions == labels) / numel(labels);        
    
end

end


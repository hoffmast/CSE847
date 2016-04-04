function [ class_out ] = class_choice_pn1( predictions )
%class_choice_pn1 Returns the class choice from each prediction.
%   Returns the class choice from each prediction when positive class is
%   +1, negative class is -1, and predictions are in the range [-1,1].

class_out = (predictions >= 0) + ((predictions < 0) * -1);


end


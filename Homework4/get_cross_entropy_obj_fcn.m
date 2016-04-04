function [ err ] = get_cross_entropy_obj_fcn( labels, predictions )
%get_cross_entropy_obj_fcn Returns the cross-entropy error (NLL)

err = sum(labels .* log(predictions) + (1 - labels) .* log(1 - predictions));


end


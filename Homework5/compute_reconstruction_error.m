function [ err ] = compute_reconstruction_error( orig, recon )
%compute_reconstruction_error This function returns the reconstruction err
%   This assumes that orig and recon are both n x m matrices where n = the
%   number of data points and m = the number of features in each data
%   point. This method produces the reconstruction error between each data
%   point and its reconstruction, returning a n x 1 vector of errors.

n = size(orig,1);
diff = orig - recon;
err = zeros(n,1);
for i = 1:n
   
    err(i) = norm(diff(i,:),'fro')^2;
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob2_2.m
%
% This program attempts to complete Problem 2 from section 2, of 
% Homework #5 for CSE 847, Spring 2016, MSU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

% Load the Data
load('USPS.mat');

% Apply PCA on the data to get the principle components
[princ_comp, data_coeff] = pca(A);

% Plot the data into 3 dimensions to view PCA results
data_3d = A * princ_comp(:,1:3);
figure;
hold on;
for j = 1:10
    
    area = (1 + 300 * (j - 1)):(300 * j);
    switch j
        case 1 % digit = 0
            marker = '+';
        case 2 % digit = 1
            marker = 'o';            
        case 3
            marker = '*';
        case 4 
            marker = '.';
        case 5
            marker = 'x';
        case 6 
            marker = 's';
        case 7
            marker = 'd';
        case 8
            marker = '^';
        case 9
            marker = 'v';
        otherwise
            marker = 'h';
    end
    
    plot3(data_3d(area,1), data_3d(area,2), data_3d(area,3), marker);
end
legend('0','1','2','3','4','5','6','7','8','9');

% Create the image reconstructions for various numbers p of principle
% components
figure;
p_vals = [256, 200, 100, 50, 10];
recons_errs = zeros(numel(p_vals),1);
for i = 1:numel(p_vals)
   
    p = p_vals(i);
    
    % Reconstruct the images
    pca_imgs = data_coeff(:,1:p) * princ_comp(:,1:p)';
    mean_img = mean(A,1);
    for j = 1:size(A,1)
        pca_imgs(j,:) = pca_imgs(j,:) + mean_img;
    end
    
    % Get the reconstruction errors for each image
    errs = compute_reconstruction_error(A,pca_imgs);
    
    % Reshape the images
    img1 = reshape(pca_imgs(1,:), 16, 16);
    img2 = reshape(pca_imgs(2,:), 16, 16);
    
    % Plot the reconstructed images
    prec = 3;
    subplot(2,numel(p_vals),i);
    imshow(img1,[]);
    title(['p = ' num2str(p)]);
    xlabel(['err = ' num2str(errs(1),prec)]);
    if i == 1
        ylabel('Image 1');
    end
    subplot(2,numel(p_vals),i+numel(p_vals));
    imshow(img2,[]);
    title(['p = ' num2str(p)]);
    xlabel(['err = ' num2str(errs(2),prec)]);
    if i == 1
        ylabel('Image 2');
    end
    
    % Save the reconstruction errors
    recons_errs(i) = sum(errs);
end
avg_recons_errs = (recons_errs / size(A,1));

% Print the Reconstruction errors
fprintf('p &= %s \\\\\n', get_matrix_latex_str(p_vals,'%0.0f'));
fprintf('\\text{total reconstruction error} &= %s \\\\\n', get_matrix_latex_str(recons_errs','%0.3e'));
fprintf('\\text{average reconstruction error} &= %s \\\\\n', get_matrix_latex_str(avg_recons_errs','%0.3f'));

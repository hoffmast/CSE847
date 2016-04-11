%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob1_3.m
%
% This program attempts to complete Problem 3 from section 1, of 
% Homework #5 for CSE 847, Spring 2016, MSU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mu = [0, 0];
n = 1000;

i = 1;
figure;
for epsilon = 0.8:-0.1:0
   
    data = mvnrnd(mu, epsilon * eye(2), n);
    subplot(3,3,i);
    plot(data(:,1), data(:,2), 'bx');
    title(['\epsilon = ' num2str(epsilon)]);
    axis([-4 4 -4 4]);
    i = i + 1;
end
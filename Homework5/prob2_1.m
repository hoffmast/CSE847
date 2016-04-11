%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob2_1.m
%
% This program attempts to complete Problem 1 from section 2, of 
% Homework #5 for CSE 847, Spring 2016, MSU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get and plot the data
data = [0,0 ; -1,2 ; -3,6 ; 1,-2 ; 3,-6];
figure; 
plot(data(:,1), data(:,2), 'bo');
title('Section 2: Problem 1');
axis([-7 7 -7 7]);

% Plot the data with the principle component lines drawn
comp1x = [-20 20];
comp1y = -2 * comp1x;
comp2x = [-20 20];
comp2y = 0.5 * comp2x;
figure; 
plot(data(:,1), data(:,2), 'bo');
hold on;
plot(comp1x, comp1y, 'g-');
plot(comp2x, comp2y, 'r--');
title('Section 2: Problem 1');
legend('data points','1st P.C.', '2nd P.C.');
axis([-7 7 -7 7]);
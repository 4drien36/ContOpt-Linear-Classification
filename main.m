
clear;
close all;
clc;

% Load the data (both train and test sets, and value of n = 785)
load mnist_train_test.mat;

%%  Define the cost function f (question 7)

lambda = 5*10^(-3);
% The following is special about MATLAB syntax: fhandle is a handle for a
% function that takes one input (theta) and is equivalent to calling
% svm(train, theta, lambda). In this way the input 'train' is fixed once
% and for all.
fhandle = @(theta) svm(train, theta, lambda);

%% Check the gradient (question 8)

% Generate a random point and a random direction
theta = randn(d, 1);
v = randn(d, 1);
v = v/norm(v);

% Check the Taylor expansion for that point and that direction
checkgradient(fhandle, theta, v);

%% Lipschitz constant (question 9)

% Set the Lipschitz constant
L = max(svd(train.X))^2 + lambda;

%% Gradient descent with constant step sizes (question 10)

% Examples of parameters that your algorithm can take.
params.maxiters = 600;
params.maxtime = 180;
% Tolerance on the gradient norm. Stop the algorithm if the gradient norm
% has decreased by a factor of tolgradnorm (compared to the initial
% gradient norm).
params.tolgradnorm = 10^(-3);
params.verbose = false; % Whether or not the algorithm should print information when it is running

% Step size
alpha = 1/L;

% Initial point
theta0 = train.X(1:785,1);

[theta, gradnorms, times] =cstgradientdescent(fhandle, theta0, alpha, params);

%% Plot results (question 11)
figure;
x=1:size(gradnorms,2);
semilogy(x,gradnorms);
xlabel('Iteration number k');
ylabel('$\|\nabla f_\lambda(\theta_k)\|$', 'Interpreter','latex');
title('Gradient descent');

%% Gradient descent with backtracking linesearch (question 13)

% Parameters for the main loop
params.maxiters = 250;
params.maxtime = 180;
params.tolgradnorm = 10^(-10);
params.verbose = false;

% Examples of parameters for the linesearch
lsparams.alphabar = 7;
lsparams.c = 10^(-4);
lsparams.rho = 0.5;
lsparams.alphamin = 10^(-9);

% Initial point
theta0 = train.X(1:785,1);

% Run gradient descent with linesearch
[theta_ls, gradnorms_ls, times_ls]=lsgradientdescent(fhandle, theta0, params, lsparams);
x_ls=1:size(gradnorms_ls,2);

%plot backtraking line_search
figure;
semilogy(x_ls,gradnorms_ls);
xlabel('Number of iterations k');
ylabel('$\|\nabla f_\lambda(\theta_k)\|$', 'Interpreter','latex');
title('Backtraking line-search');

%% Gradient norm versus time (question 14)
% Plot results

%gradient norm vs time
figure;
times_ls_add=cumsum(times_ls);
times_add=cumsum(times);
semilogy(times_ls_add, gradnorms_ls, 'DisplayName', 'Backtracking');
hold on;
semilogy(times_add, gradnorms, 'DisplayName', 'Constant Step Size');
hold off;
xlabel('Time (s)');
ylabel('Gradient Norm');
title('Gradient Norm vs Time');
legend show;


%% Show image in a grayscale figure (question 15)

theta_sequence = theta_ls;
showMNISTImage(theta(1:785,end));
disp(theta_sequence(785,end))

%% Assess quality of the model (question 16)

theta = theta_ls(1:785,end);

% Evaluate quality of classifier vector theta
[accuracy_train, mistakes_train] = binary_classifier_accuracy(train, theta);
[accuracy_test, mistakes_test] = binary_classifier_accuracy(test, theta);

fprintf('Accuracy\n  Train: %.6g\n  Test:  %.6g\n', accuracy_train, accuracy_test);

% Show images that caused trouble
if ~isempty(mistakes_train)
    showMNISTImages_many(train.X(:, mistakes_train));
    title('Failed train images');
end
if ~isempty(mistakes_test)
    showMNISTImages_many(test.X(:, mistakes_test));
    title('Failed test images');
end




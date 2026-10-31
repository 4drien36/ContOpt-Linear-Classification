function [accuracy, mistakes] = binary_classifier_accuracy(data, theta)
% Given a dataset (either train or test) and a parameter vector theta,
% uses theta to predict the labels on the images data.X and compares with
% the given labels data.y. Returns the fraction of correct predictions and
% the id's of incorrectly predicted labels.

    X = data.X;
    y = data.y;
    
    z = X'*theta;
    
    mistakes = find(y ~= (z > 0));
    
    n_correct = length(y) - length(mistakes);
    
    accuracy = n_correct / length(y);
    
end

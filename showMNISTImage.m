function showMNISTImage(I)
% Input I is a column vector taken from the train or test set X.

    % If present, remove the trailing 1 that may have been added
    % to the image for intercept (bias term b).
    if length(I) == 785
        I = I(1:end-1);
    end
    
    if numel(I) ~= 784
        error('Image must have length 784 (size 28x28).');
    end

    image(255*reshape(I, 28, 28));
    colormap gray;
    axis equal;
    
end

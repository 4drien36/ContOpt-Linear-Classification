function showMNISTImages_many(X)
% Usage example: showMNISTImages_many(test.X(:, 1:(32^2)))

    figure;
    
    % If present, remove the trailing 1 that may have been added
    % to the image for intercept (bias term b).
    if size(X, 1) == 785
        X = X(1:end-1, :);
    end
    
    k = ceil(sqrt(size(X, 2)));
    
    I = zeros( k*28 );
    
    for k1 = 1 : k
        for k2 = 1 : k
       
            kk = (k1-1)*k + k2;
            
            if kk > size(X, 2)
                break;
            end
            
            I( (k1-1)*28 + (1:28), (k2-1)*28 + (1:28) ) = reshape(X(:, kk), 28, 28);
            
        end
    end
    
    image(255*I);
    colormap gray;
    axis equal;
    axis off;
    box off;

end

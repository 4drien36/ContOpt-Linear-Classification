function [f, g] = svm(train, theta, lambda)
    %initialize parameters
    X = train.X;
    y = train.y;

    %% Cost function
    [fct_phi1,fct_phi_deriv1] = phi(X.'*theta); 
    [fct_phi2,fct_phi_deriv2] = phi((-1)*X.'*theta);
    f=y'*fct_phi2 +(1-y)'*fct_phi1 + (lambda/2)*(theta'*theta);

    %% Gradient
    coeffs = (1 - y) .* fct_phi_deriv1  -  y .* fct_phi_deriv2; 
    g = X * coeffs + lambda * theta;  

    if any(isnan(f), 'all') || any(isnan(g), 'all')
        warning(['The function svm returned expressions containing NaNs. ' ...
            'This is likely due to a bug in your code.']);
    end
    
end
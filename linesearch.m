function alpha = linesearch(fhandle, x, v, lsparams)
    %Initialize parameters and outputs
    alphabar = lsparams.alphabar;
    c = lsparams.c;
    rho = lsparams.rho;
    alphamin = lsparams.alphamin;
    alpha = alphabar;
    
    [fx,~] = fhandle(x); %f(x) an d f'(x)
    [fy,~] = fhandle(x-alpha*v); %f(x-alpha*f'(x))
    while alpha >= alphamin && fx-fy<c*alpha*(norm(v)^2)
        alpha = rho * alpha;
        [fy,~] = fhandle(x-alpha*v); %f(x-alpha*f'(x))
    end
    if(rho * alpha < alphamin)
        warning('Backtracking minimum step size reached!');
    end
end
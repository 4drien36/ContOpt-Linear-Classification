function [theta, gradnorms, times] = cstgradientdescent(fhandle, x0, alpha, params)
    maxiters = params.maxiters;
    maxtime = params.maxtime;
    tolgradnorm = params.tolgradnorm;
    theta = zeros(size(x0,1),maxiters + 1);
    gradnorms = zeros(1, maxiters + 1);
    times = zeros(1, maxiters + 1);


    iter=1;
    xk=x0;
    time=0;
    [~,g]=fhandle(x0);
    gradnorms(1)=norm(g);
    theta(:,iter)=xk;
    while iter<=maxiters && time<maxtime && (gradnorms(iter)/gradnorms(1))>tolgradnorm

        tic;
        xk=xk-g*alpha;
        iter = iter + 1;% Increment the iteration counter
        [~,g]=fhandle(xk);
        theta(:,iter) = xk;
        gradnorms(iter) = norm(g); % Store the gradient norm
        times(iter) = toc; % Record the elapsed time
        time=time+times(iter);

        if params.verbose == true
            disp("Iteration number : "+(iter));
            disp("Running time : "+time);
            disp("The gradient norm of theta_"+{iter} +": " +gradnorms(iter));
            disp(" ");

        end
    end
    gradnorms = gradnorms(1:iter);
    times = times(1:iter);
    theta = theta(:,1:iter);
end
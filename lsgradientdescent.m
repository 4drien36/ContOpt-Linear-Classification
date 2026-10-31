function [theta, gradnorms, times] = lsgradientdescent(fhandle, x0, params, lsparams)
    %Initialize parameters and outputs
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
    while (iter<=maxiters) && (time<maxtime) && ((gradnorms(iter)/gradnorms(1))>tolgradnorm)
       
        tic;
        alpha = linesearch(fhandle, xk, g, lsparams); % Find optimal step size using linesearch
        xk=xk-g*alpha; 
        iter = iter + 1;
        theta(:,iter) = xk; %Store theta_k
        [~,g]=fhandle(xk); 
        gradnorms(iter) = norm(g); % Store the gradient norm
        times(iter) = toc; 
        time=time+times(iter); %Record total time


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
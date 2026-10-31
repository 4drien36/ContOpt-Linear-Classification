function checkgradient(fhandle, theta, v)
    n = 101;
    ts = logspace(-8, 0, n);
    errs = zeros(size(ts));

    
    for k = 1:length(ts)    % Loop over t values
        t = ts(k);          % f(theta + t v)
        [f_t, g_t] = fhandle(theta);
        [f_tv, ~] = fhandle(theta+t*v);      
        errs(k) = abs( f_tv - f_t - t*(v' * g_t) ); % Taylor expansion error
    end

    ref_t = ts(1);              % smallest t
    ref_err = errs(1);          % corresponding error
    C = ref_err / ref_t^2;      % scaling constant so line matches at ref_t
    ref_line = C * ts.^2;       % Reference line with slope 2

    % Plot in log-log scale
    loglog(ts, errs, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
    hold on;
    loglog(ts, ref_line, 'r--', 'LineWidth', 1.5);
    legend('Error curve','Slope-2 reference','Location','southwest');
    hold off;
    xlabel('t');
    ylabel('Error');
    title('Gradient check: error vs t');
end

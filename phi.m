function [u,v] = phi(z)

    u = zeros(size(z));      
    v = zeros(size(z));
    
    u(z <= -1) = 0;  % case 1: z <= -1
    v(z <= -1) = 0;
    
    mask = (z > -1) & (z < 0);  % case 2: -1 < z < 0
    u(mask) = 0.5 .* (1 + z(mask)).^2;  
    v(mask) = 1 + z(mask);
  
    u(z >= 0) = 1/2 + z(z >= 0);  % case 3: z >= 0
    v(z >= 0) = 1;
end
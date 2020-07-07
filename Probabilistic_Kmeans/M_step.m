function [mu_new] = M_step(X,mu_old,c,E)
    
    for z = 1:c
       mu_new(z,:) = mean(X(E==z,:)); 
    end 
end
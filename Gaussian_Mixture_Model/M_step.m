function [alpha_new,mu_new,sigma_new] = M_step(X,alpha_old,mu_old,E)

    w = E./sum(E,1);
    for z = 1:length(alpha_old)
        mu_new(z,:) = sum(w(:,z).*X);
        sigma_new(z,:,:) = (w(:,z).*(X-mu_new(z,:)))'*(X-mu_new(z,:));
    end
    alpha_new = mean(E,1);
    
end
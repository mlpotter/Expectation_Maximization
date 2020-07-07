function px = eval_GMM(X,mu,sigma,alpha)
    
    for z = 1:length(alpha)
        px(:,z) = alpha(z)*mvnpdf(X,mu(z,:),squeeze(sigma(z,:,:)));
    end
    px = sum(px,2);
    
end
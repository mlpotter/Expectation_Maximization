function E = E_step(X,alpha,mus,sigmas)

    for z = 1:length(alpha)
        temp(:,z) = alpha(z)*mvnpdf(X,mus(z,:),squeeze(sigmas(z,:,:)));
    end
    E = temp./(sum(temp,2));
    
end
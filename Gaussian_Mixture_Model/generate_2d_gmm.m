function [X,y] = generate_2d_gmm(N,alpha,mus,sigmas)

p = rand(N,1);
p_total = 0;

X = zeros(N,2);
y = zeros(N,1);

    for z = 1:length(alpha)
        p_total = p_total + alpha(z);
        idx = p<p_total;
        p(idx) = 1.1;
        y(idx) = z;
        X(idx,:) = mvnrnd(mus(z,:),squeeze(sigmas(z,:,:)),sum(idx));
    end
    
end
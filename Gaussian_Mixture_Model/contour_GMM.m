function C = contour_GMM(X,mu,sigma,alpha)
    [xmin,~] = min(X);
    [xmax,~] = max(X);
    N = 1000;
    [X1,X2] = meshgrid(linspace(xmin(1),xmax(1),N),linspace(xmin(2),xmax(2),N));
    px = eval_GMM([X1(:),X2(:)],mu,sigma,alpha);
    px = px/min(px);
    
    [~,C] = contour(X1,X2,reshape(px,N,N));
end
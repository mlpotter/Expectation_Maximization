close all; clear all; clc;

%% true value parameters
sigmas(1,:,:) = [3 1;1 20];
sigmas(2,:,:) = [7 1;1 2];
sigmas(3,:,:) = [4 1;1 16];
mus = [-8 0; 0 0; 8 0];
alphas = [0.3,0.2,0.5];

%% generate data from GMM
N = 1000;
[X,y] = generate_2d_gmm(N,alphas,mus,sigmas);

%% plot data generated
h = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
scatter(X(:,1),X(:,2),5,y);
hold on

%% initialize GMM parameters
c = 3;

for i = 1:c 
    s(i,:,:) = eye(2,2);
end

m = X(randi(length(X),1,c),:);
a = ones(1,c)/c;
%% train GMM via EM
EM_steps = 	100;
tol = 0.005;
old_LL = 0
filename = 'GMM_fit.gif';
for i = 1:EM_steps
    
    E = E_step(X,a,m,s);
    m = M_step(X,m,c,E);
    
    subplot(1,2,1)
    scatter(X(:,1),X(:,2),5,E);
    logLikelihood = sum(log(eval_GMM(X,m,s,a)));
    
    subplot(1,2,2)
    hold on
    plot(i,logLikelihood,'b.')
    xlabel('Iteration')
    ylabel('Log-likelihood')
    
    pause(0.00005)
    
    drawnow
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 
      
    if i == (EM_steps-1)
        break
    end
    percent_change = abs((logLikelihood-old_LL)/old_LL)*100;
    old_LL = logLikelihood;
    if percent_change < tol
        break
    end
end
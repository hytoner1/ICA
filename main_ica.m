%% MAIN script for the ica demonstration
    %% Initialize
n = 1:100;

s1 = sin(3*n);
s2 = rand(1,length(n))-0.5;

S = [s1; s2];
A = [5,10;5,3];
X = (A*S);

figure(1); clf; 
subplot(3,1,1);
    plot(n,S(1,:),'--');
    title('Source 1 & Estimate')
    legend('s1')
subplot(3,1,2);
    plot(n,S(2,:),'--');
    title('Source 2 & Estimate')
    legend('s2')
subplot(3,1,3);
    plot(n,X);
    title('Mixed sources')
    legend('x1','x2')
    
figure(2);
    scatter(X(1,:), X(2,:),'.')
    
%% Estimate s from the x
[Y, W] = pca_ica(X);

figure(1);
subplot(3,1,1); hold on;
    plot(n,Y(1,:));
    legend('s1','y1');
subplot(3,1,2); hold on;
    plot(n,Y(2,:));
    legend('s2','y2');
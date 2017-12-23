%% MAIN script for the ica demonstration
    %% Initialize
n = 1:100;

s1 = sin(3*n);
s2 = rand(1,length(n));

s3 = zeros(1,length(n));
    s3(2:11) = sin([0:9] ./ 10 .* pi);
    s3(32:41) = sin([0:9] ./ 10 .* pi);
    s3(62:71) = sin([0:9] ./ 10 .* pi);

S = [s1; s2; s3];
A = [1, 0.5, 0.3; 0.3, 0.3, 0.3; 0.2, 0.5, 1];
X = (A*S);

figure(1); clf; 
subplot(3,1,1);
    plot(n, S);
    title('Sources')
    legend('s1', 's2', 's3')

subplot(3,1,2);
    plot(n, X);
    title('Mixed sources')
    legend('x1', 'x2', 'x3')
    
% figure(2);
%     scatter(X(1,:), X(2,:),'.')
     
%% Estimate s from the x
[Y, W] = pca_ica(X);

figure(1);
subplot(3,1,1); hold on;
    plot(n,Y(1,:));
    legend('s1','y1');
subplot(3,1,2); hold on;
    plot(n,Y(2,:));
    legend('s2','y2');
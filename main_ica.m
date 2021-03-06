%% MAIN script for the ica demonstration
    %% Initialize
    
    n = 3;
opt=2;
nmax = 1e3;
dmin = 1e-3;
N = 100;

sn=sin(2*pi*(1:30)/50);
% S1=zeros(1,150);
% S1(1:50)=sn;
S1 = sin(3 .* (1:N));
S2=zeros(1,N);
% S2(51:100)=sn;
S2(mod(1:N, 10)==0) = 1;
S3=zeros(1,N);
S3(N/2 : N/2+29)=sn;
S=[S1;S2;S3];

A = [1 1 5; 2 -2 4; 3 3 3; 4 -4 2; 5 5 1];  % mixing matrix

Y0 = A*S;
sig = sqrt(mean(mean(Y0.^2)));
r = .0;
noise = r*sig*randn(5,100);
Y = Y0+ noise;

% [Aest,Sest,West,Del] = FastICA(Y,n,opt,nmax,dmin);
[Sest, West] = pca_ica(Y);
Ta = bestmatch(A,Aest);
Ts = bestmatch(S',Sest');
iterSteps = length(Del)


figure; hold on;
    plot(Y(1,:) - mean(Y(1,:)));
    plot(Y(2,:) - mean(Y(2,:))+ 10);
    plot(Y(3,:) - mean(Y(3,:))+ 20);
%     plot(Y(4,:) - mean(Y(4,:))+ 30);
%     plot(Y(5,:) - mean(Y(5,:))+ 40);
    
    set(gca, 'YTick', 0:10:40)
    set(gca, 'YTicklabel', 1:5)
    

%%
figure;
for j=1:3
    subplot(3,1,j);
    u=S(Ts(j,1),:);
    v=Sest(Ts(j,2),:);
    c=u*v'/(v*v');
    plot(1:N,u,1:N,c*v);
end
subplot(3,1,1);
    
    
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
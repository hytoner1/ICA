function [ Y, W ] = pca_ica( X )
%PCA_ICA performs the Independent Component Analysis of data using pca
%   Input:
%       x - [N, M] data matrix of M sources with N time points
%   Output:
%       y - Separated components of x
%       w - The inverse of mixing matrix A
    
        % Number of samples in data
    N = size(X, 1);
    
        % Eigenvectors and -values of covariance matrix of data
    [E, D] = eig(cov(X'));
    
        % Whitening matrix
    V = E * D^(-0.5) * E';
        % Whiten and center
    z = V * X - mean(X,2);
%     figure(100);
%         scatter(z(1,:), z(2,:));
    
        % Max kurtosis z
    z_max_k = bsxfun( @times, sum(z.^2, 1), z ) * z';

        % Weight matrix from z
    [W, ~, ~] = svd(z_max_k);
        % Weighted data
    Y = W * z;
    
    % Kurtosis maximization method
%     o_ = linspace(0,2*pi,1000);
%     w_ = [cos(o_); sin(o_)];
%     
%     kurtoses = zeros(1,length(o_));
%     
%     
%     for i=1:length(o_)
%         kurtoses(i) = kurtosis(w_(:,i)' * z_normal);
%     end
%     
%     max_k = find(abs(kurtoses) == max(abs(kurtoses)));
%     
%     w_ = [w_(:,max_k(1)), [cos(o_(max_k)+pi/2); sin(o_(max_k)+pi/2)]]
%     
%     Y_ = w_' * z;
%     W_ = w_;
% 
%         % Find eigenvectors of whitened data
%     [E2, ~] = eig(cov(z_normal'))
%     
%     Y = E2'*z;
%     W = E2';
%     
%     figure(101); clf; hold on; axis equal;
%         scatter(z(1,:), z(2,:),'.');
%         line([0, W(1,1)], [0, W(2,1)]);
%     
%     figure(102); clf; hold on;
%         plot(o_, kurtoses);
%         scatter(max_k/1000*(2*pi), max(kurtoses), 'o');
%     



end




















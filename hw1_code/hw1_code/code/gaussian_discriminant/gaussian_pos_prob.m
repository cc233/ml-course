function p = gaussian_pos_prob(X, Mu, Sigma, Phi)
%GAUSSIAN_POS_PROB Posterior probability of GDA.
%   p = GAUSSIAN_POS_PROB(X, Mu, Sigma) compute the posterior probability
%   of given N data points X using Gaussian Discriminant Analysis where the
%   K gaussian distributions are specified by Mu, Sigma and Phi.
%
%   Inputs:
%       'X'     - M-by-N matrix, N data points of dimension M.
%       'Mu'    - M-by-K matrix, mean of K Gaussian distributions.
%       'Sigma' - M-by-M-by-K matrix (yes, a 3D matrix), variance matrix of
%                   K Gaussian distributions.
%       'Phi'   - 1-by-K matrix, prior of K Gaussian distributions.
%
%   Outputs:
%       'p'     - N-by-K matrix, posterior probability of N data points
%                   with in K Gaussian distributions.

N = size(X, 2);
M=size(Mu,1);
K = length(Phi);
p = zeros(N, K);
%p=P(x|y=i)*P(y=i)
for i=1:K
    Mu_M=Mu(:,i);
    Sigma_M_M=reshape(Sigma(:,:,i),M,M);
    for j=1:N
        Xj=X(:,j);
        %P_X_Yi:1*1
        P_X_Yi=exp(-0.5*(Xj-Mu_M)'/Sigma_M_M*(Xj-Mu_M))/(2*pi*power(det(Sigma_M_M),0.5));
        %P_Yi:1*1
        P_Yi=Phi(1,i);
        p(j,i)=P_X_Yi*P_Yi;
    end
end
%normalize or p/=P(X)
for i=1:N
    p(i,:)=p(i,:)./sum(p(i,:),2);
end
% Your code HERE

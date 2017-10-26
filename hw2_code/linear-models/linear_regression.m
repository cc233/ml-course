function w = linear_regression(X, y)
%LINEAR_REGRESSION Linear Regression.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
lr=0.1;
[p,N]=size(X);
w=zeros(p+1,1);
X0=ones(1,N);
X_full=[X0;X];
w=inv(X_full*X_full')*X_full*y';
end

function [w, iter] = perceptron(X, y)
%PERCEPTRON Perceptron Learning Algorithm.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%           iter: number of iterations
%

% YOUR CODE HERE
[p,N]=size(X);
w=ones(p+1,1);
X0=ones(1,N);
X_full=[X0;X];
iter=0;
while(1)
    y_hat=w'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    new_w=w+X_full*(y.*wrong)';
    iter=iter+1;
    new_change=sum((new_w-w).*(new_w-w),1);
    if(new_change<(sum(w.*w,1)*0.01))
        break;
    end
    w=new_w;
end
w=new_w;
end

function w = logistic(X, y)
%LR Logistic Regression.
%
%   INPUT:  X:   training sample features, P-by-N matrix.
%           y:   training sample labels, 1-by-N row vector.
%
%   OUTPUT: w    : learned parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
lr=0.1;
[P,N]=size(X);
lr=ones(P+1,1)*lr;
w=ones(P+1,1);
X0=ones(1,N);
X_full=[X0;X];
while(1)
    new_w=w+lr.*(X_full*((1-ones(1,N)./(1+exp(-y.*(w'*X_full)))).*y)');
    new_change=sum((new_w-w).*(new_w-w),1);
    if(new_change<(sum(w.*w,1)*0.00001))
        break;
    end
    w=new_w;
end
w=new_w;
end

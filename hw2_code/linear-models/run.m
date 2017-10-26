% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%% Part1: Preceptron
nRep = 20; % number of replicates
nTrain = 100; % number of training data
nTest=50;%number of testing data
E_train=0;
E_test=0;
train_error_sum=0;
test_error_sum=0;
iter_sum=0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    [w_g, iter] = perceptron(X, y);
    % Compute training, testing error
    %train
    [temp,N]=size(X);
    X0=ones(1,N);
    X_full=[X0;X];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    train_error_sum=train_error_sum+sum(wrong)/nTrain;
    % Sum up number of iterations
    iter_sum=iter+iter_sum;
    %test
    [X_test,y_test]=mktestdata(w_f,nTest');
    [temp,N]=size(X_test);
    X0=ones(1,N);
    X_full=[X0;X_test];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y_test.*y_hat)<=0;
    test_error_sum=test_error_sum+sum(wrong)/N;
end
avgIter=iter_sum/nTrain;
E_train=train_error_sum/nRep;
E_test=test_error_sum/nRep;
fprintf('Preceptron:E_train is %f, E_test is %f.\n', E_train, E_test);
fprintf('Average number of iterations is %d.\n', avgIter);
plotdata(X, y, w_f, w_g, 'Pecertron');

%% Part2: Preceptron: Non-linearly separable case
% nTrain = 100; % number of training data
% [X, y, w_f] = mkdata(nTrain, 'noisy');
% [w_g, iter] = perceptron(X, y);


%% Part3: Linear Regression
nRep = 1000; % number of replicates
nTrain = 100; % number of training data
train_error_sum=0;
test_error_sum=0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    w_g = linear_regression(X, y);
    % Compute training, testing error
    %train
    [temp,N]=size(X);
    X0=ones(1,N);
    X_full=[X0;X];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    train_error_sum=train_error_sum+sum(wrong)/nTrain;
    % Sum up number of iterations
    %test
    [X_test,y_test]=mktestdata(w_f,nTest);
    [temp,N]=size(X_test);
    X0=ones(1,N);
    X_full=[X0;X_test];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y_test.*y_hat)<=0;
    test_error_sum=test_error_sum+sum(wrong)/N;
end
E_train=train_error_sum/nRep;
E_test=test_error_sum/nRep;
fprintf('Linear Regression:E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Linear Regression');

%% Part4: Linear Regression: noisy
nRep = 1000; % number of replicates
nTrain = 100; % number of training data
train_error_sum=0;
test_error_sum=0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain, 'noisy');
    w_g = linear_regression(X, y);
    % Compute training, testing error
    %train
    [temp,N]=size(X);
    X0=ones(1,N);
    X_full=[X0;X];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    train_error_sum=train_error_sum+sum(wrong)/nTrain;
    % Sum up number of iterations
    %test
    [X_test,y_test]=mktestdata(w_f,nTest,'noisy');
    [temp,N]=size(X_test);
    X0=ones(1,N);
    X_full=[X0;X_test];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y_test.*y_hat)<=0;
    test_error_sum=test_error_sum+sum(wrong)/N;
end
E_train=train_error_sum/nRep;
E_test=test_error_sum/nRep;
fprintf('Linear Regression: noisy:E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Linear Regression: noisy');

%% Part5: Linear Regression: poly_fit
load('poly_train', 'X', 'y');
load('poly_test', 'X_test', 'y_test');
w = linear_regression(X, y);
% Compute training, testing error
%train
[temp,N]=size(X);
X0=ones(1,N);
X_full=[X0;X];
y_hat=w'*X_full;
%1 for wrong, 0 for correct
wrong=(y.*y_hat)<=0;
E_train=sum(wrong)/N;
%test
[temp,N]=size(X_test);
X0=ones(1,N);
X_full=[X0;X_test];
y_hat=w'*X_full;
%1 for wrong, 0 for correct
wrong=(y_test.*y_hat)<=0;
E_test=sum(wrong)/N;
fprintf('Linear Regression: poly_fit:E_train is %f, E_test is %f.\n', E_train, E_test);

% poly_fit with transform
X_t = [X(1,:);X(2,:);X(1,:).*X(2,:);X(1,:).*X(1,:);X(2,:).*X(2,:)]; % CHANGE THIS LINE TO DO TRANSFORMATION
X_test_t =[X_test(1,:);X_test(2,:);X_test(1,:).*X_test(2,:);X_test(1,:).*X_test(1,:);X_test(2,:).*X_test(2,:)]; % CHANGE THIS LINE TO DO TRANSFORMATION
w = linear_regression(X_t, y);
% Compute training, testing error
%train
[temp,N]=size(X);
X0=ones(1,N);
X_full=[X0;X_t];
y_hat=w'*X_full;
%1 for wrong, 0 for correct
wrong=(y.*y_hat)<=0;
E_train=sum(wrong)/N;
%test
[temp,N]=size(X_test);
X0=ones(1,N);
X_full=[X0;X_test_t];
y_hat=w'*X_full;
%1 for wrong, 0 for correct
wrong=(y_test.*y_hat)<=0;
E_test=sum(wrong)/N;

fprintf('Linear Regression: poly_fit: E_train is %f, E_test is %f.\n', E_train, E_test);


%% Part6: Logistic Regression
nRep = 100; % number of replicates
nTrain = 100; % number of training data
nTest=100;
train_error_sum=0;
test_error_sum=0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    w_g = logistic(X, y);
    % Compute training, testing error
    %train
    [temp,N]=size(X);
    X0=ones(1,N);
    X_full=[X0;X];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    train_error_sum=train_error_sum+sum(wrong)/nTrain;
    %test
    [X_test,y_test]=mktestdata(w_f,nTest);
    [temp,N]=size(X_test);
    X0=ones(1,N);
    X_full=[X0;X_test];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y_test.*y_hat)<=0;
    test_error_sum=test_error_sum+sum(wrong)/N;
end
E_train=train_error_sum/nRep;
E_test=test_error_sum/nRep;
fprintf(' Logistic Regression: E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Logistic Regression');

%% Part7: Logistic Regression: noisy
nRep = 100; % number of replicates
nTrain = 100; % number of training data
nTest = 10000; % number of training data
train_error_sum=0;
test_error_sum=0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain, 'noisy');
    w_g = logistic(X, y);
    % Compute training, testing error
    %train
    [temp,N]=size(X);
    X0=ones(1,N);
    X_full=[X0;X];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y.*y_hat)<=0;
    train_error_sum=train_error_sum+sum(wrong)/nTrain;
    %test
    [X_test,y_test]=mktestdata(w_f,nTest,'noisy');
    [temp,N]=size(X_test);
    X0=ones(1,N);
    X_full=[X0;X_test];
    y_hat=w_g'*X_full;
    %1 for wrong, 0 for correct
    wrong=(y_test.*y_hat)<=0;
    test_error_sum=test_error_sum+sum(wrong)/N;
end
E_train=train_error_sum/nRep;
E_test=test_error_sum/nRep;
fprintf('Logistic Regression: noisy£º E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Logistic Regression: noisy');

%% Part8: SVM
nRep = 1000; % number of replicates
nTrain = 100; % number of training data

for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    [w_g, num_sc] = svm(X, y);
    % Compute training, testing error
    % Sum up number of support vectors
end

%fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'SVM');

%ham_train contains the occurrences of each word in ham emails. 1-by-N vector
ham_train = csvread('ham_train.csv');
%spam_train contains the occurrences of each word in spam emails. 1-by-N vector
spam_train = csvread('spam_train.csv');
%N is the size of vocabulary.
N = size(ham_train, 2);
%There 9034 ham emails and 3372 spam emails in the training samples
num_ham_train = 9034;
num_spam_train = 3372;
%Do smoothing
x = [ham_train;spam_train] + 1;

%ham_test contains the occurences of each word in each ham test email. P-by-N vector, with P is number of ham test emails.
load ham_test.txt;
ham_test_tight = spconvert(ham_test);
ham_test = sparse(size(ham_test_tight, 1), size(ham_train, 2));
ham_test(:, 1:size(ham_test_tight, 2)) = ham_test_tight;
%spam_test contains the occurences of each word in each spam test email. Q-by-N vector, with Q is number of spam test emails.
load spam_test.txt;
spam_test_tight = spconvert(spam_test);
spam_test = sparse(size(spam_test_tight, 1), size(spam_train, 2));
spam_test(:, 1:size(spam_test_tight, 2)) = spam_test_tight;

%TODO
%Implement a ham/spam email classifier, and calculate the accuracy of your classifier

%a
%find the words with the highest ratio
top_k=10;
% x(1,:)=x(1,:)/num_ham_train;
% x(2,:)=x(2,:)/num_spam_train;
x(1,:)=x(1,:)/sum(x(1,:),2);
x(2,:)=x(2,:)/sum(x(2,:),2);
ratio=x(2,:)./x(1,:);
[top_k_ratio,top_k_idx]= sort(ratio,2);
fprintf('top k words:\n');
fprintf('idx\t\tratio\tspam_num\tham_num\n');
for i=1:top_k
    idx=top_k_idx(N-i+1);
    ratio_temp=top_k_ratio(N-i+1);
    fprintf('%d\t%.2f\t%d\t\t\t%d\n',idx,ratio_temp,x(2,idx),x(1,idx));
end

%b
%accuracy on testing set
num_ham_test=size(ham_test,1);
num_spam_test=size(spam_test,1);
log_x=log(x);
p_ham=ham_test*log_x';
p_ham(:,1)=p_ham(:,1)+log(num_ham_train/(num_ham_train+num_spam_train));
p_ham(:,2)=p_ham(:,2)+log(num_spam_train/(num_spam_train+num_ham_train));
p_error=p_ham(:,1)<p_ham(:,2);
error=sum(p_error);
%for q-d
FP=sum(p_error);
TN=num_ham_test-FP;

p_spam=spam_test*log_x';
p_spam(:,1)=p_spam(:,1)+log(num_ham_train/(num_ham_train+num_spam_train));
p_spam(:,2)=p_spam(:,2)+log(num_spam_train/(num_spam_train+num_ham_train));
p_error=p_spam(:,1)>p_spam(:,2);
error=error+sum(p_error);
%for q-d
FN=sum(p_error);
TP=num_spam_test-FN;

fprintf('error num:%d\n',error);
error=error/(num_spam_test+num_ham_test);
fprintf('error ratio:%.4f\n',error);

%c
%precision and recall
precision=TP/(TP+FP);
recall=TP/(TP+FN);
fprintf('precision:%.4f\nrecall:%.4f\n',precision,recall);
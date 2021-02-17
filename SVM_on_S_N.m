

%% Training the SVM
n = 70; %number of training data from each S,N
labels = ones(n,1); labels = [labels;zeros(n,1)];
labels = [labels;ones(100-n,1)]; labels = [labels;zeros(100-n,1)];
features = data_S(1:n,:); features = [features;data_N(1:n,:)];
features = [features;data_S(n+1:100,:)]; features = [features;data_N(n+1:100,:)];
fs = sparse(features);
libsvmwrite('svm',labels,fs);
[y,x] = libsvmread('svm');
train_label = y(1:2*n); test_label = y(2*n+1:200);
train_data = x(1:2*n,:); test_data = x(2*n+1:200,:);

%model = svmtrain(train_label,train_data, '-s 3 -t 2 -g 0.0078125 -c 1024 -p 0.125'); %the default 

%model = svmtrain(train_label,train_data, '-s 2 -t 0 -q'); %this is for linear kernel, works well enough

%testing models for polynomial kernels
model = svmtrain(train_label,train_data, '-s 2 -t 1 -g 1 -r 1 -d 2 -q');
%% Predicting using SVM
%predicting for cross-validation set
[pred1,acc1,score1] = svmpredict(test_label, test_data, model, '-q');

accuracy = 100*sum(pred1 == [ones(100-n,1);-ones(100-n,1)])/(2*(100-n))
sensitivity = 100*sum(pred1(1:100-n)==ones(100-n,1))/(100-n)
FRR = sum(pred1(101-n:end)~= -ones(100-n,1))/(100-n)

%predicting for training set itself
% [pred2,acc2,score2] = svmpredict(train_label, train_data, model, '-q');
% 
% accuracy = 100*sum(pred2 == [ones(n,1);-ones(n,1)])/(2*n)
% sensitivity = 100*sum(pred2(1:n)==ones(n,1))/n
% FRR = sum(pred2(n+1:end)~= -ones(n,1))/n

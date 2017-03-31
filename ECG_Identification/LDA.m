function [newspace, Sw, Sb, E_r_train, E_r_val, E_r_test, train_norm, val_norm, test_norm, lambda] = LDA(train_dataset,val_dataset,test_dataset,D,eta)

% 这是采用的MIT_BIH数据库中的10个人的数据
% rr峰检测
% 幅值归一化了
% training data
train_1 = train_dataset(train_dataset(:,D+1)==1,1:D);
train_2 = train_dataset(train_dataset(:,D+1)==2,1:D);
train_3 = train_dataset(train_dataset(:,D+1)==3,1:D);
train_4 = train_dataset(train_dataset(:,D+1)==4,1:D);
train_5 = train_dataset(train_dataset(:,D+1)==5,1:D);
train_6 = train_dataset(train_dataset(:,D+1)==6,1:D);
train_7 = train_dataset(train_dataset(:,D+1)==7,1:D);
train_8 = train_dataset(train_dataset(:,D+1)==8,1:D);
train_9 = train_dataset(train_dataset(:,D+1)==9,1:D);
train_10 = train_dataset(train_dataset(:,D+1)==10,1:D);
train_1_norm = bsxfun(@rdivide,bsxfun(@minus,train_1,min(train_1,[],2)),max(train_1,[],2)-min(train_1,[],2));
train_2_norm = bsxfun(@rdivide,bsxfun(@minus,train_2,min(train_2,[],2)),max(train_2,[],2)-min(train_2,[],2));
train_3_norm = bsxfun(@rdivide,bsxfun(@minus,train_3,min(train_3,[],2)),max(train_3,[],2)-min(train_3,[],2));
train_4_norm = bsxfun(@rdivide,bsxfun(@minus,train_4,min(train_4,[],2)),max(train_4,[],2)-min(train_4,[],2));
train_5_norm = bsxfun(@rdivide,bsxfun(@minus,train_5,min(train_5,[],2)),max(train_5,[],2)-min(train_5,[],2));
train_6_norm = bsxfun(@rdivide,bsxfun(@minus,train_6,min(train_6,[],2)),max(train_6,[],2)-min(train_6,[],2));
train_7_norm = bsxfun(@rdivide,bsxfun(@minus,train_7,min(train_7,[],2)),max(train_7,[],2)-min(train_7,[],2));
train_8_norm = bsxfun(@rdivide,bsxfun(@minus,train_8,min(train_8,[],2)),max(train_8,[],2)-min(train_8,[],2));
train_9_norm = bsxfun(@rdivide,bsxfun(@minus,train_9,min(train_9,[],2)),max(train_9,[],2)-min(train_9,[],2));
train_10_norm = bsxfun(@rdivide,bsxfun(@minus,train_10,min(train_10,[],2)),max(train_10,[],2)-min(train_10,[],2));
train_norm = [train_1_norm;train_2_norm;train_3_norm;train_4_norm;train_5_norm;
              train_6_norm;train_7_norm;train_8_norm;train_9_norm;train_10_norm];
          
% validation data
val_1 = val_dataset(val_dataset(:,D+1)==1,1:D);
val_2 = val_dataset(val_dataset(:,D+1)==2,1:D);
val_3 = val_dataset(val_dataset(:,D+1)==3,1:D);
val_4 = val_dataset(val_dataset(:,D+1)==4,1:D);
val_5 = val_dataset(val_dataset(:,D+1)==5,1:D);
val_6 = val_dataset(val_dataset(:,D+1)==6,1:D);
val_7 = val_dataset(val_dataset(:,D+1)==7,1:D);
val_8 = val_dataset(val_dataset(:,D+1)==8,1:D);
val_9 = val_dataset(val_dataset(:,D+1)==9,1:D);
val_10 = val_dataset(val_dataset(:,D+1)==10,1:D);
val_1_norm = bsxfun(@rdivide,bsxfun(@minus,val_1,min(val_1,[],2)),max(val_1,[],2)-min(val_1,[],2));
val_2_norm = bsxfun(@rdivide,bsxfun(@minus,val_2,min(val_2,[],2)),max(val_2,[],2)-min(val_2,[],2));
val_3_norm = bsxfun(@rdivide,bsxfun(@minus,val_3,min(val_3,[],2)),max(val_3,[],2)-min(val_3,[],2));
val_4_norm = bsxfun(@rdivide,bsxfun(@minus,val_4,min(val_4,[],2)),max(val_4,[],2)-min(val_4,[],2));
val_5_norm = bsxfun(@rdivide,bsxfun(@minus,val_5,min(val_5,[],2)),max(val_5,[],2)-min(val_5,[],2));
val_6_norm = bsxfun(@rdivide,bsxfun(@minus,val_6,min(val_6,[],2)),max(val_6,[],2)-min(val_6,[],2));
val_7_norm = bsxfun(@rdivide,bsxfun(@minus,val_7,min(val_7,[],2)),max(val_7,[],2)-min(val_7,[],2));
val_8_norm = bsxfun(@rdivide,bsxfun(@minus,val_8,min(val_8,[],2)),max(val_8,[],2)-min(val_8,[],2));
val_9_norm = bsxfun(@rdivide,bsxfun(@minus,val_9,min(val_9,[],2)),max(val_9,[],2)-min(val_9,[],2));
val_10_norm = bsxfun(@rdivide,bsxfun(@minus,val_10,min(val_10,[],2)),max(val_10,[],2)-min(val_10,[],2));
E_r_val = [mean(val_1_norm,1);mean(val_2_norm,1);mean(val_3_norm,1);mean(val_4_norm,1);mean(val_5_norm,1);
           mean(val_6_norm,1);mean(val_7_norm,1);mean(val_8_norm,1);mean(val_9_norm,1);mean(val_10_norm,1)];
val_norm = [val_1_norm;val_2_norm;val_3_norm;val_4_norm;val_5_norm;
            val_6_norm;val_7_norm;val_8_norm;val_9_norm;val_10_norm];
        
% test data
test_1 = test_dataset(test_dataset(:,D+1)==1,1:D);
test_2 = test_dataset(test_dataset(:,D+1)==2,1:D);
test_3 = test_dataset(test_dataset(:,D+1)==3,1:D);
test_4 = test_dataset(test_dataset(:,D+1)==4,1:D);
test_5 = test_dataset(test_dataset(:,D+1)==5,1:D);
test_6 = test_dataset(test_dataset(:,D+1)==6,1:D);
test_7 = test_dataset(test_dataset(:,D+1)==7,1:D);
test_8 = test_dataset(test_dataset(:,D+1)==8,1:D);
test_9 = test_dataset(test_dataset(:,D+1)==9,1:D);
test_10 = test_dataset(test_dataset(:,D+1)==10,1:D);
test_1_norm = bsxfun(@rdivide,bsxfun(@minus,test_1,min(test_1,[],2)),max(test_1,[],2)-min(test_1,[],2));
test_2_norm = bsxfun(@rdivide,bsxfun(@minus,test_2,min(test_2,[],2)),max(test_2,[],2)-min(test_2,[],2));
test_3_norm = bsxfun(@rdivide,bsxfun(@minus,test_3,min(test_3,[],2)),max(test_3,[],2)-min(test_3,[],2));
test_4_norm = bsxfun(@rdivide,bsxfun(@minus,test_4,min(test_4,[],2)),max(test_4,[],2)-min(test_4,[],2));
test_5_norm = bsxfun(@rdivide,bsxfun(@minus,test_5,min(test_5,[],2)),max(test_5,[],2)-min(test_5,[],2));
test_6_norm = bsxfun(@rdivide,bsxfun(@minus,test_6,min(test_6,[],2)),max(test_6,[],2)-min(test_6,[],2));
test_7_norm = bsxfun(@rdivide,bsxfun(@minus,test_7,min(test_7,[],2)),max(test_7,[],2)-min(test_7,[],2));
test_8_norm = bsxfun(@rdivide,bsxfun(@minus,test_8,min(test_8,[],2)),max(test_8,[],2)-min(test_8,[],2));
test_9_norm = bsxfun(@rdivide,bsxfun(@minus,test_9,min(test_9,[],2)),max(test_9,[],2)-min(test_9,[],2));
test_10_norm = bsxfun(@rdivide,bsxfun(@minus,test_10,min(test_10,[],2)),max(test_10,[],2)-min(test_10,[],2));
E_r_test = [mean(test_1_norm,1);mean(test_2_norm,1);mean(test_3_norm,1);mean(test_4_norm,1);mean(test_5_norm,1);
            mean(test_6_norm,1);mean(test_7_norm,1);mean(test_8_norm,1);mean(test_9_norm,1);mean(test_10_norm,1)];
test_norm = [test_1_norm;test_2_norm;test_3_norm;test_4_norm;test_5_norm;
             test_6_norm;test_7_norm;test_8_norm;test_9_norm;test_10_norm];
         
% Training using the training dataset
E_1m = bsxfun(@minus,train_1_norm,mean(train_1_norm,1))';
E_2m = bsxfun(@minus,train_2_norm,mean(train_2_norm,1))';
E_3m = bsxfun(@minus,train_3_norm,mean(train_3_norm,1))';
E_4m = bsxfun(@minus,train_4_norm,mean(train_4_norm,1))';
E_5m = bsxfun(@minus,train_5_norm,mean(train_5_norm,1))';
E_6m = bsxfun(@minus,train_6_norm,mean(train_6_norm,1))';
E_7m = bsxfun(@minus,train_7_norm,mean(train_7_norm,1))';
E_8m = bsxfun(@minus,train_8_norm,mean(train_8_norm,1))';
E_9m = bsxfun(@minus,train_9_norm,mean(train_9_norm,1))';
E_10m = bsxfun(@minus,train_10_norm,mean(train_10_norm,1))';
E_1 = mean(train_1_norm,1)';
E_2 = mean(train_2_norm,1)';
E_3 = mean(train_3_norm,1)';
E_4 = mean(train_4_norm,1)';
E_5 = mean(train_5_norm,1)';
E_6 = mean(train_6_norm,1)';
E_7 = mean(train_7_norm,1)';
E_8 = mean(train_8_norm,1)';
E_9 = mean(train_9_norm,1)';
E_10 = mean(train_10_norm,1)';
E_r_train = [E_1';E_2';E_3';E_4';E_5';E_6';E_7';E_8';E_9';E_10'];
E_all = mean(train_norm,1)';
E = [E_1,E_2,E_3,E_4,E_5,E_6,E_7,E_8,E_9,E_10];
E_m = bsxfun(@minus,E,E_all);
Sw = (E_1m*E_1m' + E_2m*E_2m' + E_3m*E_3m' + E_4m*E_4m' + E_5m*E_5m' +...
      E_6m*E_6m' + E_7m*E_7m' + E_8m*E_8m' + E_9m*E_9m' + E_10m*E_10m');
Sb = 1000 * (E_m * E_m');
% Sb = 0;
% for i = 1:10
%     Sb = Sb + train_norm((i-1)*1000+1:i*1000,:)' * train_norm((i-1)*1000+1:i*1000,:) - E_all * E_all';
% end

% In classical LDA, rank(Sw) <= N-c and rank(Sb) <= c-1

[V,D] = eig(Sb,Sw);   % D is eigenvalue, V is eigenvector
% bar(diag(D),'b');
% grid on
[lambda,location] = sort(diag(D),'descend');
for dim = 1:length(lambda)
    if sum(lambda(1:dim)) / sum(lambda) > eta
        break
    end
end
newspace = V(:,location(1:dim));
newspace = newspace ./ norm(newspace,2);
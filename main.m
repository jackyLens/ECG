close all
clear
clc

% for n=10:10:100
n = 1000;
[train_dataset,val_dataset,test_dataset,num_train,num_val,num_test] = MIT_BIH_loaddata;
D = 540;
eta = 0.95;

plot(train_dataset(1,:),'b')
hold on
plot(train_dataset(2,:),'r')
xlim([1,540])
grid on




[newspace,Sw,Sb,E_r_train,E_r_val,E_r_test,train_norm,val_norm,test_norm,lambda] = LDA(train_dataset,val_dataset,test_dataset,D,eta);


acc_train = similarity(newspace,E_r_train,train_norm,num_train);
acc_val = similarity(newspace,E_r_val,val_norm,num_val);
acc_test = similarity(newspace,E_r_test,test_norm,num_test);
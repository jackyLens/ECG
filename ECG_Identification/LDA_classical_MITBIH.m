% 这是采用的MIT_BIH数据库中的10个人的数据
% rr峰检测
% 幅值归一化了
close all
clear
clc

load MIT_BIH_data.mat

% for n=10:10:100
n = 1000;
train_dataset = MIT_BIH_data_train;
val_dataset = MIT_BIH_data_val;
test_dataset = MIT_BIH_data_test;

% training data
train_1 = train_dataset(train_dataset(:,541)==1,1:540);
train_2 = train_dataset(train_dataset(:,541)==2,1:540);
train_3 = train_dataset(train_dataset(:,541)==3,1:540);
train_4 = train_dataset(train_dataset(:,541)==4,1:540);
train_5 = train_dataset(train_dataset(:,541)==5,1:540);
train_6 = train_dataset(train_dataset(:,541)==6,1:540);
train_7 = train_dataset(train_dataset(:,541)==7,1:540);
train_8 = train_dataset(train_dataset(:,541)==8,1:540);
train_9 = train_dataset(train_dataset(:,541)==9,1:540);
train_10 = train_dataset(train_dataset(:,541)==10,1:540);
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
val_1 = val_dataset(val_dataset(:,541)==1,1:540);
val_2 = val_dataset(val_dataset(:,541)==2,1:540);
val_3 = val_dataset(val_dataset(:,541)==3,1:540);
val_4 = val_dataset(val_dataset(:,541)==4,1:540);
val_5 = val_dataset(val_dataset(:,541)==5,1:540);
val_6 = val_dataset(val_dataset(:,541)==6,1:540);
val_7 = val_dataset(val_dataset(:,541)==7,1:540);
val_8 = val_dataset(val_dataset(:,541)==8,1:540);
val_9 = val_dataset(val_dataset(:,541)==9,1:540);
val_10 = val_dataset(val_dataset(:,541)==10,1:540);
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
val_norm = [val_1_norm;val_2_norm;val_3_norm;val_4_norm;val_5_norm;
            val_6_norm;val_7_norm;val_8_norm;val_9_norm;val_10_norm];

% test data
test_1 = test_dataset(test_dataset(:,541)==1,1:540);
test_2 = test_dataset(test_dataset(:,541)==2,1:540);
test_3 = test_dataset(test_dataset(:,541)==3,1:540);
test_4 = test_dataset(test_dataset(:,541)==4,1:540);
test_5 = test_dataset(test_dataset(:,541)==5,1:540);
test_6 = test_dataset(test_dataset(:,541)==6,1:540);
test_7 = test_dataset(test_dataset(:,541)==7,1:540);
test_8 = test_dataset(test_dataset(:,541)==8,1:540);
test_9 = test_dataset(test_dataset(:,541)==9,1:540);
test_10 = test_dataset(test_dataset(:,541)==10,1:540);
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
E_all = mean(train_norm,1)';
E_r = [E_1';E_2';E_3';E_4';E_5';E_6';E_7';E_8';E_9';E_10'];
E = [E_1,E_2,E_3,E_4,E_5,E_6,E_7,E_8,E_9,E_10];
E_m = bsxfun(@minus,E,E_all);
Sw = (E_1m*E_1m' + E_2m*E_2m' + E_3m*E_3m' + E_4m*E_4m' + E_5m*E_5m' +...
      E_6m*E_6m' + E_7m*E_7m' + E_8m*E_8m' + E_9m*E_9m' + E_10m*E_10m');
Sb = 1000 * (E_m * E_m');
% In classical LDA, rank(Sw) <= N-c and rank(Sb) <= c-1

[V,D] = eig(Sb,Sw);   % D is eigenvalue, V is eigenvector
% bar(diag(D),'b');
% grid on
[lambda,location] = sort(diag(D),'descend');
eta = 1;
for dim = 1:length(lambda)
    if sum(lambda(1:dim)) / sum(lambda) > eta
        break
    end
end

newspace = V(:,location(1:dim));
newspace = newspace ./ norm(newspace,2);
% train_1_after = 

data = MIT_BIH_data_train;
% for n = 10:10:1000
index = data(:,541)==1;
c1=data(index,1:540);
index = data(:,541)==2;
c2=data(index,1:540);
index = data(:,541)==3;
c3=data(index,1:540);
index = data(:,541)==4;
c4=data(index,1:540);
index = data(:,541)==5;
c5=data(index,1:540);
index = data(:,541)==6;
c6=data(index,1:540);
index = data(:,541)==7;
c7=data(index,1:540);
index = data(:,541)==8;
c8=data(index,1:540);
index = data(:,541)==9;
c9=data(index,1:540);
index = data(:,541)==10;
c10=data(index,1:540);
%波形幅值对其（归一化）
c1max = max(c1,[],2);
c1min = min(c1,[],2);
c2max = max(c2,[],2);
c2min = min(c2,[],2);
c3max = max(c3,[],2);
c3min = min(c3,[],2);
c4max = max(c4,[],2);
c4min = min(c4,[],2);
c5max = max(c5,[],2);
c5min = min(c5,[],2);
c6max = max(c6,[],2);
c6min = min(c6,[],2);
c7max = max(c7,[],2);
c7min = min(c7,[],2);
c8max = max(c8,[],2);
c8min = min(c8,[],2);
c9max = max(c9,[],2);
c9min = min(c9,[],2);
c10max = max(c10,[],2);
c10min = min(c10,[],2);
% gc1=c1;
% gc2=c2;
% gc3=c3;
% gc4=c4;
gc1=(c1-c1min*ones(1,540))./((c1max-c1min)*ones(1,540));
gc2=(c2-c2min*ones(1,540))./((c2max-c2min)*ones(1,540));
gc3=(c3-c3min*ones(1,540))./((c3max-c3min)*ones(1,540));
gc4=(c4-c4min*ones(1,540))./((c4max-c4min)*ones(1,540));
gc5=(c5-c5min*ones(1,540))./((c5max-c5min)*ones(1,540));
gc6=(c6-c6min*ones(1,540))./((c6max-c6min)*ones(1,540));
gc7=(c7-c7min*ones(1,540))./((c7max-c7min)*ones(1,540));
gc8=(c8-c8min*ones(1,540))./((c8max-c8min)*ones(1,540));
gc9=(c9-c9min*ones(1,540))./((c9max-c9min)*ones(1,540));
gc10=(c10-c10min*ones(1,540))./((c10max-c10min)*ones(1,540));
%m=mean(gc1(1:1000,:));
m=zeros(1,540);
r1=(gc1(1:n,:)-ones(n,1)*m);
r2=(gc2(1:n,:)-ones(n,1)*m);
r3=(gc3(1:n,:)-ones(n,1)*m);
r4=(gc4(1:n,:)-ones(n,1)*m);
r5=(gc5(1:n,:)-ones(n,1)*m);
r6=(gc6(1:n,:)-ones(n,1)*m);
r7=(gc7(1:n,:)-ones(n,1)*m);
r8=(gc8(1:n,:)-ones(n,1)*m);
r9=(gc9(1:n,:)-ones(n,1)*m);
r10=(gc10(1:n,:)-ones(n,1)*m);
r1m=r1'-mean(r1',2)*ones(1,n);
r2m=r2'-mean(r2',2)*ones(1,n);
r3m=r3'-mean(r3',2)*ones(1,n);
r4m=r4'-mean(r4',2)*ones(1,n);
r5m=r5'-mean(r5',2)*ones(1,n);
r6m=r6'-mean(r6',2)*ones(1,n);
r7m=r7'-mean(r7',2)*ones(1,n);
r8m=r8'-mean(r8',2)*ones(1,n);
r9m=r9'-mean(r9',2)*ones(1,n);
r10m=r10'-mean(r10',2)*ones(1,n);
Sw = (r1m*r1m'+r2m*r2m'+r3m*r3m'+r4m*r4m'+r5m*r5m'+r6m*r6m'+r7m*r7m'+r8m*r8m'+r9m*r9m'+r10m*r10m')/10;
r=[r1;r2;r3;r4;r5;r6;r7;r8;r9;r10];
rm = r'-mean(r',2)*ones(1,n*10);%样本总类内均值
St = rm*rm';
Sb = St - Sw;
% mu0 = mean(r',2);
% mu1 = mean(r1',2);
% mu2 = mean(r2',2);
% mu3 = mean(r3',2);
% Sw = Sw + 0.001*eye(540);
% Sb = exp(-(mu1-mu0)*(mu1-mu0)').*((mu1-mu0)*(mu1-mu0)')+exp(-(mu2-mu0)*(mu2-mu0)').*((mu2-mu0)*(mu2-mu0)')+exp(-(mu3-mu0)*(mu3-mu0)').*((mu3-mu0)*(mu3-mu0)');
[evecs,evals]=eig(Sb,Sw);%evals对角上的数是特征值
[~,I]    = sort(diag(evals),'descend');%特征值降序排列
W=evecs(:,I(1:9));%特征值
W=W./norm(W,2);%归一化
% W1=evecs(:,I(1));
% W1=W1./norm(W1,2);
% W2=evecs(:,I(2));
% W2=W2./norm(W2,2);
% W3=evecs(:,I(3));
% W3=W3./norm(W3,2);
% W4=evecs(:,I(4));
% 
% plot(diag(evals));
% W4=W1./norm(W4,2);
% W5=evecs(:,I(5));
% W5=W2./norm(W5,2);
% W6=evecs(:,I(6));
% W6=W3./norm(W6,2);
% W7=evecs(:,I(7));
% W7=W1./norm(W7,2);
% W8=evecs(:,I(8));
% W8=W2./norm(W8,2);
% W9=evecs(:,I(9));
% W9=W3./norm(W9,2);
% Xresc1= W1'*(gc1-ones(1100,1)*m)';
% Yresc1= W2'*(gc1-ones(1100,1)*m)';
% Zresc1= W3'*(gc1-ones(1100,1)*m)';
% Xresc2= W1'*(gc2-ones(1100,1)*m)';
% Yresc2= W2'*(gc2-ones(1100,1)*m)';
% Zresc2= W3'*(gc2-ones(1100,1)*m)';
% Xresc3= W1'*(gc3-ones(1100,1)*m)';
% Yresc3= W2'*(gc3-ones(1100,1)*m)';
% Zresc3= W3'*(gc3-ones(1100,1)*m)';
% Xresc4= W1'*(gc4-ones(1100,1)*m)';
% Yresc4= W2'*(gc4-ones(1100,1)*m)';
% Zresc4= W3'*(gc4-ones(1100,1)*m)';
% Xresc5= W1'*(gc5-ones(1100,1)*m)';
% Yresc5= W2'*(gc5-ones(1100,1)*m)';
% Zresc5= W3'*(gc5-ones(1100,1)*m)';
% Xresc6= W1'*(gc6-ones(1100,1)*m)';
% Yresc6= W2'*(gc6-ones(1100,1)*m)';
% Zresc6= W3'*(gc6-ones(1100,1)*m)';
% Xresc7= W1'*(gc7-ones(1100,1)*m)';
% Yresc7= W2'*(gc7-ones(1100,1)*m)';
% Zresc7= W3'*(gc7-ones(1100,1)*m)';
% Xresc8= W1'*(gc8-ones(1100,1)*m)';
% Yresc8= W2'*(gc8-ones(1100,1)*m)';
% Zresc8= W3'*(gc8-ones(1100,1)*m)';
% Xresc9= W1'*(gc9-ones(1100,1)*m)';
% Yresc9= W2'*(gc9-ones(1100,1)*m)';
% Zresc9= W3'*(gc9-ones(1100,1)*m)';
% Xresc10= W1'*(gc10-ones(1100,1)*m)';
% Yresc10= W2'*(gc10-ones(1100,1)*m)';
% Zresc10= W3'*(gc10-ones(1100,1)*m)';
% % 投影到三维空间
% % subplot(1,2,1);
% plot3(Xresc1,Yresc1,Zresc1,'r*');
% hold;
% plot3(Xresc2,Yresc2,Zresc2,'g*');
% plot3(Xresc3,Yresc3,Zresc3,'y*');
% plot3(Xresc4,Yresc4,Zresc4,'c*');
% plot3(Xresc5,Yresc5,Zresc5,'m*');
% plot3(Xresc6,Yresc6,Zresc6,'k*');
% plot3(Xresc7,Yresc7,Zresc7,'b*');
% % plot3(Xresc8,Yresc8,Zresc8,'g+');
% % plot3(Xresc9,Yresc9,Zresc9,'b+');
% % plot3(Xresc10,Yresc10,Zresc10,'r+');
% plot3(Xresc8,Yresc8,Zresc8,'Color',[0.1,0.6,0.1],'Marker','*','LineStyle','none');
% plot3(Xresc9,Yresc9,Zresc9,'Color',[0.7,0,0.8],'Marker','*','LineStyle','none');
% plot3(Xresc10,Yresc10,Zresc10,'Color',[0.5,0.5,0.5],'Marker','*','LineStyle','none');
% % plot(Xresc2,'bo');
% % plot(Xresc3,'g.');
% % plot(Xresc4,'y-');

% %投影到二维空间
% plot(Xresc1,Yresc1,'r*');
% hold;
% plot(Xresc2,Yresc2,'g*');
% plot(Xresc3,Yresc3,'y*');
% plot(Xresc4,Yresc4,'c*');
% plot(Xresc5,Yresc5,'m*');
% plot(Xresc6,Yresc6,'k*');
% plot(Xresc7,Yresc7,'b*');
% plot(Xresc8,Yresc8,'go');
% plot(Xresc9,Yresc9,'bo');
% plot(Xresc10,Yresc10,'ro');
% grid on;
mr=[mean(r1);mean(r2);mean(r3);mean(r4);mean(r5);mean(r6);mean(r7);mean(r8);mean(r9);mean(r10)];
% cf = mr*W*W';
cf = mr * (newspace * newspace');
intercept = -0.5*diag(mr*cf');
acc=0;
d = gc1(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==1)/1000;

d = gc2(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==2)/1000;

d = gc3(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==3)/1000;

d = gc4(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==4)/1000;

d = gc5(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==5)/1000;

d = gc6(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==6)/1000;

d = gc7(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==7)/1000;

d = gc8(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==8)/1000;

d = gc9(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==9)/1000;

d = gc10(1:1000,:)*cf'+ones(1000,1)*intercept';
p = 1./(1+exp(-d));
p=p./(sum(p,2)*ones(1,10));
[~,y]=max(p,[],2);
acc=acc+sum(y==10)/1000;

Ac(n/10)=acc/10;
% end
% figure
% plot(Ac)
function [train_dataset, val_dataset, test_dataset, num_train, num_val, num_test] = MIT_BIH_loaddata()

load MIT_BIH_data.mat

train_dataset = MIT_BIH_data_train;
val_dataset = MIT_BIH_data_val;
test_dataset = MIT_BIH_data_test;


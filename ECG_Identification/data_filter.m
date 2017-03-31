function [qrs_on, qrs_off, qrs_num, dat_smo, merge_bwr, smo_bwr] = data_filter(src_dat, fs)
dat_flt = kfilter(src_dat, floor(fs/50));    % 50����Ƶ, �˵�50Hz��Ƶ�ź�
lin_seg = kfilter(dat_flt, floor(fs/20));    % �����˲�, �õ�QRS�߽�
tmp_diff = dat_flt - lin_seg;

[~, qrs_on, ~, qrs_num] = qrs_boundary_v3(tmp_diff, fs);  % �õ�QRS����������λ��

qrs_int = zeros(qrs_num - 1, 1);   % ȡ��qrs_num-1����������
for i = 1 : qrs_num - 1
    qrs_int(i) = qrs_on(i + 1) - qrs_on(i);   % ÿ�������ĵ��ź����ڵĳ���
end

lin_seg = kfilter(dat_flt, floor(mean(qrs_int) / 20));
tmp_diff = dat_flt - lin_seg;
[qrs_mask, qrs_on, qrs_off, qrs_num] = qrs_boundary_v3(tmp_diff, fs);  % �õ����Ӿ�׼��QRS��������յ�����

dat_merge = mymerge(lin_seg, src_dat, src_dat, qrs_mask);   % �������˲�������������δ�����Ԫ����QRS�����ں�

qrs_width = qrs_off - qrs_on;

dat_smo = kfilter(dat_merge, floor(mean(qrs_width) / 10));  % ��QRS�����˲�, dat_smoΪ������Ƶ�����˲���Ĳ���
merge_bwr = bwr(dat_merge, lin_seg, fs);      % �԰���ԭʼQRS���κͽ�QRS�����˲��Ĳ��ζ����л���Ư���˲�
smo_bwr = bwr(dat_smo, lin_seg, fs);          % �˲�����, dat_smo, merge_bwr, smo_bwr������Ϊ�˲��������
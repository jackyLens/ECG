function [qrs_on, qrs_off, qrs_num, dat_smo, merge_bwr, smo_bwr] = data_filter(src_dat, fs)
dat_flt = kfilter(src_dat, floor(fs/50));    % 50代表工频, 滤掉50Hz工频信号
lin_seg = kfilter(dat_flt, floor(fs/20));    % 继续滤波, 得到QRS边界
tmp_diff = dat_flt - lin_seg;

[~, qrs_on, ~, qrs_num] = qrs_boundary_v3(tmp_diff, fs);  % 得到QRS波的数量和位置

qrs_int = zeros(qrs_num - 1, 1);   % 取出qrs_num-1个完整波形
for i = 1 : qrs_num - 1
    qrs_int(i) = qrs_on(i + 1) - qrs_on(i);   % 每个完整心电信号周期的长度
end

lin_seg = kfilter(dat_flt, floor(mean(qrs_int) / 20));
tmp_diff = dat_flt - lin_seg;
[qrs_mask, qrs_on, qrs_off, qrs_num] = qrs_boundary_v3(tmp_diff, fs);  % 得到更加精准的QRS波形起点终点坐标

dat_merge = mymerge(lin_seg, src_dat, src_dat, qrs_mask);   % 将二次滤波的线性数据与未处理的元数据QRS部分融合

qrs_width = qrs_off - qrs_on;

dat_smo = kfilter(dat_merge, floor(mean(qrs_width) / 10));  % 对QRS进行滤波, dat_smo为完整工频干扰滤波后的波形
merge_bwr = bwr(dat_merge, lin_seg, fs);      % 对包含原始QRS波形和将QRS进行滤波的波形都进行基线漂移滤波
smo_bwr = bwr(dat_smo, lin_seg, fs);          % 滤波结束, dat_smo, merge_bwr, smo_bwr均可作为滤波后的数据
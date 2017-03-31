function [locs, peaks, locs_sgn, len] = my_findpeaks_v2(x)

coe = 0.1;
[~, pos_locs_tmp] = findpeaks(x);
[~, neg_locs_tmp] = findpeaks(-1 * x);

len_pos = length(pos_locs_tmp);
len_neg = length(neg_locs_tmp);
locs_tmp = [pos_locs_tmp; neg_locs_tmp];
peaks_tmp = x(locs_tmp);
locs_tmp_sgn = [ones(len_pos, 1); -1 * ones(len_neg, 1)];
len_tmp = len_pos + len_neg;

if len_tmp > 1
    % remove glitch peaks
    [~, locs_sort_idx] = sort(locs_tmp);
    ftsg = zeros(len_tmp, 1);
    ftsg(1) = abs(2 * peaks_tmp(locs_sort_idx(1)) - x(1) - peaks_tmp(locs_sort_idx(2)));
    ftsg(len_tmp) = abs(2 * peaks_tmp(locs_sort_idx(len_tmp)) - x(end) - peaks_tmp(locs_sort_idx(len_tmp - 1)));
    for i = 2 : len_tmp - 1
        ftsg(i) = abs(2 * peaks_tmp(locs_sort_idx(i)) - peaks_tmp(locs_sort_idx(i - 1)) - peaks_tmp(locs_sort_idx(i + 1)));
    end
    ftsg_max = max(ftsg);
    
    i = 1;
    rmv_idx = 0;
    while i <= len_tmp
        if ftsg(i) < coe * ftsg_max
            if i == len_tmp || i == 1
                rmv_idx = [rmv_idx ; locs_sort_idx(i)];
                i = i + 1;
            else
                rmv_idx = [rmv_idx ; locs_sort_idx(i : i + 1)];
                i = i + 2;
            end
        else
            i = i + 1;
        end
    end
    rmv_idx = rmv_idx(2 : end);
    locs_tmp(rmv_idx) = [];
    peaks_tmp(rmv_idx) = [];
    locs_tmp_sgn(rmv_idx) = [];
    len_tmp = len_tmp - length(rmv_idx);
    
    % remove redundant peaks
    if len_tmp > 3
        [~, locs_sort_idx] = sort(locs_tmp);
        ftsg = zeros(len_tmp - 2, 1);
        for i = 1 : len_tmp - 2
            ftsg(i) = abs(2 * peaks_tmp(locs_sort_idx(i + 1)) - peaks_tmp(locs_sort_idx(i)) - peaks_tmp(locs_sort_idx(i + 2)));
        end
        [~, ftsg_idx] = max(ftsg);
        pick_idx = [locs_sort_idx(ftsg_idx); locs_sort_idx(ftsg_idx + 1); locs_sort_idx(ftsg_idx + 2)];
        locs_tmp = locs_tmp(pick_idx);
        peaks_tmp = peaks_tmp(pick_idx);
        locs_tmp_sgn = locs_tmp_sgn(pick_idx);
        len_tmp = 3;
    end
end

locs = locs_tmp;
peaks = peaks_tmp;
locs_sgn = locs_tmp_sgn;
len = len_tmp;

end
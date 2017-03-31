function [w_class, w1_peak, w2_peak, w3_peak] = wav_classify_v2(x, ref, notice_th)

[locs_tmp, peaks_tmp, locs_tmp_sgn, len] = my_findpeaks_v2(x);

switch len
    case 0
        w_class = 0;
        w1_peak = 0;
        w2_peak = 0;
        w3_peak = 0;
    case 1
        w_class = locs_tmp_sgn(1);
        w1_peak = locs_tmp(1);
        w2_peak = 0;
        w3_peak = 0;
    case 2
        peaks_tmp_rel = peaks_tmp - ref;   %qy20150802
        peaks_tmp_abs = abs(peaks_tmp_rel);
        [peaks_sort, peaks_sort_idx] = sort(peaks_tmp_abs, 'descend');
        if peaks_sort(2) > notice_th && peaks_tmp_rel(1) * peaks_tmp_rel(2) < 0 && peaks_sort(2) / peaks_sort(1) > 0.5
            [locs_sort, locs_sort_idx] = sort(locs_tmp);
            w_class = 2 * locs_tmp_sgn(locs_sort_idx(1));
            w1_peak = locs_sort(1);
            w2_peak = locs_sort(2);
            w3_peak = 0;
        elseif peaks_sort(1) > notice_th
            w_class = locs_tmp_sgn(peaks_sort_idx(1));
            w1_peak = locs_tmp(peaks_sort_idx(1));
            w2_peak = 0;
            w3_peak = 0;
        else
            w_class = 0;
            w1_peak = 0;
            w2_peak = 0;
            w3_peak = 0;
        end
    case 3
        peaks_tmp_rel = peaks_tmp - ref;
        peaks_tmp_abs = abs(peaks_tmp_rel);
        [peaks_sort, peaks_sort_idx] = sort(peaks_tmp_abs, 'descend');
        if peaks_sort(3) > notice_th && abs(sum(peaks_tmp_rel(1 : 3))) == 3
            [locs_sort, locs_sort_idx] = sort(locs_tmp);
            w_class = 3 * locs_tmp_sgn(locs_sort_idx(1));
            w1_peak = locs_sort(1);
            w2_peak = locs_sort(2);
            w3_peak = locs_sort(3);
        elseif peaks_sort(2) > notice_th
            if locs_tmp_sgn(peaks_sort_idx(1)) == locs_tmp_sgn(peaks_sort_idx(2)) ...
                    && peaks_tmp_rel(peaks_sort_idx(2)) / peaks_tmp_rel(peaks_sort_idx(1)) < -0.5
                w_class = locs_tmp_sgn(peaks_sort_idx(1));
                w1_peak = locs_tmp(peaks_sort_idx(1));
                w2_peak = 0;
                w3_peak = 0;
            else
                if locs_tmp(peaks_sort_idx(1)) < locs_tmp(peaks_sort_idx(2))
                    w_class = 2 * locs_tmp_sgn(peaks_sort_idx(1));
                    w1_peak = locs_tmp(peaks_sort_idx(1));
                    w2_peak = locs_tmp(peaks_sort_idx(2));
                    w3_peak = 0;
                else
                    w_class = 2 * locs_tmp_sgn(peaks_sort_idx(2));
                    w1_peak = locs_tmp(peaks_sort_idx(2));
                    w2_peak = locs_tmp(peaks_sort_idx(1));
                    w3_peak = 0;
                end
            end
        elseif peaks_sort(1) > notice_th
            w_class = locs_tmp_sgn(peaks_sort_idx(1));
            w1_peak = locs_tmp(peaks_sort_idx(1));
            w2_peak = 0;
            w3_peak = 0;
        else
            w_class = 0;
            w1_peak = 0;
            w2_peak = 0;
            w3_peak = 0;
        end
end

end


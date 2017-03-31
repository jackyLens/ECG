function [p_class, p_on, p1_peak, p2_peak, p3_peak, p_off, x_point, j_point, t_class, t_on, t1_peak, t2_peak, t3_peak, t_off] = pt_extract_v2(x, qrs_on, q_peak, r_peak, s_peak, qrs_off)
len = length(qrs_on);
p_class = zeros(len, 1);
p_on = zeros(len, 1);
p1_peak = zeros(len, 1);
p2_peak = zeros(len, 1);
p3_peak = zeros(len, 1);
p_off = zeros(len, 1);
x_point = zeros(len, 1);
j_point = zeros(len, 1);
t_class = zeros(len, 1);
t_on = zeros(len, 1);
t1_peak = zeros(len, 1);
t2_peak = zeros(len, 1);
t3_peak = zeros(len, 1);
t_off = zeros(len, 1);

tp_sep = zeros(len - 1, 1);
tp_bg = zeros(len - 1, 1);
tp_ed = zeros(len - 1, 1);
coe_p = 0.02;
coe_t = 0.1;

% strategy : quit the first P wave and the last T wave
for i = 1 : len - 1
%     if r_peak(i) ~= 0 && r_peak(i + 1) ~= 0
%         tp_bg(i) = r_peak(i);
%         tp_ed(i) = r_peak(i + 1);
%     elseif s_peak(i) ~= 0 && q_peak(i + 1) ~= 0
%         tp_bg(i) = s_peak(i);
%         tp_ed(i) = q_peak(i + 1);
%     else
%         tp_bg(i) = 0;
%         tp_ed(i) = 0;
%     end
    tp_bg(i) = qrs_off(i);
    tp_ed(i) = qrs_on(i + 1);
end

x_point(1) = qrs_on(1);
j_point(len) = qrs_off(len);   %qy20150731
qrs_ext = x(qrs_on(i) : qrs_off(i));
MAX_diff = max(qrs_ext) - min(qrs_ext);   %qy20150802

for i = 1 : len - 1
    if tp_bg(i) ~= 0 && tp_ed(i) ~= 0
        tp_sep(i) = floor((tp_ed(i) - tp_bg(i)) * 3 / 5) + tp_bg(i);   % seperation of t wave and p wave between s_peak(i) and q_peak(i+1)      
        
        % p wave detection
        notice_th = coe_p * MAX_diff;
        local_ref = x(qrs_on(i + 1));
%         if q_peak(i + 1) ~= 0
%             [p_class_rel, p1_peak_rel, p2_peak_rel, p3_peak_rel] = wav_classify_v2(x(tp_sep(i) : q_peak(i + 1)), local_ref, notice_th);
%         else
%             [p_class_rel, p1_peak_rel, p2_peak_rel, p3_peak_rel] = wav_classify_v2(x(tp_sep(i) : qrs_on(i + 1)), local_ref, notice_th);
%         end
        [p_class_rel, p1_peak_rel, p2_peak_rel, p3_peak_rel] = wav_classify_v2(x(tp_sep(i) : qrs_on(i + 1)), local_ref, notice_th);
        p_class(i + 1) = p_class_rel;
        p1_peak(i + 1) = p1_peak_rel + (tp_sep(i) - 1) * (p1_peak_rel ~= 0);
        p2_peak(i + 1) = p2_peak_rel + (tp_sep(i) - 1) * (p2_peak_rel ~= 0);
        p3_peak(i + 1) = p3_peak_rel + (tp_sep(i) - 1) * (p3_peak_rel ~= 0);

        % p_off and x_point detection
        switch abs(p_class(i + 1))
            case 0
                locs_end = 0;
            case 1
                locs_end = p1_peak(i + 1);
                dir_end = p_class(i + 1);
            case 2
                locs_end = p2_peak(i + 1);
                dir_end = -1 * sign(p_class(i + 1));
            case 3
                locs_end = p3_peak(i + 1);
                dir_end = sign(p_class(i + 1));
        end
        if q_peak(i + 1) ~= 0
            ew = q_peak(i + 1);
            dir_ew = -1;
        else
            ew = r_peak(i + 1);
            dir_ew = 1;
        end
        if locs_end == 0
            p_off(i + 1) = 0;
            x_point(i + 1) = qrs_on(i + 1);
        else
            [p_off_rel, x_point_rel] = local_trans_curve_v2(x(locs_end : ew), dir_end, dir_ew);
            p_off(i + 1) = p_off_rel + (locs_end - 1) * (p_off_rel ~= 0);
            x_point(i + 1) = x_point_rel + (locs_end - 1) * (x_point_rel ~= 0);
        end

        % t wave detection
        notice_th = coe_t * MAX_diff;
        local_ref = x(qrs_on(i));
%         if s_peak(i) ~= 0
%             [t_class_rel, t1_peak_rel, t2_peak_rel, t3_peak_rel] = wav_classify_v2(x(s_peak(i) : tp_sep(i)), local_ref, notice_th);
%             t_start = s_peak(i);
%         else
%             [t_class_rel, t1_peak_rel, t2_peak_rel, t3_peak_rel] = wav_classify_v2(x(qrs_off(i) : tp_sep(i)), local_ref, notice_th);
%             t_start = qrs_off(i);
%         end
        [t_class_rel, t1_peak_rel, t2_peak_rel, t3_peak_rel] = wav_classify_v2(x(qrs_off(i) : tp_sep(i)), local_ref, notice_th);
        t_start = qrs_off(i);
        t_class(i) = t_class_rel;
        t1_peak(i) = t1_peak_rel + (t_start - 1) * (t1_peak_rel ~= 0);
        t2_peak(i) = t2_peak_rel + (t_start - 1) * (t2_peak_rel ~= 0);
        t3_peak(i) = t3_peak_rel + (t_start - 1) * (t3_peak_rel ~= 0);

        % j_point and t_on detection
        if s_peak(i) ~= 0
            bw = s_peak(i);
            dir_bw = -1;
        else
            bw = r_peak(i);
            dir_bw = 1;
        end
        if t_class(i) == 0
            t_on(i) = 0;
            j_point(i) = qrs_off(i);
        else
            [j_point_rel, t_on_rel] = local_trans_curve_v2(x(bw : t1_peak(i)), dir_bw, sign(t_class(i)));
            t_on(i) = t_on_rel + (bw - 1) * (t_on_rel ~= 0);
            j_point(i) = j_point_rel + (bw - 1) * (j_point_rel ~= 0);
        end

        % t_off and p_on detection
        switch abs(t_class(i))
            case 0
                locs_end = bw;
                dir_end = -1;
            case 1
                locs_end = t1_peak(i);
                dir_end = t_class(i);
            case 2
                locs_end = t2_peak(i);
                dir_end = -1 * sign(t_class(i));
            case 3
                locs_end = t3_peak(i);
                dir_end = sign(t_class(i));
        end
        if p_class(i + 1) == 0
            locs_start = ew;
            dir_start = dir_ew;
        else
            locs_start = p1_peak(i + 1);
            dir_start = sign(p_class(i + 1));
        end

        [t_off_rel, p_on_rel] = local_trans_curve_v2(x(locs_end : locs_start), dir_end, dir_start);
        if t_class(i) == 0
            t_off(i) = 0;
        else
            t_off(i) = t_off_rel + (locs_end - 1) * (t_off_rel ~= 0);
        end
        if p_class(i + 1) == 0
            p_on(i + 1) = 0;
        else
            p_on(i + 1) = p_on_rel + (locs_end -1) * (p_on_rel ~= 0);
        end
    end
end

end

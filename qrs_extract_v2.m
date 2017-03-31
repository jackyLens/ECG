function [q_peak, r_peak, rp_peak, s_peak] = qrs_extract_v2(x, qrs_on, qrs_off)
len = length(qrs_on);
q_peak = zeros(len, 1);
r_peak = zeros(len, 1);
rp_peak = zeros(len, 1);
s_peak = zeros(len, 1);

for i = 1 : len
    % r_peak detection
    [pos_peak, pos_locs] = findpeaks(x(qrs_on(i) : qrs_off(i)));
    pos_peak_num = length(pos_locs);
    switch pos_peak_num
        case 0
            r_peak(i) = 0;
        case 1
            if pos_peak(1) > x(qrs_on(i))
                r_peak(i) = pos_locs(1) + qrs_on(i) - 1;
            else
                r_peak(i) = 0;
            end
        otherwise
            pos_locs_absolute = pos_locs + qrs_on(i) - 1;   % vector
            r_derivative = zeros(pos_peak_num, 1);
            for j = 1 : pos_peak_num
                r_derivative(j) = 2 * pos_peak(j) - x(pos_locs_absolute(j) - 2) - x(pos_locs_absolute(j) + 2);
            end
            r_derivative_norm = (r_derivative - min(r_derivative)) / (max(r_derivative) - min(r_derivative));
            pos_peak_norm = (pos_peak - min(pos_peak)) / (max(pos_peak) - min(pos_peak));
            r_feature = pos_peak_norm + r_derivative_norm;
            [~, ridx] = max(r_feature);
            r_peak(i) = pos_locs_absolute(ridx);
    end
    
    if r_peak(i) == 0
 
        [neg_peak, neg_locs] = findpeaks(-1 * x(qrs_on(i) : qrs_off(i)));
        if isempty(neg_locs)
            q_peak(i) = 0;
            s_peak(i) = 0;
        else   % QS
            [~, idx_tmp] = max(neg_peak);
            q_peak(i) = neg_locs(idx_tmp) + qrs_on(i) - 1;
            s_peak(i) = q_peak(i);
        end
        rp_peak(i) = 0;
    else
        % q_peak detection
        if r_peak(i) - qrs_on(i) > 1
            [neg_q_peak, neg_q_locs] = findpeaks(-1 * x(qrs_on(i) : r_peak(i)));
            if ~isempty(neg_q_locs)
                [~, idx_tmp] = max(neg_q_peak);
                q_peak(i) = neg_q_locs(idx_tmp) + qrs_on(i) - 1;
            end
        end

        % s_peak detection
        if qrs_off(i) - r_peak(i) > 1
            [neg_s_peak, neg_s_locs] = findpeaks(-1 * x(r_peak(i) : qrs_off(i)));
            if ~isempty(neg_s_locs)
                [~, idx_tmp] = max(neg_s_peak);
                s_peak(i) = neg_s_locs(idx_tmp) + r_peak(i) - 1;
            end
        end
    end
 
end

end


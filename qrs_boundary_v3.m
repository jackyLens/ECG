function [qrs_mask, qrs_on, qrs_off, qrs_num] = qrs_boundary_v3(x, fs)

% qrs_mask threshold initialize, not adaptive, for short time interval
coe_2 = 0.6;
% coe_1 = 0.3;
coe_1 = 0.2;
% coe_2 = 0.4;
% coe_1 = 0.2;
mask_ftsg = -1 * abs(x);
min_peak = min(mask_ftsg);
mask_2_th = coe_2 * min_peak;
mask_1_th = coe_1 * min_peak;


% qrs_mask
mask = zeros(length(mask_ftsg), 1);
[~, pos_peak_idx] = findpeaks(mask_ftsg);
i = 1;
while i < length(pos_peak_idx)
    neg_peak = min(mask_ftsg(pos_peak_idx(i) : pos_peak_idx(i + 1)));
    if neg_peak <= mask_2_th
        mask(pos_peak_idx(i) : pos_peak_idx(i + 1)) = 2;
    elseif neg_peak <= mask_1_th
            mask(pos_peak_idx(i) : pos_peak_idx(i + 1)) = 1;
    end
    i = i + 1;
end

% qrs_complex threshold initialize, adaptive
ftsg = mask;
qrs_counter = 0;   % qrs_complex counter
flag = 0;   % 150116 change the use for inflect mask == 2 has come
qrs_on_tmp = [];
qrs_off_tmp = [];
qrs_mask_tmp = zeros(length(mask_ftsg), 1);
qrs_on_idx = 1;
i = 1;
while i < length(ftsg)
    if ftsg(i) > 0 && ftsg(i + 1) == 0
        if flag == 1
            jumped = 0;
            if i + floor(fs * 0.02) < length(ftsg)
                if ftsg(i + floor(fs * 0.02)) == 2 
                    i = i + floor(fs * 0.02);
                    jumped = 1;
                end
            end
            if jumped == 0
                flag = 0;
                qrs_on_tmp = [qrs_on_tmp ; qrs_on_idx];
                qrs_off_tmp = [qrs_off_tmp ; i];
                for j = qrs_on_idx : i
                    qrs_mask_tmp(j) = mask(j);
                end
                qrs_counter = qrs_counter + 1;
                i = i + floor(fs * 0.2);   % refactory blanking 200ms
            end
        end
    elseif ftsg(i) == 0 && ftsg(i + 1) > 0
            qrs_on_idx = i + 1;
    elseif ftsg(i) == 2
        flag = 1;
    end
    i = i + 1;
end
    
% refinement - remove the first mis-detected qrs-complex
if(length(qrs_on_tmp) > 1)
    if (qrs_off_tmp(1) - qrs_on_tmp(1)) < 0.6 * (qrs_off_tmp(2) - qrs_on_tmp(2))
        for j = qrs_on_tmp(1) : qrs_off_tmp(1)
            qrs_mask_tmp(j) = 0;
        end
        qrs_on_tmp = qrs_on_tmp(2 : end);
        qrs_off_tmp = qrs_off_tmp(2 : end);
        qrs_counter = qrs_counter - 1;
    end
end

qrs_mask = qrs_mask_tmp;
qrs_on = qrs_on_tmp;
qrs_off = qrs_off_tmp;
qrs_num = qrs_counter; 


% ======================================================
% figure(2);
% plot(ftsg, 'r');
% hold on;
% plot(mask, 'color', [0.5 0.5 0.5]);
% plot(qrs_mask);
% plot(qrs_on, ftsg(qrs_on), 'r>');
% plot(qrs_off, ftsg(qrs_off), 'r<');
% hold off;
% 
% figure(3);
% plot(mask_ftsg, 'color', [0.5 0.5 0.5]);
% hold on;
% plot(-1 * x);
% plot(qrs_mask * -50, 'm');
% hold off;
% grid on;

end


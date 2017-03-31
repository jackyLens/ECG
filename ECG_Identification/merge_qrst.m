function merge_qrs_t = merge_qrst(qrs_on,qrs_off,qrs_num,T)
T = T';
% a = zeros(size(qrs))
T_num = length(T);

if qrs_num < T_num
    a = zeros(qrs_num-1,3);
    index = 1;
    for i = 1:qrs_num-1
        for j = index:T_num
            if T(j) > qrs_on(i) && T(j) < qrs_on(i+1) && T(j) > qrs_off(i) && T(j) < qrs_off(i+1)
                a(i,1) = qrs_on(i);
                a(i,2) = qrs_off(i);
                a(i,3) = T(j);
                index = index + 1;
                break
            end
        end
    end
    b = find(a(:,1)==0);
    a(b,:) = [];
else
    a = zeros(T_num,3);
    index = 1;
    for i = 1:T_num-1
        for j = index:qrs_num
            if T(i) > qrs_on(j) && T(i) < qrs_on(j+1) && T(i) > qrs_off(j) && T(i) < qrs_off(j+1)
                a(i,1) = qrs_on(j);
                a(i,2) = qrs_off(j);
                a(i,3) = T(i);
                index = index + 1;
                break
            end
        end
    end
    b = find(a(:,1)==0);
    a(b,:) = [];
end

merge_qrs_t = a;
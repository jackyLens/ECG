function acc = similarity(newspace, E_r, data_norm, data_num)

cf = E_r * (newspace * newspace');
intercept = -0.5 * diag(E_r * cf');

data_pos = zeros(length(data_num),2);
for i = 1:length(data_num)
    if i == 1
        data_pos(i,1) = 1;
        data_pos(i,2) = data_num(i);
    else
        data_pos(i,1) = data_pos(i-1,2) + 1;
        data_pos(i,2) = sum(data_num(1:i));
    end
end

debug = 0;
if debug
    disp('Check data_pos...');
    data_debug = data_pos(:,2) - data_pos(:,1) + 1;
    if isequal(data_debug,data_num') == 0
        error('Error: data_pos is not equal to the data_num');
    end
end

acc = 0;
for i = 1:length(data_num)
    d = bsxfun(@plus,data_norm(data_pos(i,1):data_pos(i,2),:) * cf',intercept');
    p = 1 ./ (1 + exp(-d));
    p = p ./ (sum(p,2) * ones(1,length(data_num)));
    [~,y] = max(p,[],2);
    acc = acc + sum(y==i) / 1000;
end
acc = acc / length(data_num);
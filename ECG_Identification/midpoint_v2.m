function [mid_point, area, num] = midpoint_v2(x, dir)
len = length(x);
bor = floor(0.1 * len);
der_ftsg = dir * derivative(derivative(x));
ftsg = der_ftsg > 0;
% refinement - remove the border area effect
for i = 1 : bor
    ftsg(i) = 0;
    ftsg(len - i + 1) = 0;
end
mid_point = 0;
area = 0;
start_idx = 1;
i = 1;
while i < len
    if ftsg(i) > 0 && ftsg(i + 1) == 0
        mid_point = [mid_point; floor(0.5 * (start_idx + i))];
        area = [area ; sum(der_ftsg(start_idx : i))];
    elseif ftsg(i) == 0 && ftsg(i + 1) > 0
        start_idx = i + 1;
    end
    i = i + 1;
end

mid_point = mid_point(2 : end);
area = area(2 : end);
num = length(mid_point);

end


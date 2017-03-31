function y = kfilter(x, n)

q = 1;
len = length(x); %len = 6000
m = n;
xx = [zeros(m,1); x; zeros(m,1)];   %前后都补零
yy = zeros(len + 2 * m, 1);  %yy大小和xx一样
%滤波后只能保留中间一段的数据，头和尾会被舍弃掉，因此把头和尾补充起来，使得中间部分变成原始的输入
for j = 1 : m
    xx(j) = x(m - j + 1);   %前m个补零的变成前m个数据倒过来的数据
    xx(len + m + j) = x(len - j + 1);     %后m个补零的变成后m个数据倒过来的数据
end

xx_len = len + 2 * m;

if mod(n / q, 2) == 0
    % n / q is even
    for i = 1 : xx_len
        if (i < n / 2 + 1) || (i > xx_len - n / 2)
            yy(i) = xx(i);
        else       
            j = -(n / (2 * q) - 1) : n / (2 * q) - 1;
            yy(i) = q / n * (sum(xx(i  + j * q)) + (xx(i - n / 2) + xx(i + n / 2)) / 2);
        end
    end 
else
    % n / q is odd
    for i = 1 : xx_len
        if (i < (n - 1) / 2 + 1) || (i > xx_len - (n - 1) / 2)
            yy(i) = xx(i);
        else
            j = -(n / q - 1) / 2 : (n / q - 1) / 2;
            yy(i) = q / n * sum(xx(i  + j * q));
        end
    end    
end

%只取中间len个点，即对应的输入
y = yy(m + 1 : len + m);

end


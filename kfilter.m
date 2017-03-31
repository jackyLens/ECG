function y = kfilter(x, n)

q = 1;
len = length(x); %len = 6000
m = n;
xx = [zeros(m,1); x; zeros(m,1)];   %ǰ�󶼲���
yy = zeros(len + 2 * m, 1);  %yy��С��xxһ��
%�˲���ֻ�ܱ����м�һ�ε����ݣ�ͷ��β�ᱻ����������˰�ͷ��β����������ʹ���м䲿�ֱ��ԭʼ������
for j = 1 : m
    xx(j) = x(m - j + 1);   %ǰm������ı��ǰm�����ݵ�����������
    xx(len + m + j) = x(len - j + 1);     %��m������ı�ɺ�m�����ݵ�����������
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

%ֻȡ�м�len���㣬����Ӧ������
y = yy(m + 1 : len + m);

end


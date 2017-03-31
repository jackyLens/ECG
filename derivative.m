function y = derivative(x)

len = length(x);
y = zeros(len , 1);

if len > 1
    for i = 2 : len - 1
        y(i) = 0.5 * (x(i + 1) - x(i - 1));
    end
    y(1) = x(2) - x(1);
    y(len) = x(len) - x(len - 1);
else
    y(1) = x(1);
end

end


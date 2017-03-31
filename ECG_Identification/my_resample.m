function out = my_resample(in)
p = 540 * 1.1;
[~,q] = size(in);
out = resample(in,p,q);
out = out(1:540);
end


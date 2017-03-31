function y = bwr(x, lin, fs)
temp = lin;
% temp2 = mem_filter(temp, fs / 5);
temp2 = kfilter(temp, floor(fs / 5));
temp3 = kfilter(temp2, fs);
y = x - temp3;


% figure(4);
% subplot(3,1,1);
% plot(x);
% grid on;
% subplot(3,1,2);
% plot(x);
% hold on;
% plot(temp3, 'r');
% hold off;
% grid on;
% subplot(3,1,3);
% plot(temp2);
% hold on;
% plot(temp3, 'r');
% hold off;
% grid on;

end


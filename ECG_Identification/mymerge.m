function y = mymerge( lin, mid, nlin,mask )

% % adjustment coefficient
% b = 5;
% len = length(mask);
% dat_merge = lin .* (1 - mask) + nlin .* mask;
% 
% % smooth the merge-point, by a straight line
% for i = 1 + b : len - 1
%     if xor(mask(i), mask(i+1))
%         r = (dat_merge(i + 1) - dat_merge(i - b)) / (b + 1);
%         for j = 1 : b
%             dat_merge(i + j - b) = dat_merge(i - b) + r * j;
%         end
%     end
% end



y = lin .* (mask == 0) + mid .* (mask == 1) + nlin .* (mask == 2);

% % refinement - remove glitch
% for i = 1 : length(mask) - 1
%     if mask(i) == 0 && mask(i + 1) ~= 0
%         y(i + 1) = lin(i + 1);
%     else if mask(i) ~= 0 && mask(i + 1) == 0
%             y(i) = lin(i);
%         end
%     end
% end

end


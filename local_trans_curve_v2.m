function [inf_bg, inf_ed] = local_trans_curve_v2(x, dir_bg, dir_ed)
if dir_bg == dir_ed
    [mid_point, area, num] = midpoint_v2(x, dir_bg);
    switch num
        case 0
            inf_bg = 0;
            inf_ed = 0;
        case 1
            inf_bg = mid_point(1);
            inf_ed = mid_point(1);
        case 2
            inf_bg = mid_point(1);
            inf_ed = mid_point(2);
%         otherwise
%             [~, aidx] = sort(area, 'descend');
%             if aidx(1) > aidx(2)
%                 inf_bg = mid_point(aidx(2));
%                 inf_ed = mid_point(aidx(1));
%             else
%                 inf_bg = mid_point(aidx(1));
%                 inf_ed = mid_point(aidx(2));
%             end
        otherwise
            inf_bg = mid_point(1);
            inf_ed = mid_point(num);
    end
else
    [mid_point_bg, area_bg, num_bg] = midpoint_v2(x, dir_bg);
    [mid_point_ed, area_ed, num_ed] = midpoint_v2(x, dir_ed);
    switch num_bg
        case 0
            inf_bg = 0;
        case 1
            inf_bg = mid_point_bg(1);
        otherwise
            [~, aidx_bg] = sort(area_bg, 'descend');
            inf_bg = mid_point_bg(aidx_bg(1));
    end
    switch num_ed
        case 0
            inf_ed = 0;
        case 1
            inf_ed = mid_point_ed(1);
        otherwise
            [~, aidx_ed] = sort(area_ed, 'descend');
            inf_ed = mid_point_ed(aidx_ed(1));
    end
    if (inf_bg > inf_ed) && (inf_ed ~= 0)
        half_point = floor(0.5 * length(x));
        if(abs(inf_bg - half_point) < abs(inf_ed - half_point))
            idx = 2;
            while(idx <= num_ed) && (inf_bg > inf_ed)
                inf_ed = mid_point_ed(aidx_ed(idx));
                idx = idx + 1;
            end
            if(inf_bg > inf_ed)
                inf_ed = 0;
            end
        else
            idx = 2;
            while(idx <= num_bg) && (inf_bg > inf_ed)
                inf_bg = mid_point_bg(aidx_bg(idx));
                idx = idx + 1;
            end
            if(inf_bg > inf_ed)
                inf_bg = 0;
            end
        end
    end
%     if (inf_bg > inf_ed) && (inf_ed ~= 0)
%         half_point = floor(0.5 * length(x));
%         if inf_bg < half_point
%             inf_ed = 0;
%         elseif inf_ed > half_point
%             inf_bg = 0;
%         else
%             inf_bg = 0;
%             inf_ed = 0;
%         end
%     end
end

end




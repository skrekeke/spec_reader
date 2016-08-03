function [num_scan, type_scan, num_points, time_per_point, y_title, y_start, y_end ] = S_line_reader( tline )
%S_line_reader reads a head line of scan

%  INPUT:   #S line
%
% OUTPUT:   number of scan
%           type of scan
%           number of points
%           time per point
% by Olena Soroka 
% July 2016
%%
if strfind(tline,'#S')%look for scan-number line
            scan_title = strsplit(tline);
            switch scan_title{3}%to define format of the string
                case 'a2scan' 
                    split_title = textscan(tline, '%*s %d %*s %s %.2f %.2f %*s %*s %*s %d %f', 'Delimiter',' ','MultipleDelimsAsOne',1);
                     [num_scan, y_title, y_start, y_end, num_points_minus_one, time_per_point] = split_title{:};
                     num_points = num_points_minus_one + 1;
                     num_scan = int32(num_scan);
                     type_scan = 1;
                     if strcmp(y_title{1}, 'chi')
                         y_title = 1;
                     else
                         y_title = 0;
                     end
                case 'ascan'
                    split_title = textscan(tline, '%*s %d %*s %s %.2f %.2f %d %f', 'Delimiter',' ','MultipleDelimsAsOne',1);
                     [num_scan, y_title, y_start, y_end, num_points_minus_one, time_per_point] = split_title{:};
                     num_points = num_points_minus_one + 1;
                     num_scan = int32(num_scan);
                     type_scan = 2;
                     if strcmp(y_title{1}, 'del')
                         y_title = 1;
                     else
                         y_title = 0;
                     end
                case 'timescan'
                    split_title = textscan(tline, '%*s %d %*s %d %f', 'Delimiter',' ','MultipleDelimsAsOne',1);
                     [num_scan, time_per_point, ~] = split_title{:};
                     num_scan = int32(num_scan);
                     num_points = Inf;
                     type_scan = 3;
                     y_title = 0;
                     y_start = 0;
                     y_end = 0;
                case 'loopscan'
                     split_title = textscan(tline, '%*s %d %*s %d %f %*d', 'Delimiter',' ','MultipleDelimsAsOne',1);
                     [num_scan, num_points, time_per_point] = split_title{:};
                     num_scan = int32(num_scan);
                     type_scan = 4;
                     y_title = 0;
                     y_start = 0;
                     y_end = 0;
                otherwise
                    display('Error. Unknown scan type.')
            end
else
    display('Error reading the header. Not #S line. Check input of S_line_reader fnc')
end

end


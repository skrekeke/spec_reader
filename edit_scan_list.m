function [ new_num_range, M, time_list_out, index_bool, y_title, y_start, y_end ] = edit_scan_list( scan_info, time_list, scan_type_in, points )
% deletes all scans with wrong scan type or number of points
%   INPUT:  matrix that is output of get_scan_info
%           scan_type_in - needed scan type
%   OUTPUT: new edited vector of scan numbers with length less or equal to
%   initial num_scan`s
% by Olena Soroka 
% July 2016
%%
index_for_one_type = scan_info(:,2) == scan_type_in;
% scan_info_type = scan_info(index_for_one_type,:);% delete scans with other types
% time_list = time_list(index_for_one_type,:);   % delete scans with other types
for i = 1:length(scan_info(:,3))
    if ~index_for_one_type(i)
        scan_info(i,3) = 0;
    end
end
[M,I] = max(scan_info(:,3));
y_title = scan_info(I,4);
y_start = min(scan_info(:,5));
y_end = max(scan_info(:,6));
index_for_one_length = zeros(length(index_for_one_type),1);
for j = 1:length(points)
    index_for_one_length = index_for_one_length | (scan_info(:,3) == points(j));
end
index_bool = index_for_one_length & index_for_one_type;
scan_info_new = scan_info(index_bool,:);%delete scans with other types and less points than Max
new_num_range = scan_info_new(:,1);%delete scans with other types and less points than Max
time_list_out = time_list(index_bool,:);

end


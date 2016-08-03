function [ scans_info, time_list ] = get_scan_info( num_range, file )
% get_scan_info
%   INPUT:   spec file name,
%            range of scan numbers
%   OUTPUT:  2D matrix (N_range, 3): [num_scan, n_points, typescan]
%            vector (N_range,1) of scan's time, equivalent to num_range
% by Olena Soroka 
% July 2016
%%
[fid, ~] = fopen(file,'r');
if fid == -1                
    display('Open failed')
    return;
end

N_range = length(num_range);
scans_info = double(zeros(N_range,6));
time_list = zeros(N_range,1);
n = 0;

tline = fgetl(fid);
while ischar(tline) && n < N_range%unless the end of a file or the end of range of scans
    if length(tline)>=3 && strcmp(tline(1:2),'#S')
        [actual_scan_number, scan_type, n_points,~, y_title, y_start, y_end] = S_line_reader(tline);% read S line
             if ~all(abs(num_range - actual_scan_number))% if this scan number is from the num_range
                 n = n+1;% counter of our scans
                 tline = fgetl(fid);%go to #D line
                  t = datenum(datetime({tline(3:end)}, 'InputFormat',' eee MMM dd HH:mm:ss yyyy'));%read date and time in datenum format
                  time_list(n) = t;
                 while ~(length(tline)<=3 || strcmp(tline(1:2),'#C'))
                     tline = fgetl(fid);
                 end% out with #C or empty line
                 if strfind(tline,'aborted')% check for interupted scans
                     C_line_cell = strsplit(tline);
                     n_points = int32(str2double(C_line_cell{end-1}));
                 end
                 scans_info(n,1:4) = [num_range(n), scan_type, n_points, y_title];
                 scans_info(n,5:6) = [y_start, y_end];
             end
    end
    tline = fgetl(fid);
end
fclose('all');  
end



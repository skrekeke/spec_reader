
function [all_scans, num_range, time_list, y_titlem, y_startm, y_endm] = specreader_with_NaN( num_range, scan_type_in, points )
%import data of specified scan numbers to a matrix
% INPUT: range of scan numbers
%        type of scans
% OUTPUT: 3D matrix dimensions: [N_points, 2, N_of_edited_scans]
%                   fields:     [number of point, Intensity, index of scan in new_num_range matrix]
%         vector    list of spec-numbers of scans 
% 
% by Olena Soroka 
% July 2016
%% Input
file = 'D:\Data\ESRF 2016\MA-2866\Alignment_SixC.spec';
num_range = int32(num_range);%later must make as input of specreader function 
% scan_type_in = 1;% 'a2scan'   => 1
                 % 'ascan'    => 2
                 % 'timescan' => 3
                 % 'loopscan' => 4
%% delete short scans or scans with wrong type
[scan_info, time_list] = get_scan_info( num_range, file );
[~, N_points, ~, index_bool, y_titlem, y_startm, y_endm] = edit_scan_list( scan_info, time_list, scan_type_in, points );
if isempty(num_range)
    display('no scans were found with this type in this range')
    return
end

[fid, massage] = fopen(file,'r');
if fid == -1                
    display('Open failed')
    return;
end
%% init
N_range = length(num_range);
all_scans = zeros(N_points, 2, N_range);
nn = 0;
ss = int32(0);
%% read data
tline = fgetl(fid);
while ischar(tline) && nn < num_range(N_range) %while the end of a file or a range of scans
    if length(tline) <=3% omit empty lines
         tline = fgetl(fid);
    end
    if strcmp(tline(1:2),'#S')
        nn = nn+1;% all scans counter 1:new_scan_range(end)
%        display(tline); %deal with #S line
         if ~all(abs(num_range - nn))% nn >= new_scan_range(1) && nn <= new_scan_range(N_range)% if this scan number is from the edited num_range
             ss = ss + 1; % our scans counter 1:N_range
             while ~(strcmp(tline(1:2),'#L'))
                 tline = fgetl(fid);
             end
             %do something with #L line?
             tline = fgetl(fid);
             count_points = int32(0);
             
             if ~index_bool(ss)% if wrong type and length of scan, fill this scans with NaN
                 all_scans(:,2,ss) = NaN;
                 all_scans(:,1,ss) = y_startm:(y_endm-y_startm)/(N_points-1):y_endm;
                 while ~(length(tline)<=3 || strcmp(tline(1:2),'#C'))%skiping data
                     tline = fgetl(fid);
                 end
             else
                 if y_startm < scan_info(ss,5)
                     period = (scan_info(ss,6) - scan_info(ss,5))/(scan_info(ss,3)-1);
                     count_points = int32((scan_info(ss,5) - y_startm)/period +1);
                      all_scans(1:count_points, :, ss) = NaN;
                 end
                 while ~(length(tline)<=3 || strcmp(tline(1:2),'#C'))%reading data
                     count_points = count_points + 1;
                     [angle, intensity] = data_line_r(tline);
                     all_scans(count_points,:, ss) = [angle,intensity];
                     tline = fgetl(fid);
                 end
                 if y_endm > scan_info(ss,6)
                     period = (scan_info(ss,6) - scan_info(ss,5))/(scan_info(ss,3)-1);
                     count_points = (y_endm - scan_info(ss,6))/period +1;
                      all_scans(end:-1:(end - count_points), :, ss) = NaN;
                 end
             end
             if strfind(tline,'aborted')% check for interupted scans
                 sprintf('\n short scan # %d got through!\n Intensity at 1st point - %f,\n\t\t\t at last - %f', nn, all_scans(1,2,ss),all_scans(end,2,ss))
%                  C_line_cell = strsplit(tline);
%                  points_aborted = num2double(C_line_cell{end-1});
             end

         else
             while ~ (length(tline)<= 3)
                tline = fgetl(fid);
             end% exit with tline = empty line
         end
    else
        tline = fgetl(fid); %% ???
    end
end%while
fclose('all');        
end



function [all_scans, new_scan_range, new_time_list] = specreader( num_range, scan_type_in )
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
[new_scan_range, N_points, new_time_list,~] = edit_scan_list( scan_info, time_list, scan_type_in );
if isempty(new_scan_range)
    display('no scans were found with this type in this range')
    return
end

[fid, massage] = fopen(file,'r');
if fid == -1                
    display('Open failed')
    return;
end
%% init
N_range = length(new_scan_range);
all_scans = zeros(N_points, 2, N_range);
nn = 0;
ss = 0;
%% read data
tline = fgetl(fid);
while ischar(tline) && nn < new_scan_range(N_range) %while the end of a file or a range of scans
    if length(tline) <=3% omit empty lines
         tline = fgetl(fid);
    end
    if strcmp(tline(1:2),'#S')
        nn = nn+1;% all scans counter 1:new_scan_range(end)
%        display(tline); %deal with #S line
         if ~all(abs(new_scan_range - nn))% nn >= new_scan_range(1) && nn <= new_scan_range(N_range)% if this scan number is from the edited num_range
             ss = ss + 1; % our scans counter 1:N_range
             while ~(strcmp(tline(1:2),'#L'))
                 tline = fgetl(fid);
             end
             %do something with #L line?
             tline = fgetl(fid);
             count_points = 0;
             while ~(length(tline)<=3 || strcmp(tline(1:2),'#C'))%reading data
                 count_points = count_points + 1;
                 [angle, intensity] = data_line_r(tline);
                 all_scans(count_points,:, ss) = [angle,intensity];
                 tline = fgetl(fid);
             end
             if strfind(tline,'aborted')% check for interupted scans
                 sprintf('short scan # %d got through!!!', nn)
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


function [ angle, int ] = data_line_r( tline )
% reads the 1 pair of data
%  INPUT: line of the spec file, after #L line and before #C or #S line
% OUTPUT: angle and intensity on the detector
% by Olena Soroka 
% July 2016
%%
split_data = strsplit(tline);
angle = str2double(split_data{1}); 
int = str2double(split_data{end});

end


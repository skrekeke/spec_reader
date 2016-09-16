function [ data_bkgrndless ] = background_subs(  x, data, type, value, is_Display )
%BACKGROUND_SUBS substrates backround of stated type and value 
%   data - vector column of YData
%   type - string [const, ]
%   value - array of parameters
% x - vector column of XData
switch type
    case 'const'
        data_bkgrndless = data - repmat(value, length(data(:,end)),1);
    otherwise
        display('There is only constant background type yet')
end
if is_Display
    figure
    plot(x, data, '--b', x, data_bkgrndless, '-r')% 
end
        

end


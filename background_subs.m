function [ data_bkgrndless ] = background_subs(  x, data, type, value, is_Display )
%BACKGROUND_SUBS subtracts backround of stated type and value 
%   data - nxm array, where n - number of points in 1 scan, m - number of
%   scans
%   type - string [const, ]
%   value - array of parameters
% x - vector column of XData
switch type
    case 'const'
        data_bkgrndless = data - repmat(value, [size(data)],1);
    case 'lin'
        for l = length(data(end,:)):-1:1
            a = data(1,l);
            b = data(end,l);
            xa = repmat(x(1), length(x),1);
            xb = repmat(x(end), length(x),1);
            bkgrd = b.*(xb - x)./(xb - xa);
            data_bkgrndless(:,l) = data(:,l) - bkgrd;
            if is_Display
                figure
                plot(x, data(:,l), '--b', x, bkgrd, '--c')% 
            end
        end        
    otherwise
        display('There is only constant background type yet')
end

        

end


function [ k, b ] = lin_backgr(  x, data, type, is_Display )
%   lin_bkgrd finds coefficients for linear background y = kx + b
%   data - nxm array, where n - number of points in 1 scan, m - number of
%   scans
%   type - string [const, lin]
% x - vector column of XData
switch type
    case 'const'
        for l = length(data(end,:)):-1:1
            b(l) = min(data(:,l));
            k(l) = 0;
        end
    case 'lin'
        for l = length(data(end,:)):-1:1
            ya = data(1,l);
            yb = data(end,l);
            xa = x(1);
            xb = x(end);
            b(l) = ya - xa.*(yb - ya)./(xb - xa);
            k(l) = (yb - ya)./(xb - xa);
            if is_Display
                figure
                plot(x, data(:,l), '-b', x, k(l).*x + b(l), '-c')% 
            end
        end        
    otherwise
        display('There is only linear background type yet')
        k = NaN;
        b = NaN;
end

        

end


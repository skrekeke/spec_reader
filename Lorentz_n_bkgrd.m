function  [y,g]  = Lorentz_n_bkgrd( x, p, n )
%LORENTZ_N Summary of this function goes here
%   n - number of Lorentzian peaks,
%   a - amplitude,
%   w - width,
%   b, k - coefficients of linear noise, 
%   p = [a1,a2,a3, w1,w2,w3, x01,x02,x03, b, k]
%   x0 - mean location

switch n
    case 1
        a = p(1);
        w = p(2);
        x0 = p(3);
        b = p(4);
        k = p(5);
        y = a./(((x-x0)./w).^2 + 1) + b.*x + k;
    case 2
        a = [p(1), p(2)];
        w = [p(3), p(4)];
        x0 = [p(5), p(6)];
        b = p(7);
        k = p(8);
        y = a(1)./(((x-x0(1))./w(1)).^2 + 1) + a(2)./(((x-x0(2))./w(2)).^2 + 1) + b.*x + k;
    case 3
        a = [p(1), p(2), p(3)];
        w = [p(4), p(5), p(6)];
        x0 = [p(7), p(8), p(9)];
        b = p(10);
        k = p(11);
        y = a(1)./(((x-x0(1))./w(1)).^2 + 1) + a(2)./(((x-x0(2))./w(2)).^2 + 1) + a(3)./(((x-x0(3))./w(3)).^2 + 1) + b.*x + k;
    case 0
        b = p(end-1);
        k = p(end);
        y = b.*x + k;
    otherwise
        display('number of peaks exceeds 3.')
        y = -1;
end  
end


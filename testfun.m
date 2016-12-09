function  y  = testfun( x, p, n, ydata )
%testfun Summary of this function goes here
%   n - number of peaks,
%   a - linear coefficients, not used
%   w - vector of widths,
%   b, k - coefficients of linear noise, not used
%   p = [w1,w2,w3, x01,x02,x03, b, k]
%   x0 - vector of mean locations
A = zeros(length(x), n+2);
switch n
%     case 0
%         b = p(end-1);
%         k = p(end);
    case 1
%         a = p(1);
        w = p(2);
        x0 = p(3);
%         b = p(4);
%         k = p(5);
    case 2
%         a = [p(1), p(2)];
        w = [p(3), p(4)];
        x0 = [p(5), p(6)];
%         b = p(7);
%         k = p(8);
    case 3
%         a = [p(1), p(2), p(3)];
        w = [p(4), p(5), p(6)];
        x0 = [p(7), p(8), p(9)];
%         b = p(10);
%         k = p(11);
end
for i=1:n
    A(:,i) = exp(-log(2).*( (x-x0(i))./w(i) ).^2);

end
A(:,end) = ones(length(x),1);
A(:,end-1) = x;

lc = A\ydata;

y = A*lc;

end


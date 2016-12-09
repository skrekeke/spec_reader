function [ p_struct ] = fit_peaks( x, data, Input, type, is_Display )
%FIT_PEAKS fits with lorentzian(s) or gaissian(s)
%   INPUT   x  - vector column of Xdata, [Scan_length,1],
        %   data - matrix [Scan_length,Number of scans]
        %   type - string, the curve type: 'gauss', 'lorentz'
%   OUTPUT  peaks - a 3d array of dimentions [Scan_length, number_of_peaks,Number of scans] 
%           gof -  structure of goodness of fit,

% data = background_subs(x, data, 'const', min(data), 0);


[~, ~, ~, init_guess_struct] = peak_extractor( Input, data, 1);
[k_init, b_init] = lin_backgr(  x, data, 'lin', 0 )
k_lb = min(k_init.*2, repmat(0, [size(k_init), 1]));
k_ub = max(k_init.*2, repmat(0, [size(k_init), 1]));
b_lb = min(b_init.*2, repmat(0, [size(b_init), 1]));
b_ub = max(b_init.*2, repmat(0, [size(b_init), 1]));

for l = length(data(end,:)):-1:1
    y = data(:,l);
    init_point = [init_guess_struct(l).pks', init_guess_struct(l).widths', init_guess_struct(l).locs', k_init(l), b_init(l)]; 
%     init_point = [data(x == 10.78,l), data(x == 11.74,l),0.2,0.2, 10.76, 11.76, k_init(l), b_init(l)];
%     init_point = [init_guess_struct(l).pks', 250000 , init_guess_struct(l).widths', 0.2, init_guess_struct(l).locs', 12.06, k_init(l), b_init(l)]% [a1,a2,a3, w1,w2,w3, x01,x02,x03]
    N = length(init_guess_struct(l).pks);
    
    lb = [init_guess_struct(l).pks'./1.5, init_guess_struct(l).widths'./1.5, init_guess_struct(l).locs' - repmat(0.1, 1, N), k_lb(l), b_lb(l)];% lower bound 
    ub = [init_guess_struct(l).pks'.*1.5, init_guess_struct(l).widths'.*1.5, init_guess_struct(l).locs' + repmat(0.1, 1, N), k_ub(l), b_ub(l)];% upper bound
    
    switch type
        case  'gauss'
            F = @(params)Gauss_n_bkgrd(x, params, N) - y;
        case 'lorentz'
            F = @(params)Lorentz_n_bkgrd(x, params, N) - y;
        case 'testfun' %gauss with separated linear and nonlinear parameters
             F = @(params,x)testfun(x, params, N, y);
    end
    
%     opt = optimoptions('lsqnonlin', 'Display', 'iter', 'Algorithm','levenberg-marquardt');
    opt = optimoptions('lsqcurvefit', 'Display', 'iter', 'Algorithm','levenberg-marquardt', 'TolX', 1e-08);
    
%     [p, resnorm, residual,exitflag,output,lambda] = lsqnonlin(F, init_point, [], [], opt);
    [p,resnorm2,~,exitflag2,output2] = lsqcurvefit(F,init_point,x,y,lb,ub,opt);
%     F = @(params, x)Lorentz_n_bkgrd(x, params, N); % minnonunc
%     Fsumsquare = @(params)sum((F(params, x) - y).^2);
%     opt = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter'); 
%     p = fminunc(Fsumsquare, init_point, opt);
    if is_Display
        if strcmp(type, 'gauss') || strcmp(type, 'testfun')
                figure
                hold on
                plot(x,y,'ro')
                xx = 9.5:0.005:13;
                plot(xx, Gauss_n_bkgrd(xx, p, N), '-c')
                if N == 2
                    plot(xx, Gauss_n_bkgrd(xx, [p(1), p(3), p(5), 0, 0], 1), '-.k')
                    plot(xx, Gauss_n_bkgrd(xx, [p(2), p(4), p(6), 0, 0], 1), '-.k')
                    plot(xx, p(7).*xx + p(8), '--k')
                elseif N == 3
                    plot(xx, Gauss_n_bkgrd(xx, [p(1), p(4), p(7), p(10), p(11)], 1), '-.k')
                    plot(xx, Gauss_n_bkgrd(xx, [p(2), p(5), p(8), p(10), p(11)], 1), '-.k')
                    plot(xx, Gauss_n_bkgrd(xx, [p(3), p(6), p(9), p(10), p(11)], 1), '-.k')
                end
                figure
                hold on
                plot(x,log10(y),'ro')
                xx = 9.5:0.005:13;
                plot(xx, log10(Gauss_n_bkgrd(xx, p, N)), '-c')
                plot(xx, log10(Gauss_n_bkgrd(xx, [1.5*10^4, 0.4, 11.5, 0, 0], 1)), '-.k', xx, log10(k_init(l)*xx + b_init(l)), '--k')
        elseif strcmp(type, 'lorentz')
                figure
                hold on
                plot(x,y,'ro')
                xx = 9.5:0.005:13;
                plot(xx, Lorentz_n_bkgrd(xx, p, N), '-c')
                if N == 2
                    plot(xx, Lorentz_n(xx, [p(1), p(N+1), p(2.*N+1)], 1), '-.k')
                    plot(xx, Lorentz_n(xx, [p(2), p(4), p(6)], 1), '-.b')
                elseif N == 3
                    plot(xx, Lorentz_n(xx, [p(1), p(N+1), p(2.*N+1)], 1), '-.k')
                    plot(xx, Lorentz_n(xx, [p(2), p(5), p(8)], 1), '-.k')
                    plot(xx, Lorentz_n(xx, [p(3), p(6), p(9)], 1), '-.k')
                end
        end
    end
    
    switch N
        case 0
            p_struct(l).pks = [];
            p_struct(l).locs = [];
            p_struct(l).widths = [];
        case 1
            p_struct(l).pks = p(1);
            p_struct(l).locs = p(3);
            p_struct(l).widths = p(2);
        case 2
            p_struct(l).pks = [p(1), p(2)];
            p_struct(l).locs = [p(5), p(6)];
            p_struct(l).widths = [p(3), p(4)];
        case 3
            p_struct(l).pks = [p(1), p(2), p(3)];
            p_struct(l).locs = [p(7), p(8), p(9)];
            p_struct(l).widths = [p(4), p(5), p(6)];
        otherwise
            display('dimentions of init_guess should equal to 1, 2, or 3')
            p_struct(l) = [];
    end
            
    
end

end


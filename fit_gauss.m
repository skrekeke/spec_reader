function [ peaks, GOF ] = fit_gauss( x, data, number_of_peaks,is_Display )
%FIT_GAUSS fits with gauss(es) 
%   INPUT   x  - vector column of Xdata, [Scan_length,1],
        %   data - matrix [Scan_length,Number of scans]
        %   fit_curve - string, the fitting curve: 'gauss1', 'gauss2'
%   OUTPUT  peaks - an 3d array of dimentions [Scan_length, number_of_peaks,Number of scans] 
%           gof -  structure of goodness of fit,

data_leveled = background_subs(x, data, 'const', min(data),0);
if number_of_peaks==1
    for l = length(data(end,:)):-1:1 
        [fitpeaks,gof] = fit(x, data_leveled(:,l),'gauss1');
        peak1 = fitpeaks.a1*exp(-((x-fitpeaks.b1)/fitpeaks.c1).^2);
        peaks(:,l) = [peak1];
    end
elseif number_of_peaks==2
    for l = length(data(end,:)):-1:1
                                        %      4 sample, 3Ru70Y              _________1 gauss_________   ---------2 gauss--------
%         params_init = [data(17,l), 10.78, 0.1, data(29,l), 11.74, 0.1]; % [amplitude1, mean1, width1, amplitude2, mean2, width2] 
%         min_params = [1000, 10.76, 0.01,  1000, 11.76,0.01];
%         max_params = [1e+7, 10.78, 0.15,  1e+7, 11.78, 0.15];
%         params_init = [data(17,l), 10.78, 0.1, data(29,l), 11.8, 0.1]; 
%         min_params = [1000, 10.77, 0.01,  1000, 11.78, 0.01];
%         max_params = [1e+7, 10.79, 0.15,  1e+7, 11.82, 0.15];
        params_init = [data(18,l), 10.78, 0.1, data(31,l), 11.8, 0.1]; 
        min_params = [1000, 10.77, 0.01,  1000, 11.78, 0.01];
        max_params = [1e+7, 10.79, 0.15,  1e+7, 11.82, 0.15];
        [fitpeaks,gof] = fit(x, data_leveled(:,l),'gauss2', 'StartPoint', params_init, 'Lower', min_params, 'Upper', max_params)
        peak1 = fitpeaks.a1*exp(-((x-fitpeaks.b1)/fitpeaks.c1).^2);
        peak2 = fitpeaks.a2*exp(-((x-fitpeaks.b2)/fitpeaks.c2).^2);
        peaks(:,:,l) = [peak1, peak2];
        GOF(l) = gof;
        if is_Display
            figure
%             plot(fitpeaks, x,data_leveled(:,l), 'ob')
%             hold on
            semilogy(x, peak1, '-g', x, peak2, '-c',x, data_leveled(:,l),'ob', x , peak1+peak2, '--r' )
            ax = gca;
            ax.YLim = [1e+1 1e+7];
        end
    end
else
    display('number_of_peaks must be 1 or 2.')
end
peaks = squeeze(peaks);

end


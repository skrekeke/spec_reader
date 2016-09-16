function [ fraction1, fraction2 , area1, area2] = peak_area_ratio( peaks, x )
%PEAK_AREA_RATIO calculates ratio of integral intensities of two peaks
%   peaks - output of fit_gauss function
%
 for l = length(peaks(1,1,:)):-1:1 
    area1(:,l) = trapz(x, peaks(:,1,l))
    area2(:,l) = trapz(x, peaks(:,2,l))
    fraction1(:,l) = area1(l)./(area1(l) + area2(l))
    fraction2(:,l) = area2(l)./(area1(l) + area2(l))
 end


end


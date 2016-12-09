 function [ locations, widths, peaks ] = peak_extractor_2der( Input, interpInt, is_Display )
%PEAK_EXTRACTOR_2DER extracts peak locations and widths from data
%   data nxm array, where n - number of points in 1 scan, m - number of
%   scans
dx = diff(Input.angles);
dx = dx(1);
angles_dx = Input.angles(1:end-1) - repmat((Input.angles(2)-Input.angles(1))/2, length(Input.angles)-1,1)';
angles_dx2 = Input.angles(2:end-1);
for i = length(interpInt(1,:)):-1:1
    d2ydx2 = diff(diff(interpInt(:,i)))/dx^2;
    dydx = diff(interpInt(:,i))/dx^2;
    plot(angles_dx2, d2ydx2, '-g', Input.angles, interpInt(:,i), 'b', angles_dx, dydx, '-r')
    max_points = angles_dx2((d2ydx2 < 0) & abs(dydx(1:end-1)) <= 10^-2)
    susp_points = angles_dx2((d2ydx2 < 0) & (interpInt(2:end-1,i) >= Input.bkgrd) & dydx(1:end-1) <= 0)
    
    if is_Display
        figure
        hold on
        findpeaks(interpInt(:, i), Input.angles, 'MinPeakHeight', Input.bkgrd, 'Annotate', 'extents', 'WidthReference', 'halfheight');
        xlabel('2\theta, deg.');
        ylabel('I, counts')
    end
        [peaks(i).pks, peaks(i).locs, peaks(i).widths, peaks(i).proms] = findpeaks(interpInt(:, i), Input.angles', 'MinPeakHeight', Input.bkgrd, 'Annotate', 'extents', 'WidthReference', 'halfheight');
end



%}
for j = length(peaks):-1:1
    switch length(peaks(j).locs)
    case 1
        locations(j,:) = [peaks(j).locs, NaN, NaN];
        widths(j,:) = [peaks(j).widths, NaN, NaN];
    case 2
        locations(j,:) = [peaks(j).locs', NaN];
        widths(j,:) = [peaks(j).widths', NaN];
    case 3
        locations(j,:) = [peaks(j).locs'];
        widths(j,:) = [peaks(j).widths'];    
    case 0
        locations(j,:) = [NaN, NaN, NaN];
        widths(j,:) = [NaN, NaN, NaN];
    otherwise
        sprintf('more than 3 peaks for %i scan (%i-th in edited array)', num_range(j), j)
        locations(j,:) = [peaks(j).locs(1:3)'];
        widths(j,:) = [peaks(j).widths(1:3)'];
    end
end

end


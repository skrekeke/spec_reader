 function [ locations, widths, pks, peaks ] = peak_extractor( Input, interpInt, is_Display )
%PEAK_EXTRACTOR extracts peak locations and widths from data
%   based on the 2nd derivative analysis
%   data nxm array, where n - number of points in 1 scan, m - number of
%   scans


for i = length(interpInt(1,:)):-1:1
    if is_Display
        figure
        hold on
        findpeaks(interpInt(:, i), Input.angles', 'MinPeakHeight', Input.bkgrd, 'Annotate', 'extents', 'WidthReference', 'halfheight');
        xlabel('2\theta, deg.');
        ylabel('I, counts')
    end
        [peaks(i).pks, peaks(i).locs, peaks(i).widths, peaks(i).proms] = findpeaks(interpInt(:, i),  Input.angles', 'MinPeakHeight', Input.bkgrd, 'Annotate', 'extents', 'WidthReference', 'halfheight');
end



%}
for j = length(peaks):-1:1
    switch length(peaks(j).locs)
    case 1
        locations(j,:) = [peaks(j).locs, NaN, NaN];
        widths(j,:) = [peaks(j).widths, NaN, NaN];
        pks(j,:) = [peaks(j).pks, NaN, NaN];
    case 2
        locations(j,:) = [peaks(j).locs', NaN];
        widths(j,:) = [peaks(j).widths', NaN];
        pks(j,:) = [peaks(j).pks', NaN];
    case 3
        locations(j,:) = [peaks(j).locs'];
        widths(j,:) = [peaks(j).widths'];    
        pks(j,:) = [peaks(j).pks'];
    case 0
        locations(j,:) = [NaN, NaN, NaN];
        widths(j,:) = [NaN, NaN, NaN];
        pks(j,:) = [NaN, NaN, NaN];
    otherwise
        sprintf('more than 3 peaks for %i scan (%i-th in edited array)', num_range(j), j)
        locations(j,:) = [peaks(j).locs(1:3)'];
        widths(j,:) = [peaks(j).widths(1:3)'];
    end
end

end


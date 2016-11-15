 function [ locations, widths, peaks ] = peak_extractor( Input, interpInt )
%PEAK_EXTRACTOR extracts peak locations and widths from data
%   data nxm array, where n - number of points in 1 scan, m - number of
%   scans
figure
hold on

for i = length(interpInt(1,:)):-1:1
    if Input.is_display
        findpeaks(interpInt(:, i), Input.angles, 'MinPeakHeight', 5010, 'Annotate', 'extents', 'WidthReference', 'halfheight');
    end
        [peaks(i).pks, peaks(i).locs, peaks(i).widths, peaks(i).proms] = findpeaks(interpInt(:, i), Input.angles', 'MinPeakHeight', 5010, 'Annotate', 'extents', 'WidthReference', 'halfheight');
end


xlabel('2\theta, deg.');
ylabel('I, counts')
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
        sprintf('more than 2 peaks for %i scan (%i-th in edited array)', num_range(j), j)
        locations(j,:) = [peaks(j).locs(1:3)'];
        widths(j,:) = [peaks(j).widths(1:3)'];
    end
end
    if is_time_axis && Input.is_display_locs_widths
        x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
        label = 'time, min';
        figure
        subplot(2, 1, 1)
        plot(x_list, locations(:,1), 'ok', x_list, locations(:,2), 'ob', x_list, locations(:,3), 'or')
        xlabel(label)
        ylabel(dataylabel)
        subplot(2, 1, 2)
        plot(x_list, widths(:,1), 'ok', x_list, widths(:,2), 'ob', x_list, widths(:,3), 'or')
        xlabel(label)
        ylabel('FWHM, deg')
    end


end


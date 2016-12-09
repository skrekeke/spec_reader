 function [ locations, widths, pks ] = peakspar_struct2array( peaks )
% 

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


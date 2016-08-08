% plot the surface of intensity versus angle and number of a scan ( = time)
% assumes that every scan has the same list angles
% by Olena Soroka 
% July 2016


clear all
%% INPUT
%3Ru70Y I
% num_range = [36:75, 141:149, 152:176];
% num_range = [36:283];

% %4Pd70Y I
% num_range = [301:369];

% %3Ru70Y II
% num_range = [381:394];
% points = [101];

%3Ru70Y III
num_range = [438:469];
points = [55];%, 55, 11];

scan_type_in = 1;
                % 'a2scan'   => 1
                % 'ascan'    => 2
                % 'timescan' => 3
                % 'loopscan' => 4

is_scan_sequential_numbering = false;
is_time_axis = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%h2 on/off
%f1 on/off
%heating on/off

%3Ru70Y I
% h2_on = [37,185,254];
% h2_off = [176,190,282];
% f1_on = [37,185,254];
% f1_off = [179,187,282];
% heating_on = 201;
% heating_off = 253;

%4Pd70Y I
% h2_on = [301];
% h2_off = [325];
% f1_on = [301];
% f1_off = [323];
% heating_on = [355];
% heating_off = [369];

%3Ru70Y II
% h2_on = [383];
% h2_off = [389];
% f1_on = [383];
% f1_off = [389];

%3Ru70Y III
h2_on = [401,470];
h2_off = [436, 731];
f1_on = [401, 480, 546, 681];
f1_off = [434, 522, 659, 731];
heating_on = [438 ,523,674];
heating_off = [469, 544, 679];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h2_ranges = [];
f1_ranges = [];
heating_ranges = [];

if exist('h2_on')
    for i = 1:length(h2_on)
        h2_ranges = [h2_ranges,[h2_on(i):h2_off(i)]];
    end
end
if exist('f1_on')
    for i = 1:length(f1_on)
        f1_ranges = [f1_ranges,f1_on(i):f1_off(i)];
    end
end
if exist('heating_on')
    for i = 1:length(heating_on)
        heating_ranges = [heating_ranges, heating_on(i):heating_off(i)];
    end
end
%%  
if is_scan_sequential_numbering && is_time_axis
    is_scan_sequential_numbering = false;
end

[all_scans, n_scans_edited, time_list, ~, y_startm, y_endm] = specreader_with_NaN( num_range, scan_type_in, points );

if is_scan_sequential_numbering
    n_scan_list = [n_scans_edited(1) :(n_scans_edited(1) + length(n_scans_edited) - 1)];
else
    n_scan_list = n_scans_edited;
end

angle_list = all_scans(:,1,1);
intensity_2d = squeeze(all_scans(:,2,:)); % [time(scan number), angle]
%% h2 and filament on/off functions, and heating on/off
for i = 1:length(num_range)
    if ~isempty(h2_ranges)
        for j = 1:length(h2_ranges)
            if num_range(i) == h2_ranges(j)
                h2_bool(i,j) = true;
            else
                h2_bool(i,j) = false;
            end
        end
    else
        h2_bool(i) = false;
    end
    if ~isempty(f1_ranges)
        for j = 1:length(f1_ranges)
            if num_range(i) == f1_ranges(j)
                f1_bool(i,j) = true;
            else
                f1_bool(i,j) = false;
            end
        end
    else
        f1_bool(i) = false;
    end
    if ~isempty(heating_ranges)
        for j = 1:length(heating_ranges)
            if num_range(i) == heating_ranges(j)
                heating_bool(i,j) = true;
            else
                heating_bool(i,j) = false;
            end
        end
    else
        heating_bool(i) = false;
    end
end
h2_boolv = sum(h2_bool(:,:)');
f1_boolv = sum(f1_bool(:,:)');
heating_boolv = sum(heating_bool(:,:)');
%% on/off points for vertical lines into percents 
%{
h2_on2 =  (h2_on-num_range(1))/(num_range(end) - num_range(1));
h2_off2 = (h2_off-num_range(1))/(num_range(end) - num_range(1));

f1_on2 =  (f1_on-num_range(1))/(num_range(end) - num_range(1));
f1_off2 = (f1_off-num_range(1))/(num_range(end) - num_range(1));

heating_on2 = (heating_on-num_range(1))/(num_range(end) - num_range(1));
heating_off2 = (heating_off-num_range(1))/(num_range(end) - num_range(1));
%}
%% time plot
s = sprintf('Chi, %c', char(176));% degree symbol %%%%% <---- TO CHANGE
%% dealing with different number of points

%% scan number or time plot
    
if is_time_axis
    x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
    label = 'time, min';
else
    x_list = n_scan_list;
    label = 'scan number';
end
    figure;
    [X, Y] = meshgrid(x_list, angle_list);
    main_plot = subplot(1,1,1);
    ms = surface(X,Y,intensity_2d);
%     surf(n_scan_list, angle_list, intensity_2d,'edgeColor', 'None');
    shading interp
    colormap(jet(256))
%     h = colorbar('northoutside');
%     h.Label.String = 'I, a.u.';
    axis tight
    xlabel(label)
    ylabel(s)
	title('3nm Ru 70nm Y III')%%%%% <---- TO CHANGE
    view(0,90)
   set(main_plot, 'TickDir', 'out', 'XLim', [x_list(1) x_list(end)], 'YLim', [y_startm y_endm]);

return
if exist('h2_on')
    h2 = subplot(4,1,2);
    hold on
    bar(x_list, h2_boolv, 1, 'b', 'LineStyle','none')
    axis tight
    ylabel('H2 on/off', 'Color', 'black')
    set(h2, 'YTick',[0 1],'TickDir', 'out');%,'YColor','w'
    if is_time_axis
        datetick('x', 'hh','keepticks')
    end
    h2.Position(3) = main_plot.Position(3);
    h2.Position(4) = main_plot.Position(4);
end
if exist('f1_on')
    f1 = subplot(4,1,3);
    bar(x_list, f1_boolv, 1, 'g', 'LineStyle','none')
    axis tight
    ylabel('W filament on/off', 'Color', 'black')
    set(f1, 'YTick',[0 1],'YColor','w','TickDir', 'out');
    if is_time_axis
        datetick('x', 'hh','keepticks')
    end
    f1.Position(3) = main_plot.Position(3);
    f1.Position(4) = h2.Position(4);
end
if exist('heating_on')
    heating = subplot(4,1,4);
    bar(x_list, heating_boolv, 1, 'r', 'LineStyle','none')
    if is_time_axis
        datetick('x', 'hh','keepticks')
    end
    axis tight
    ylabel('Heating on/off', 'Color', 'black')
    set(heating, 'YTick',[0 1],'YColor','w','TickDir', 'out');
    heating.Position(3) = main_plot.Position(3);
    heating.Position(4) = h2.Position(4);
end  

%%%%%%%%vertical lines
%{
    gg = axes('Position',[0.13 0.11 0.7144 0.85], 'Visible','on', 'XLim', [num_range(1) num_range(end)],'TickDir', 'out');
    line([h2_on(1) h2_on(1)],[angle_list(1) angle_list(end)], 'Color', 'white', 'Visible', 'on')
    line([h2_on(2) h2_on(2)],[angle_list(1) angle_list(end)], 'Color', 'black')
    line([h2_on(3) h2_on(3)],[0 1], 'Color', 'b')
    line([h2_off(1) h2_off(1)],[0 1], 'Color', 'b')
    line([f1_off(2) f1_off(2)],[0 1], 'Color', 'b')
    line([h2_off(3) h2_off(3)],[0 1], 'Color', 'b')
    line([heating_on heating_on],[0 1], 'Color', 'r')
    line([heating_off heating_off],[0 1], 'Color', 'r')
%}


%{
figure
waterfall(n_scan_list, angle_list, intensity_2d);
%}

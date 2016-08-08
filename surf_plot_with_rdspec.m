% plot the surface of intensity versus angle and number of a scan ( = time)
% 
% by Olena Soroka 
% July 2016


clear all
%% INPUT

is_time_axis = true;

%3Ru70Y I
% num_range = [36:75, 141:149, 152:176];
% num_range = [36:283];

% %4Pd70Y I
% num_range = [301:369];

% %3Ru70Y II
% num_range = [381:394];
% points = [101];

%3Ru70Y III
num_range = [401:473];
points = [101, 55];%, 55, 11];
angles = 9.5:0.04:12.5;


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
% h2_on = [401,470];
% h2_off = [436, 731];
% f1_on = [401, 480, 546, 681];
% f1_off = [434, 522, 659, 731];
% heating_on = [438 ,523,674];
% heating_off = [469, 544, 679];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
[a, T, time_list, mask_l, gam, chi, del] = specreader_with_rdspec( num_range, points );

%% extrapolation of data. be sure there is no need to extrapolate
num_range = num_range(:,mask_l);% delete non-relevant scans

for i=length(num_range):-1:1
    if (gam(i) && chi(i))
        interpInt(:,i) = interp1( a(i).data(:,gam(i)), a(i).data(:,end), angles', 'splin');
    elseif del(i)
        interpInt(:,i) = interp1( a(i).data(:,del(i)), a(i).data(:,end), angles, 'splin');
    else
        display('Bug! Not gam nor del scan')
    end
 end


            
            

%% time plot
s = sprintf('Chi, %c', char(176));% degree symbol %%%%% <---- TO CHANGE


%% scan number or time plot
    
if is_time_axis
    display('Time plot')
    x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
    label = 'time, min';
else
    x_list = num_range;
    label = 'scan number';
end
    main_plot = figure;
    [X, Y] = meshgrid(x_list, angles);
    ms = surface(X,Y,interpInt);
    contour(X,Y,interpInt,[2000:1000:10000,12000:4000:100000,150000:50000:3000000])%,'ShowText','on');
%     surf(n_scan_list, angle_list, intensity_2d,'edgeColor', 'None');
    shading interp
    colormap(jet(256))
    h = colorbar('northoutside');
    h.Label.String = 'I, a.u.';
    axis tight
    xlabel(label)
    ylabel(s)
	title('3nm Ru 70nm Y III')%%%%% <---- TO CHANGE
    view(0,90)
%     set(main_plot, 'TickDir', 'out', 'XLim', [x_list(1) x_list(end)], 'YLim', [y_startm y_endm]);






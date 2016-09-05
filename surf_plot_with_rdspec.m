% plot the surface of intensity versus angle and number of a scan ( = time)
% 
% by Olena Soroka 
% July 2016


clear all
%% INPUT
% make sure that in num_range there are no scans of true type and length,
% but in wrong range of angles

is_time_axis = true;
is_type_of_measurement = true; % TRUE - t2t scan, FALSE - del scan (in plane gixrd)
% %3Ru70Y I
% Input.num_range = [36:75, 141:149, 152:176];
% Input.num_range = [36:283];
% Input.points = [151];
% Input.angles = 9.4:0.04:12.6;

% %4Pd70Y I
% Input.num_range = [301:369];
% Input.points = [101];
% Input.angles = 9.3:0.04:13;

% %3Ru70Y II
% Input.num_range = [381:394];
% Input.points = [101];
% Input.angles = 9.3:0.04:13;

% %3Ru70Y III
% Input.num_range = [401:731];
% Input.num_range = [401:468];
% Input.points = [101, 55];%, 11];
% Input.angles = 9.5:0.04:13;

% %3Ru70La5B I
% Input.num_range = [743:807];
% Input.points = [101, 26]; %, 26];
% Input.angles = 9.7:0.04:12.5; 


% %3Ru70La5B I last re-hydrogenation
% Input.num_range = [788:807];
% Input.points = [26]; %, 26];
% Input.angles = 10.32:0.04:11.32;

% %3Ru70La5B II
% Input.num_range = [815:945];
% Input.points = [43,101];
% Input.angles = 10.32:0.04:12;

% %4Pd70Y II poluted sample
% Input.num_range = [954:1108, 1110:1141];
% Input.num_range = [954:1033];
% % Input.num_range = [1098:1120];
% Input.points = [14];%, 101, 31, 55];
% Input.angles = 10:0.04:12.5;

% %6Ru70Y I 
% % %gid. Y and Ru peaks (and YH3 and Ru peaks) vs incidence angle 
% Input.num_range = [1202:1222];
% % Input.num_range = [1162:1182];
% Input.points = [117];
% Input.angles = 10.5:0.05:16.3;
% is_type_of_measurement = false;
% is_time_axis = false;
% incidence = 0:0.01:0.2;
%
% broad gid
Input.num_range = [1150, 1201, 1230];
Input.points = 501;
Input.angles = 9:0.062:40;
is_type_of_measurement = false;
is_time_axis = false;
Ru_peaks = [15.204, 16.640, 17.342, 22.615, 26.487, 29.464, 30.684, 31.844, 33.662, 35.105, 37.120];
% Y_peaks = [11.262, 12.422, 12.873, 16.798, 19.579, 21.873, 22.631, 23.256, 23.487, 24.996, 25.901, 27.499, 29.508, 30.1, 30.765, 31.951, 32.675, 33.453, 33.972, 34.242, 35.667];
Y_peaks = [11.262, 12.422, 12.873, 16.798, 19.579, 22.631, 23.256, 23.487, 24.996, 29.508, 30.1, 30.765 33.453, 33.972];
YH3_peaks = [10.682, 21.589];
YH2_peaks = [11.821, 13.641];

% %t2t Y->YH3 and YH3->YH2
% Input.num_range = [1185:1194, 1223:1228];
% Input.points = [101];
% Input.angles = 9.2:0.04:13.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%h2 on/off
%f1 on/off
%heating on/off

%3Ru70Y I
% Input.h2_on = [37,185,254];
% Input.h2_off = [176,190,282];
% Input.f1_on = [37,185,254];
% Input.f1_off = [179,187,282];
% Input.heating_on = 201;
% Input.heating_off = 253;

%4Pd70Y I
% Input.h2_on = [301];
% Input.h2_off = [325];
% Input.f1_on = [301];
% Input.f1_off = [323];
% Input.heating_on = [355];
% Input.heating_off = [369];

%3Ru70Y II
% Input.h2_on = [383];
% Input.h2_off = [389];
% Input.f1_on = [383];
% Input.f1_off = [389];

%3Ru70Y III
% Input.h2_on = [401,470];
% Input.h2_off = [436, 731];
% Input.f1_on = [401, 480, 546, 681];
% Input.f1_off = [434, 522, 659, 731];
% Input.heating_on = [438 ,523,674];
% Input.heating_off = [469, 544, 679];

%3Ru70La5B I
% Input.h2_on = [743, 773, 789];
% Input.h2_off = [762, 775, 807];
% Input.f1_on = [743, 773, 789];
% Input.f1_off = [762, 774, 807];
% Input.heating_on = [773];
% Input.heating_off = [780];

% %3Ru70La5B II
% Input.h2_on = [815, 886];
% Input.h2_off = [865, 917];
% Input.f1_on = [817, 886, 909];
% Input.f1_off = [865, 904, 909];
% Input.heating_on = [865, 919];
% Input.heating_off = [885, 945];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
tic

[a, T, time_list, mask_l, gam, chi, del] = specreader_with_rdspec( Input );

toc
%% simple plot
% Ymax = 0.01;
% Ymin = 100;
figure
for i = 1:length(Input.num_range)
semilogy(a(i).data(:,del(i)), a(i).data(:,end))
% if max(a(i).data(:,end)) > Ymax
%     Ymax = max(a(i).data(:,end));
% end
% if min(a(i).data(:,end)) < Ymin
%     Ymin = min(a(i).data(:,end));
% end
hold on

end
axis tight
legend('AD','YH3','YH2 after heating')
title('6Ru70Y in plane GID')
xlabel('Delta, deg.')
ylabel('Intensity')

for k = 1:length(Ru_peaks)
    line([Ru_peaks(k) Ru_peaks(k)], [300 20000], 'Color', 'red')
end

for k = 1:length(Y_peaks)
    line([Y_peaks(k) Y_peaks(k)], [300 20000], 'Color', 'black')
end

for k = 1:length(YH2_peaks)
    line([YH2_peaks(k) YH2_peaks(k)], [300 20000], 'Color', 'green')
end

for k = 1:length(YH3_peaks)
    line([YH3_peaks(k) YH3_peaks(k)], [300 20000], 'Color', 'magenta')
end
%% interpolation of data
%{
num_range = Input.num_range(:,mask_l);% delete non-relevant scans
is_wrong_scans = zeros(size(num_range));
for i=length(num_range):-1:1
    if (gam(i) && chi(i)) && is_type_of_measurement
        step = (a(i).data(end,gam(i)) - a(i).data(1,gam(i)))/(length(a(i).data(:,gam(i))) - 1);
        j = 1;
        k = length(Input.angles');
        if length(a(i).data(:,gam(i))) < length(Input.angles') %% filling non-existing data with NaN
            while a(i).data(1,gam(i)) - Input.angles(j) > step %% if data point is further than data STEP from given grid-point, than do no interpolating
                interpInt(j,i) = NaN;
                j = j+1;
            end
            sprintf('%f %i',abs(a(i).data(end,gam(i)) - Input.angles(k)), num_range(i) )
            while Input.angles(k) - a(i).data(end,gam(i)) > step
                interpInt(k,i) = NaN;
                k = k-1;
            end
        end
        interpInt(j:k,i) = interp1( a(i).data(:,gam(i)), a(i).data(:,end), Input.angles(j:k)', 'splin');
    elseif del(i) && is_type_of_measurement % if not desired type of scans
       interpInt(:,i) = NaN;
       is_wrong_scans(i) = true;
    else
        if del(i) && ~is_type_of_measurement
            interpInt(:,i) = interp1( a(i).data(:,del(i)), a(i).data(:,end), Input.angles', 'splin');
        elseif (gam(i) && chi(i)) && ~is_type_of_measurement % if not desired type of scans
            interpInt(:,i) = NaN;
            is_wrong_scans(i) = true;
        else
            display('Bug! Nor gam neither del scan') % if not desired type of scans
            is_wrong_scans(i) = true;
            interpInt(:,i) = NaN;
        end
    end
end

% interpInt = interpInt(:,~is_wrong_scans);
% time_list = time_list(:, ~is_wrong_scans);
% num_range = num_range(:, ~is_wrong_scans);
            
            

%% time plot
% s = sprintf('2%s, %c', '\theta', char(176));% degree symbol %%%%% <---- TO CHANGE


%% scan number or time plot
    
if is_time_axis
    display('Time plot')
    x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
    label = 'time, min';
else
    display('chi plot')
    x_list = incidence;
    label = 'angle of incidence, deg.';
end
    main_plot = figure;
    [X, Y] = meshgrid(x_list, Input.angles);
    ms = surface(X,Y,log10(interpInt));
%     cc = contour(X,Y,log10(interpInt), 'LevelStep', 0.1);%,'ShowText','on');
%     surf(n_scan_list, angle_list, intensity_2d,'edgeColor', 'None');
    shading interp
    colormap(jet(256))
    h = colorbar('northoutside');
    h.Label.String = 'I, 10^n';
    axis tight
    xlabel(label)
    ylabel('2\theta, deg.')%%%%%%%%% <---- TO CHANGE
	title('6nm Ru / 70nm YH3   GID')%%%%% <---- TO CHANGE
%     view(0,90)
%     set(main_plot, 'TickDir', 'out')%, 'XLim', [x_list(1) x_list(end)], 'YLim', [y_startm y_endm]);
  

% line([x_list(21) x_list(21)], [Input.angles(1) Input.angles(end)], 'Color', 'r')
%}


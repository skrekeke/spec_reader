% plot the surface of intensity versus angle and number of a scan ( = time)
% 
% by Olena Soroka 
% July 2016


clear all
%% INPUT
% make sure that in num_range there are no scans of true type and length,
% but in wrong range of angles
Input.is_display = true;
Input.is_display_locs_widths = true;
Input.is_width_plot = true; % if you need simple t2t plot without width analysis, make width_plot false
Input.is_time_axis = true;
Input.is_type_of_measurement = true; % TRUE - t2t scan, FALSE - del scan (in plane gixrd)
Input.is_Tplot = true;% temperature plot
Input.is_lines = false; % vertical lines to identify h2 on/off, f1 on/off, heating on/off
dataylabel = '2\theta, deg.';
% graph_title = ' ';
linewidth = 2; % width of vertical lines

%FOR FIT


% %3Ru70Y I
% Input.num_range = [36:75, 141:149, 152:176];
% Input.num_range = [36:283];
% Input.points = [151];
% Input.angles = 9.4:0.04:12.6;

% %4Pd70Y I
% Input.num_range = [301:330];%transition
% Input.num_range = [301, 305, 312, 323];%transition
% Input.num_range = [313:330];% YH2 --> YH3
% Input.num_range = [349:372];% heating
% Input.points = [101,55];
% Input.points = [101,98];% YH2 --> YH3
% Input.angles = 9.4:0.08:13;

% %3Ru70Y II
% Input.num_range = [381:394];
% Input.points = [101];
% Input.angles = 9.3:0.04:13;

% %3Ru70Y III
% Input.num_range = [401:731];% all scans
% transition + 1st heating
Input.num_range = [401:420];% transition Y ->  YH3
% Input.num_range = [463:464];% 1st heating, YH3 -> YH2
% Input.num_range = [415:430];% YH2 --> YH3 transition
% Input.num_range = [408:413];
% Input.num_range = [401:468];
Input.points = [101, 55];%, 11];
Input.angles = 9.5:0.04:13;
Input.bkgrd = 5010;
% Input.angles = 9.5:0.08:12.46;

% %3Ru70Y IV
% Input.num_range = [1241:1251];%Y -> YH3
% Input.num_range = [1258:1263];% heating YH3 -> YH2
% Input.num_range = [1241, 1258:1260];
% Input.points = [65];
% Input.angles = 10.3:0.05:13.5;
% Input.is_type_of_measurement = false;
% Input.bkgrd = 1500;



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
% Input.is_type_of_measurement = false;
% Input.is_time_axis = false;
% incidence = 0:0.01:0.2;
%
% broad gid
% Input.num_range = [1232];%, 1201, 1230];
% Input.points = 301;
% Input.angles = 4:0.086:30;
% Input.is_type_of_measurement = false;
% Input.is_time_axis = false;
% Ru_peaks = [15.204, 16.640, 17.342, 22.615, 26.487, 29.464, 30.684, 31.844, 33.662, 35.105, 37.120];
% % Y_peaks = [11.262, 12.422, 12.873, 16.798, 19.579, 21.873, 22.631, 23.256, 23.487, 24.996, 25.901, 27.499, 29.508, 30.1, 30.765, 31.951, 32.675, 33.453, 33.972, 34.242, 35.667];
% Y_peaks = [11.262, 12.422, 12.873, 16.798, 19.579, 22.631, 23.256, 23.487, 24.996, 29.508, 30.1, 30.765 33.453, 33.972];
% YH3_peaks = [ 15.558, 19.343, 19.721, 24.948, 27.697, 29.192, 29.436, 29.811, 30.379, 39.512];% 31.841, 34.171,
% YH2_peaks = [19.396, 27.48, 33.906, 39.378];

% %t2t Y->YH3 and YH3->YH2
% Input.num_range = [1185:1194, 1223:1228];
% Input.points = [101];
% Input.angles = 9.2:0.04:13.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% Input.heating_off = [372];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
tic

[a, T, time, mask_l, gam, chi, del] = specreader_with_rdspec( Input );

toc




%% simple plot
%{
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
title('6Ru70YH_2 after heating. in plane GID')
xlabel('Delta, deg.')
ylabel('Intensity')

for k = 1:length(Ru_peaks)
    line([Ru_peaks(k) Ru_peaks(k)], [300 20000], 'Color', 'red')
end

for k = 1:length(Y_peaks)
    line([Y_peaks(k) Y_peaks(k)], [300 20000], 'Color', 'black')
end

for k = 1:length(YH2_peaks)
    line([YH2_peaks(k) YH2_peaks(k)], [300 20000], 'Color', 'cyan')
end

for k = 1:length(YH3_peaks)
    line([YH3_peaks(k) YH3_peaks(k)], [300 20000], 'Color', 'magenta')
end
%}
%% interpolation of data
% %{
time_list = time(:,mask_l);
num_range = Input.num_range(:,mask_l);% delete non-relevant scans
is_wrong_scans = zeros(size(num_range));
for i=length(num_range):-1:1
    if (gam(i) && chi(i)) && Input.is_type_of_measurement
        step = (a(i).data(end,gam(i)) - a(i).data(1,gam(i)))/(length(a(i).data(:,gam(i))) - 1);
        j = 1;
        k = length(Input.angles');
        if length(a(i).data(:,gam(i))) < length(Input.angles') %% filling non-existing data with 0
            while a(i).data(1,gam(i)) - Input.angles(j) > step %% if data point is further than data STEP from given grid-point, than do no interpolating
                interpInt(j,i) = 0;
                j = j+1;
            end
            sprintf('%f %i',abs(a(i).data(end,gam(i)) - Input.angles(k)), num_range(i) )
            while Input.angles(k) - a(i).data(end,gam(i)) > step
                interpInt(k,i) = 0;
                k = k-1;
            end
        end
        interpInt(j:k,i) = interp1( a(i).data(:,gam(i)), a(i).data(:,end), Input.angles(j:k)', 'splin');
    elseif del(i) && Input.is_type_of_measurement % if not desired type of scans
       interpInt(:,i) = NaN;
       is_wrong_scans(i) = true;
    else
        if del(i) && ~Input.is_type_of_measurement
            interpInt(:,i) = interp1( a(i).data(:,del(i)), a(i).data(:,end), Input.angles', 'splin');
        elseif (gam(i) && chi(i)) && ~Input.is_type_of_measurement % if not desired type of scans
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

%% save scan to .dat file
%{
angles = Input.angles';
data = [angles, interpInt];
save('D:\Data\ESRF 2016\MA-2866\scans_dat\scan1232_6Ru70YH2.asc','data' ,'-ascii')
return
%}
%% integrating peak area
% %{

fit_params1 = fit_peaks( Input.angles', interpInt, Input, 'testfun', 1);
[locs, w, pks, init_guess_struct] = peak_extractor( Input, interpInt, 0);
if 1
    for i=length(locs(:,1)):-1:1
        f1 = Gauss_n_bkgrd( Input.angles', [pks(i,1), w(i,1), locs(i,1), 0, 0], 1 );
        f2 = Gauss_n_bkgrd( Input.angles', [pks(i,2), w(i,2), locs(i,2), 0, 0], 1 );
        f3 = Gauss_n_bkgrd( Input.angles', [pks(i,3), w(i,3), locs(i,3), 0, 0], 1 );
        sum = Gauss_n_bkgrd( Input.angles', [init_guess_struct(i).pks', init_guess_struct(i).widths', init_guess_struct(i).locs', 0, 0], length(init_guess_struct(i).locs) );
        figure
        plot( Input.angles', interpInt(:,i), 'ob', Input.angles', f1, '--g', Input.angles', f2, '--r', Input.angles', f3, '--b', Input.angles', sum, '-.k')
    end
end

for i = length(locs(1,:)):-1:1
    for j = length(locs(:,1)):-1:1
        area(j,i) = integral(@(x)Gauss_n_bkgrd(x,[pks(j,i), w(j,i), locs(j,i),0 ,0],1 ), min(Input.angles), max(Input.angles))
    end
end
area(3:end,2) = integral(@(x)Gauss_n_bkgrd(x,[10^4, 0.5, 11.55 ,0 ,0],1 ), min(Input.angles), max(Input.angles))
     
for j=length(fit_params):-1:1
    if length(fit_params(j).locs) == 1
        fun = @(x)Lorentz_n(x, [fit_params(j).pks, fit_params(j).widths, fit_params(j).locs], 1);
        area = integral(fun, min(Input.angles), max(Input.angles));
        if fit_params(j).locs > 11.5
            area1(j) = area;%YH2
            fun0 = @(x)Lorentz_n(x, [10^4, 0.5, 11.5], 1);
            area2(j) = integral(fun0, min(Input.angles), max(Input.angles));
        else
            area2(j) = area;%YH3
            fun0 = @(x)Lorentz_n(x, [10^4, 0.5, 11.5], 1);
            area1(j) = integral(fun0, min(Input.angles), max(Input.angles));
        end
    elseif length(fit_params(j).locs) == 2
        fun1 = @(x)Lorentz_n(x, [fit_params(j).pks(1), fit_params(j).widths(1), fit_params(j).locs(1)], 1);
        fun2 = @(x)Lorentz_n(x, [fit_params(j).pks(2), fit_params(j).widths(2), fit_params(j).locs(2)], 1);
        area11 = integral(fun1, min(Input.angles), max(Input.angles));
        area22 = integral(fun2, min(Input.angles), max(Input.angles));
        if fit_params(j).locs(1) >= 11.5
            area1(j) = area11;
            area2(j) = area22;
        elseif fit_params(j).locs(2) >= 11.5
            area1(j) = area22;
            area2(j) = area11;
        else
            area1(j) = 0;
            area2(j) = 0;
            sprintf('%i-th row of areas filled with zeros',j)
        end
            
            
    end
end

 
x_list = (time_list-time_list(1))*24*60;
figure
% semilogy(x_list, f1, '-o', x_list, f2, '-s', 'MarkerFaceColor', 'k')
semilogy(x_list, area(:,1)./area(:,2), '-o')
axis([0 50 1 200])
semilogy(x_list, area2./area1, '-o')
xlabel('time, min')
ylabel('I_{YH_3}/I_{YH_2}')
title('Peak ratio during YH_2 to YH_3 transition')

%}
%% vertical lines for H2, F1 and heating

if isfield(Input, 'h2_on')
    for i=length(Input.h2_on):-1:1
        if Input.h2_on(i) < Input.num_range(1) || Input.h2_on(i) > Input.num_range(end)
            sprintf('%i-th h2_on value out of range of scans', i)
            h2_on_time(i) = NaN;
        else
            I = find(Input.h2_on(i) == Input.num_range);
            h2_on_time(i) = time(I);
        end
    end
    h2_on_time = (h2_on_time(~isnan(h2_on_time)) - time_list(1))*24*60; % delete NaN-values
end
if isfield(Input, 'h2_off')
    for i=length(Input.h2_off):-1:1
        if Input.h2_off(i) < Input.num_range(1) || Input.h2_off(i) > Input.num_range(end)
            sprintf('%i-th h2_off value out of range of scans', i)
            h2_off_time(i) = NaN;
        else
            I = find(Input.h2_off(i) == Input.num_range);
            h2_off_time(i) = time(I);
        end
    end
    h2_off_time = (h2_off_time(~isnan(h2_off_time)) - time_list(1))*24*60; % delete NaN-values
end

if isfield(Input, 'f1_on')
    for i=length(Input.f1_on):-1:1
        if Input.f1_on(i) < Input.num_range(1) || Input.f1_on(i) > Input.num_range(end)
            sprintf('%i-th f1_on value out of range of scans', i)
            f1_on_time(i) = NaN;
        else
            I = find(Input.f1_on(i) == Input.num_range);
            f1_on_time(i) = time(I);
        end
    end
    f1_on_time = (f1_on_time(~isnan(f1_on_time)) - time_list(1))*24*60; % delete NaN-values
end
if isfield(Input, 'f1_off')
    for i=length(Input.f1_off):-1:1
        if Input.f1_off(i) < Input.num_range(1) || Input.f1_off(i) > Input.num_range(end)
            sprintf('%i-th f1_on value out of range of scans', i)
            f1_off_time(i) = NaN;
        else
            I = find(Input.f1_off(i) == Input.num_range);
            f1_off_time(i) = time(I);
        end
    end
    f1_off_time = (f1_off_time(~isnan(f1_off_time)) - time_list(1))*24*60; % delete NaN-values
end

if isfield(Input, 'heating_on')
    for i=length(Input.heating_on):-1:1
        if Input.heating_on(i) < Input.num_range(1) || Input.heating_on(i) > Input.num_range(end)
            sprintf('%i-th heating_on value out of range of scans', i)
            heating_on_time(i) = NaN;
        else
            I = find(Input.heating_on(i) == Input.num_range);
            heating_on_time(i) = time(I);
        end
    end
    heating_on_time = (heating_on_time(~isnan(heating_on_time)) - time_list(1))*24*60; % delete NaN-values
end
if isfield(Input, 'heating_off')
    for i=length(Input.heating_off):-1:1
        if Input.heating_off(i) < Input.num_range(1) || Input.heating_off(i) > Input.num_range(end)
            sprintf('%i-th heating_off value out of range of scans', i)
            heating_off_time(i) = NaN;
        else
            I = find(Input.heating_off(i) == Input.num_range);
            heating_off_time(i) = time(I);
        end
    end
    heating_off_time = (heating_off_time(~isnan(heating_off_time)) - time_list(1))*24*60; % delete NaN-values
end

%% simple 2Theta plot
%{
color = ['r', 'k', 'b', 'c'];

figure
hold on
j = 1;
for i = length(interpInt(1,:)):-1:1
    plot(Input.angles', (interpInt(:, i)), '--o', 'Color', color(j) )
    j = j + 1;
    if j > 4
        j = 1;
    end
end
clear i j
xlabel('2\theta, deg.');
ylabel('I, counts')
return
%}
%% Peak Widths and locations
% %{
%  interpInt = background_subs( Input.angles', interpInt, 'lin', Input.bkgrd, 0 );
fit_params1 = fit_peaks( Input.angles', interpInt, Input, 'testfun', 1);
[ locations, widths, peaks ] = peaks_struct2array( fit_params1 );
if Input.is_time_axis && Input.is_display_locs_widths
        x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
        label = 'time, min';
%         x_list = Input.num_range;
%         label = 'scan number'
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
%}
%{
peaks(9).locs = [peaks(9).locs(1), peaks(9).locs(3), peaks(9).locs(2)]
peaks(9).widths = [peaks(9).widths(1), peaks(9).widths(3), peaks(9).widths(2)]
for l = [10:12, 15, 16, 42:54]
    peaks(l).locs = [peaks(l).locs(1), NaN, peaks(l).locs(2)]
    peaks(l).widths = [peaks(l).widths(1), NaN, peaks(l).widths(2)]
end
for l = [13,14, 55:58]
    peaks(l).locs = [NaN, NaN, peaks(l).locs(1)]
    peaks(l).widths = [NaN, NaN, peaks(l).widths(1)]
end
%}

%% Scherrer's equation: crystallite size
%widths, locs = [Y or YH3 peak, Y peak, YH2 peak]
% %{
K = 0.94;
Lambda = 0.061992;% nm

W_rad = sqrt(widths.^2 - repmat(0.05, size(widths), 1).^2).*pi./180;
tay = K.*Lambda./W_rad./cosd(locations)
figure
plot(x_list, tay(:,1), 'ok', x_list, tay(:,2), 'ob', x_list, tay(:,3), 'or')
xlabel(label)
ylabel('Crystallite size, nm')
%}

%% Fitting with Lorentzian

%{

fit_params = fit_peaks( Input.angles', interpInt, Input, 'gauss', 1);
for j=length(fit_params):-1:1
    switch length(fit_params(j).locs)
        case 1
            flocations(j,:) = [fit_params(j).locs', NaN, NaN];
            fwidths(j,:) = [fit_params(j).widths', NaN, NaN];
        case 2
            flocations(j,:) = [fit_params(j).locs, NaN];
            fwidths(j,:) = [fit_params(j).widths, NaN];
        case 3
            flocations(j,:) = [fit_params(j).locs'];
            fwidths(j,:) = [fit_params(j).widths'];    
        case 0
            flocations(j,:) = [NaN, NaN, NaN];
            fwidths(j,:) = [NaN, NaN, NaN];
    end 
end
x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
label = 'time, min';
figure
subplot(2, 1, 1)
plot(x_list, flocations(:,1), 'ok', x_list, flocations(:,2), 'ob', x_list, flocations(:,3), 'or')
xlabel(label)
ylabel(dataylabel)
subplot(2, 1, 2)
plot(x_list, fwidths(:,1), 'ok', x_list, fwidths(:,2), 'ob', x_list, fwidths(:,3), 'or')
xlabel(label)
ylabel('FWHM, deg')
%}

%% scan number or time plot

% s = sprintf('2%s, %c', '\theta', char(176));% degree symbol %%%%% <---- TO CHANGE
tlabel = sprintf('T, K');
ymin = min(Input.angles);
ymax = max(Input.angles);
    
if Input.is_time_axis
    display('Time plot')
    x_list = (time_list-time_list(1))*24*60;% relative time to the first measurement in minutes
    label = 'time, min';
else
    display('chi plot')
    x_list = incidence;
    label = 'angle of incidence, deg.';
end
figure;
[X, Y] = meshgrid(x_list, Input.angles);
if Input.is_Tplot
    dataplot = subplot(4,1,[1,2,3]);
    data = contour(X,Y,interpInt, 'LevelStep', 50);
    shading interp
    colormap(jet(256))
    h = colorbar('northoutside');
    h.Label.String = 'I, log scale';
    axis tight
    ylabel(dataylabel)
%     title(graph_title)
    dataplot.XLim = dataplot.XLim + [-0.5, 0.5];
    dataplot.YLim = [ymin ymax];
    dataplot.YTick = [ ymin:0.5:ymax ];
    ax = gca;
    hold on
    if Input.is_lines% vertical identifiers of h2, f1 and heating on/off
    
        if exist('h2_on_time','var') && ~isempty(h2_on_time)
            for i=1:length(h2_on_time)
                h2on_l(i) = line([h2_on_time(i) h2_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'b', 'LineWidth', linewidth);
            end
        end
        if exist('h2_off_time','var') && ~isempty(h2_off_time)
            for i=1:length(h2_off_time)
                h2off_l(i) = line([h2_off_time(i) h2_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'b', 'LineWidth', linewidth);
            end
        end
        if exist('f1_on_time','var') && ~isempty(f1_on_time)
            for i=1:length(f1_on_time)
               f1on_l(i) =  line([f1_on_time(i) f1_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'k', 'LineWidth', linewidth);
            end
        end
        if exist('f1_off_time','var') && ~isempty(f1_off_time)
            for i=1:length(f1_off_time)
                f1off_l(i) = line([f1_off_time(i) f1_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'k', 'LineWidth', linewidth);
            end
        end
        if exist('heating_on_time','var') && ~isempty(heating_on_time)
            for i=1:length(heating_on_time)
                heaton_l(i) = line([heating_on_time(i) heating_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'r', 'LineWidth', linewidth);
            end
        end
        if exist('heating_off_time','var') && ~isempty(heating_off_time)
            for i=1:length(heating_off_time)
                heatoff_l(i) = line([heating_off_time(i) heating_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'r', 'LineWidth', linewidth);
            end
        end
    end

    tplot = subplot(4,1,4);
    plot(x_list, T, '--or')
    axis tight
    tplot.YLim = [450 480];
    tplot.YTick = [ 300 350 400 450 500];
    xlabel(label)
    ylabel(tlabel)
    tplot.XLim = tplot.XLim + [-0.5, 0.5];
    bx = gca;
    hold on
    if Input.is_lines% vertical identifiers of h2, f1 and heating on/off
    
        if exist('h2_on_time','var') && ~isempty(h2_on_time)
            for i=1:length(h2_on_time)
                h2on_l(i) = line([h2_on_time(i) h2_on_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'b', 'LineWidth', linewidth)
            end
        end
        if exist('h2_off_time','var') && ~isempty(h2_off_time)
            for i=1:length(h2_off_time)
                h2off_l(i) = line([h2_off_time(i) h2_off_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'b', 'LineWidth', linewidth);
            end
        end
        if exist('f1_on_time','var') && ~isempty(f1_on_time)
            for i=1:length(f1_on_time)
               f1on_l(i) =  line([f1_on_time(i) f1_on_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'k', 'LineWidth', linewidth)
            end
        end
        if exist('f1_off_time','var') && ~isempty(f1_off_time)
            for i=1:length(f1_off_time)
                f1off_l(i) = line([f1_off_time(i) f1_off_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'k', 'LineWidth', linewidth)
            end
        end
        if exist('heating_on_time','var') && ~isempty(heating_on_time)
            for i=1:length(heating_on_time)
                heaton_l(i) = line([heating_on_time(i) heating_on_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'r', 'LineWidth', linewidth)
            end
        end
        if exist('heating_off_time','var') && ~isempty(heating_off_time)
            for i=1:length(heating_off_time)
                heatoff_l(i) = line([heating_off_time(i) heating_off_time(i)], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'r', 'LineWidth', linewidth)
            end
        end
    end
else
    contour(X,Y,log10(interpInt), 'LevelStep', 0.03);
    shading interp
    colormap(jet(256))
    h = colorbar('northoutside');
    h.Label.String = 'I, log scale';
    axis tight
    xlabel(label)
    ylabel(dataylabel)
%     title(graph_title)
    if Input.is_lines% vertical identifiers of h2, f1 and heating on/off
    
        if exist('h2_on_time','var') && ~isempty(h2_on_time)
            for i=1:length(h2_on_time)
                h2on_l(i) = line([h2_on_time(i) h2_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'b', 'LineWidth', linewidth)
            end
        end
        if exist('h2_off_time','var') && ~isempty(h2_off_time)
            for i=1:length(h2_off_time)
                h2off_l(i) = line([h2_off_time(i) h2_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'b', 'LineWidth', linewidth)
            end
        end
        if exist('f1_on_time','var') && ~isempty(f1_on_time)
            for i=1:length(f1_on_time)
               f1on_l(i) =  line([f1_on_time(i) f1_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'k', 'LineWidth', linewidth)
            end
        end
        if exist('f1_off_time','var') && ~isempty(f1_off_time)
            for i=1:length(f1_off_time)
                f1off_l(i) = line([f1_off_time(i) f1_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'k', 'LineWidth', linewidth)
            end
        end
        if exist('heating_on_time','var') && ~isempty(heating_on_time)
            for i=1:length(heating_on_time)
                heaton_l(i) = line([heating_on_time(i) heating_on_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'r', 'LineWidth', linewidth)
            end
        end
        if exist('heating_off_time','var') && ~isempty(heating_off_time)
            for i=1:length(heating_off_time)
                heatoff_l(i) = line([heating_off_time(i) heating_off_time(i)], [Input.angles(1) Input.angles(end)], 'Color', 'r', 'LineWidth', linewidth)
            end
        end
    end
end

    
%     ms = surface(X,Y,log10(interpInt));
%     surf(n_scan_list, angle_list, intensity_2d,'edgeColor', 'None');
%     set(main_plot, 'TickDir', 'out')%, 'XLim', [x_list(1) x_list(end)], 'YLim', [y_startm y_endm]);
  
      
%{
l = line([40 40], [tplot.YLim(1) tplot.YLim(2)], 'Color', 'b', 'LineWidth', linewidth)
plot(ax, l)
%}


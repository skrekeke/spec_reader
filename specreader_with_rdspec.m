
function [a, T_ave, time, mask_length, gam, chi, del] = specreader_with_rdspec( Input )
%import data of specified scan numbers to a struct array
% 
% by Olena Soroka 
% July 2016
%% Input
file = 'D:\Data\ESRF 2016\MA-2866\Alignment_SixC.spec';
num_range = int32(Input.num_range);

%% 
for i= length(num_range):-1:1
    a(i) = rdspec(file, num_range(i));% struct array with all scan data
end


for i= length(num_range):-1:1% for N_i scan write mask of length, 
    if ~isempty(a(i).data)
        if sum(length(a(i).data(:,1)) == Input.points)
            mask_length(i) = true;
        else
            mask_length(i) = false; 
        end
    else
        mask_length(i) = false;
    end
    for k=1:length(a(i).head)% indexes of T_euro, filter, angles
        if strcmp(a(i).head{k} , 'T_euro')
            t_euroI = int16(k);
        end
        if strcmp(a(i).head{k}, 'transm')
            transmI = int16(k);
        end
        if strcmp(a(i).head{k}, 'Gamma')
            gammaI = int32(k);
        end
        if strcmp(a(i).head{k}, 'Chi')
            chiI = int32(k);
        end
        if strcmp(a(i).head{k}, 'Delta')
            deltaI = int32(k);
        end
    end

    if ~isempty(a(i).data)
        a(i).data(:,end) = a(i).data(:,end)./a(i).data(:,transmI); % normalize detector on filter

        T_ave(i) = sum(a(i).data(:,t_euroI))/length(a(i).data(:,t_euroI)); % Temperature vs scan number
    else
        T_ave(i) = NaN;
    end
    
    
    
    time(i) = datenum(datetime({a(i).time(3:end)}, 'InputFormat',' eee MMM dd HH:mm:ss yyyy')); %time vs scan number
    
          
    if exist('gammaI','var') %% gam, chi and del -- arrays of header index, 0 if doesnt exist
        gam(i) = gammaI;
    else
        gam(i) = 0;
    end
    if exist('chiI','var')
        chi(i) = chiI;
    else
        chi(i) = 0;
    end
    if exist('deltaI','var')
        del(i) = deltaI;
    else
        del(i) = 0;
    end
    clear deltaI gammaI chiI
    
end

time = time(:,mask_length);
del = del(:,mask_length);
gam = gam(:,mask_length);
chi = chi(:,mask_length);
T_ave = T_ave(:,mask_length);
a = a(:,mask_length);
  
end


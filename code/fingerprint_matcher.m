function [match] = fingerprint_matcher( inputfile )
%FINGERPRINT_MATCHER The matcher of an acclerometer data input
%   The input file is a CSV-file with acclereometer data in column 5-7 

th1 = 1; %threshold number 1
th2 = 1; %threshold number 2
nbrOfDeviceIDinSystem = 140;
nbrOfDevicesInSystem = 59;

foundDevices = 0;
labels = cell(1,nbrOfDevicesInSystem);
ansAcc(4,nbrOfDevicesInSystem) = 0;

inputData = importdata(inputfile);
in_acc = inputData.data(:,5:7); % Acc data is in column 5-7

    
compSamples = 600; %number of sample used to compare
for iii = 1:nbrOfDeviceIDinSystem
    if iii<10 
        name = ['00' num2str(iii)];
    elseif iii<100 
        name = ['0' num2str(iii)];
    else
        name = num2str(iii);
    end
    
    file_out = ['db/' name '.mat'];
    if exist(file_out, 'file')
        foundDevices = foundDevices +1;
        mat = importdata(file_out);
        labels{foundDevices} = mat.name;
        diff_acc = pdist2(in_acc(1:compSamples,:),mat.acc(1:compSamples,:));
        ansAcc(1,foundDevices) = mean2(diff_acc);
        ansAcc(2,foundDevices) = max(diff_acc(:));
        ansAcc(3,foundDevices) = min(diff_acc(:));
        ansAcc(4,foundDevices) = median(diff_acc(:));
    end
end
% sort the distances, the shortest distance is the one matching
[sort_acc, ind_mean] = sort(ansAcc(1,:));
[sort_acc, ind_max] = sort(ansAcc(2,:));
[sort_acc, ind_min] = sort(ansAcc(3,:));
[sort_acc, ind_med] = sort(ansAcc(4,:));

%take the threshold 2 number of best matches of each feature 
out = [ind_mean(1:th2);ind_max(1:th2);ind_min(1:th2);ind_med(1:th2)];

%Counts which device_id that is most common
[M,F] = mode(out(:));

if(F>th1 && ~isempty(labels{M}))
    %MATCH, sending back deviceID of device with best match
    match = labels{M};
else
    %NO MATCH
    match = 0;
end
end
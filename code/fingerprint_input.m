function fingerprint_input( inputfile ,inputNbr)
%FINGERPRINT_INPUT Summary of this function goes here
%   Detailed explanation goes here
nbrOfDeviceInSystem = 140;
N = 59;
found = 0;
labels = cell(1,N);
th = ceil(N/20);
ansAcc(4,N) = 0;

inputData = importdata(inputfile);
in_acc = inputData.data(:,5:7); % Acc data is in column 5-7
    
compSamples = 600; %number of sample used in calculations
for iii = 1:nbrOfDeviceInSystem
    if iii<10 
        name = ['00' num2str(iii)];
    elseif iii<100 
        name = ['0' num2str(iii)];
    else
        name = num2str(iii);
    end
    
    file_out = ['mat/' name '.mat'];
    if exist(file_out, 'file')
        found = found +1;
        mat = importdata(file_out);
        labels{found} = mat.name;
        diff_acc = pdist2(in_acc(1:compSamples,:),mat.acc(1:compSamples,:));
        ansAcc(1,found) = mean2(diff_acc);
        ansAcc(2,found) = max(diff_acc(:));
        ansAcc(3,found) = min(diff_acc(:));
        ansAcc(4,found) = median(diff_acc(:));
    end
end
% sort by x first
[sort_acc, ind_mean] = sort(ansAcc(1,:));
[sort_acc, ind_max] = sort(ansAcc(2,:));
[sort_acc, ind_min] = sort(ansAcc(3,:));
[sort_acc, ind_med] = sort(ansAcc(4,:));
out = [ind_mean(1:th);ind_max(1:th);ind_min(1:th);ind_med(1:th)];
[M,F] = mode(out(:));

if(labels{M} == inputNbr)
    fprintf('MATCH!!!\n')
else
    fprintf('no match, closes match was %s :(\n',labels{M})
end
end


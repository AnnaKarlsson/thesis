function fingerprint_calc(device_id)
%FINGERPRINT_CALC recivce the device id and save finerprint in a mat-file
%   The CSV-file is recived and being extracted to a fingerprint

file = ['recordning-' device_id '.csv'];
if exist(file, 'file')
    file = importdata(file) ;
    t = file.data(:,1) - file.data(1,1); %timestamps
    acc = file.data(:,5:7); % accelerometer data
    f_acc = [min(acc);
        mean(acc);
        median(acc);
        max(acc)];
    id = device_id;
    mat_name = ['db/' device_id '.mat'];
    if exist(mat_name, 'file')
        disp('Not saved, %s already exists',device_id);
    else
        save(mat_name, 'id','t','acc','f_acc'); %save to database
    end
end
end

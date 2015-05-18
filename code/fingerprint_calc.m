function fingerprint_calc(device_id)
file = ['recordning-' device_id '.csv'];
if exist(file, 'file')
    file = importdata(file) ;
    t = file.data(:,1) - file.data(1,1);
    acc = file.data(:,5:7);
    gyro = [sind(file.data(:,2)) cosd(file.data(:,3)) tand(file.data(:,4))];
    rot = file.data(:,8:10);
    
    f_acc = [min(acc);
        mean(acc);
        median(acc);
        max(acc)];
    id = device_id;
    mat_name = ['fingerprint/' device_id '.mat'];
    if exist(mat_name, 'file')
    else
        disp(mat_name);
        save(mat_name, 'id','t','acc','gyro','rot','f_acc');
    end
end
end

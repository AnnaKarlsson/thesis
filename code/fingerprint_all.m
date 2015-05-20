all = 140;

for i=1:all
    if(i>99)
        id = int2str(i);
    elseif(i>9)
        id = ['0' int2str(i)];
    else
        id = ['00' int2str(i)];
    end
    fingerprint_calc(id);
end
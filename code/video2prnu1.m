% Make images from video frames
shuttleVideo = VideoReader(filename);
i = 1;
while hasFrame(shuttleVideo)
   img = readFrame(shuttleVideo);
   fn = [sprintf([filename '_%03d'],i) '.jpg'];
   imwrite(img,fn);    % Write to a JPEG file
   i = i+1;
end

% Calculate PRNU from images
imagefiles = dir([filename '*.jpg']);      
for ii=1:nbr_of_images
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   img = im2double(currentimage);
   filtImg = medfilt2(img);
   noise = noise + ( img - filtImg ); % add noise from current image
end

prnu = noise / nbr_of_images; % get average noise 

% width and heigt is saved for comparing correlation with images of different size
save(filename, 'prnu'); 
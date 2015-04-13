load(prnu_mat);
% Make it a flat vector instead than a matrix
prnu_vector = reshape( prnu, 1, numel( prnu ) );
% Calculate the mean PRNU value
p = prnu_vector - mean( prnu_vector );

ref_img = im2double( imread (imgname) );
noise = ref_img - medfilt2( ref_img ); % get noise by remove denosied image scene
img_vector = reshape( noise, 1, numel( ref_img ) ); % reshap to get same lenght as prnu 
i = img_vector - mean(img_vector); 

% calculate correlation between PRNU and reference image
correlation = ( i * ( p' ) ) / ( sqrt( i * i' ) * sqrt( p * p' ) );
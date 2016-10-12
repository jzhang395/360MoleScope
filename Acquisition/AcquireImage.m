function [ I ] = AcquireImage( url )
    close all;
    I = imread(url);
    I = imrotate(I,-90);
    figure; imshow(I); title('Acquired Image');
end


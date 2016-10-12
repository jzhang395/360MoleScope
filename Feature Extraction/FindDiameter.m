function [ y1 y2 ] = FindDiameter( I, centroids )
% Input: I is a BW image, centroids are the [x y] coordinates
% of the centroid of the blob.
% Output: [y1 y2] are the coordinates of the line passing
% through the centroid
cent_x = ceil(centroids(:,1));
cent_y = ceil(centroids(:,2));
pixel = ceil(centroids);
%% Move in +y direction until you hit a 0
while(I(pixel(2),pixel(1)))
    pixel(2) = pixel(2) + 1;
end
y1 = pixel(2);
%% Move in -y direction until you hit a 0
while((I(pixel(2), pixel(1)-1)))
    pixel(2) = pixel(2) - 1;
end
y2 = pixel(2)+1;
end


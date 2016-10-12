function [ Masked ] = SmoothEdges( I )
I = im2double(I);
% Segment the object:
gs = rgb2gray(I);
Object=~im2bw(gs, graythresh(gs));

% Smoothen the mask:
BW = bwmorph(bwconvhull(Object), 'erode', 5);
Mask=repmat(BW,[1,1,3]);

% Iterate opening operation:
Interp=I;
for k=1:5
    Interp=imopen(Interp, strel('disk',20));
end

% Keep original pixels, add the newly generated ones and smooth the output:
Interpolated(:,:,1)=medfilt2(imadd(I(:,:,1).*Object, Interp(:,:,1).*~(BW==Object)), [4 4]);
Interpolated(:,:,2)=medfilt2(imadd(I(:,:,2).*Object, Interp(:,:,2).*~(BW==Object)), [4 4]);
Interpolated(:,:,3)=medfilt2(imadd(I(:,:,3).*Object, Interp(:,:,3).*~(BW==Object)), [4 4]);

% Display the results:
Masked=imadd(Interpolated.*im2double(Mask), im2double(~Mask));
imshow(Masked);
end


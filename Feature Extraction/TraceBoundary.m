% Test test
function [ boundary ] = TraceBoundary( I_bw )
% I = imread(filename);
% %figure; imshow(I); 
% %LEVEL = graythresh(I);
% BW = im2bw(I);
% BW = imcomplement(BW);
% BW = imclose(BW,strel('disk',20));
%figure; imshow(BW);
% figure; imshowpair(I,BW,'montage');

dim = size(I_bw)
col = round(dim(2)/2)-90;
row = min(find(I_bw(:,col)));

boundary = bwtraceboundary(I_bw,[row, col],'N');
%BW_filled = imfill(BW,'holes');
%boundaries = bwboundaries(BW_filled);

%{
for k=1:10
   b = boundaries{k};
   plot(b(:,2),b(:,1),'g','LineWidth',3);
end
%}
end 
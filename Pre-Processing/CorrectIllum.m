%% Correcting Nonuniform Illumination
function I_corrected = CorrectIllum( I )
%% Step 1: Read Image
I = rgb2gray(I);
figure('Name','(Step 1) Convert Image to Grayscale'); imshow(I);

%% Step 2: Use Morphological Opening to Estimate the Background
background = imopen(I,strel('disk',300));
% Display the Background Approximation as a Surface
figure('Name','(Step 2) Display the Background Approximation as a Surface');
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
ax = gca;
ax.YDir = 'reverse';

%% Step 3: Subtract the Background Image from Original Image
I2 = I - background;

%% Step 4: Increase Image Contrast 
I3 = imadjust(I2);
figure('Name','(Step 3-4) Subtract Background and Increase Image Contrast');
imshow(I3);
I_corrected = I3;

%% Step 5: Threshold the Image
% bw = imbinarize(I3);
% bw = bwareaopen(bw, 50);
% figure('Name','(Step 5) Threshold Image');
% imshow(bw);
% 
%% Step 6: Identify Objects in Image
% cc = bwconncomp(bw, 4)
% 
%% Step 7: Examine One Object
% %grain = false(size(bw));
% %grain(cc.PixelIdxList{50}) = true;
% %imshow(grain);
% 
%% Step 8: View All Objects
% labeled = labelmatrix(cc);
% whos labeled
% 
% RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
% figure('Name','(Step 8) View all Objects');
% imshow(RGB_label)
% 
%% Step 9: Compute Area of Each Object 
% graindata = regionprops(cc,'basic');
% graindata(50).Area;
% 
%% Step 10: Compute Area-based Statistics 
% grain_areas = [graindata.Area];
% [max_area, idx] = max(grain_areas)
% grain = false(size(bw));
% grain(cc.PixelIdxList{idx}) = true;
% figure('Name','(Step 10) View Largest Area');
% imshow(grain);
% 
%% Step 11: Create Histogram of the Area
% %figure('Name','(Step 11) Histogram of Areas');
% %histogram(grain_areas);
% %title('Histogram of Areas');
% 
% figure('Name','Original Image vs. Mole Alone'); imshowpair(I,grain,'montage');
% title('Original Image                                   Isolated Mole Image');


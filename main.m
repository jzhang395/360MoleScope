%% main.m is the script that calls the rest of the functions.
% Inputs: none
% Outputs: A set of features &/or time course plots of these features.
% Group 11 - MoleScope
% Last Modified: 10/5/2016 
% test
%% Acquire Image
close all; clc; clear all;
% I = AcquireImage('http://172.16.1.70/download/44C2EE37-1D44-4A4D-93FC-7B3C0E8D5127/0,');
% I = imcrop(I);
I = imread('trueMelanoma.jpg');
% I = imread('mole2.jpeg');
I = imcrop(I);

%% Median and Gaussian filter of each channel
r = (I(:,:,1)); 
g = (I(:,:,2));
b = (I(:,:,3));
r_filt = imgaussfilt(medfilt2(r, [7 7]),2.5);
g_filt = imgaussfilt(medfilt2(g, [7 7]),2.5);
b_filt = imgaussfilt(medfilt2(b, [7 7]),2.5);
I_filt = cat(3, r_filt, g_filt, b_filt);
imshowpair(I, I_filt, 'montage')

%% Image Segmentation based on colors
I_seg = KMeansMoleSeg(I_filt,2);
figure; imshow(I_seg{1});
figure; imshow(I_seg{2});
I_mole = rgb2gray(I_seg{1});

%% Remove holes and binarize image
I_fill = imfill(I_mole,'holes'); 
figure; imshow(I_fill);
I_bw = imbinarize(I_fill,'adaptive','ForegroundPolarity','bright','Sensitivity',1);
I_bw = bwareaopen(I_bw, 1000);
I_dil = imdilate(I_bw, strel('disk', 10));
figure;
imshowpair(I_bw, I_dil, 'montage');
%% Get boundary
boundary = BoundaryTracing(I_dil);
figure(5); imshow(I_bw); title('Boundary Tracing');
hold on;
plot(boundary(:,2),boundary(:,1),'g','LineWidth',3);

[ellipse, pts] = fit_ellipse(boundary(:,2), boundary(:,1), length(boundary), figure(5));
pts= pts';
[r2 rmse] = rsquare(boundary(:,2), pts(:,2));
%%
s = regionprops(I_dil, 'Orientation', 'MajorAxisLength', ...
    'MinorAxisLength', 'Eccentricity', 'Centroid');
imshow(I_dil)
hold on

phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

for k = 1:length(s)
    xbar = s(k).Centroid(1);
    ybar = s(k).Centroid(2);

    a = s(k).MajorAxisLength/2;
    b = s(k).MinorAxisLength/2;

    theta = pi*s(k).Orientation/180;
    R = [ cos(theta)   sin(theta)
         -sin(theta)   cos(theta)];

    xy = [a*cosphi; b*sinphi];
    xy = R*xy;

    x = xy(1,:) + xbar;
    y = xy(2,:) + ybar;

    plot(x,y,'r','LineWidth',2);
end
hold off
%% Logical operation to cut out image
I_cut = I.*uint8(I_dil);
figure; imshow(I_cut);

%%


%% Feature Extraction
% [f1 f2 f3 f4 ...] = extractFeatures(I_bw);

%% Time Course Demo
% First demonstrate a live example to Dr. Suggs on a well-defined mole for
% demo-day. Then, demonstrate how this can be used for a series of mole images 
% to track over time.

% {various plots} = featureAnalysis[f1 f2 f3 f4 ...];
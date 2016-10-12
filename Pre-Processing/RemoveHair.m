function [ I_hairgone ] = RemoveHair( I )
%% Identify dark hair locations
%separate into 3 color bands
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

%structural elements at 0, 45, 90 and 135 degrees
level1 = 12;
se0 = strel('line',level1,0);  
se45 = strel('line',level1,45);
se90 = strel('line',level1,90);
se135 = strel('line',level1,135);

%morphological closing for red band with SE's
Rclose1 = imclose(R,se0);
Rclose2 = imclose(R,se45);
Rclose3 = imclose(R,se90);
Rclose4 = imclose(R,se135);
Rclose = max(max(max(Rclose1,Rclose2),Rclose3),Rclose4);
%for green band
Gclose1 = imclose(G,se0);
Gclose2 = imclose(G,se45);
Gclose3 = imclose(G,se90);
Gclose4 = imclose(G,se135);
Gclose = max(max(max(Gclose1,Gclose2),Gclose3),Gclose4);
%for blue band
Bclose1 = imclose(B,se0);
Bclose2 = imclose(B,se45);
Bclose3 = imclose(B,se90);
Bclose4 = imclose(B,se135);
Bclose = max(max(max(Bclose1,Bclose2),Bclose3),Bclose4);

%figure, imagesc(Rclose), title('Rclose');
%figure, imagesc(Gclose), title('Gclose');
%figure, imagesc(Bclose), title('Bclose');

%create hair mask
Gr = mat2gray(imsubtract(Rclose,R));
Gg = mat2gray(imsubtract(Gclose,G));
Gb = mat2gray(imsubtract(Bclose,B));

%figure, imagesc(Gr), title('gray red');
%figure, imagesc(Gg), title('gray green');
%figure, imagesc(Gb), title('gray blue');

%convert to binary 
level2 = .1;
Mr = im2bw(Gr, level2);
Mg = im2bw(Gg, level2);
Mb = im2bw(Gb, level2);
Mask = max(max(Mr,Mg),Mb);

%figure, imagesc(Mr), title('binary red');
%figure, imagesc(Mg), title('binary green');
%figure, imagesc(Mb), title('binary blue');
figure, imagesc(Mask), title('Hair Mask'); 

%% Replace the hair pixels by the nearby non-hair pixels
%ensuring that each pixel in Mask is located within a thin and long structure
Mclean = bwareaopen(Mask, 50, 8);
figure, imagesc(Mclean), title('Filtered Hair Mask');

%replace lost hair pixels with neighboring pixels via interpolation
R2 = regionfill(R, Mclean);
G2 = regionfill(G, Mclean);
B2 = regionfill(B, Mclean);
replacedImage = cat(3, R2, G2, B2);
figure, imagesc(replacedImage), title('Interpolated Image');

%% Smooth out the final result
%morphological opening
sedisk = strel ('disk',2);
R3 = imopen(R2,sedisk);
G3 = imopen(G2,sedisk);
B3 = imopen(B2,sedisk);
filterImage = cat(3, R3, G3, B3);
figure, imagesc(filterImage), title('Filtered Image')

%apply a median filter
R4 = medfilt2(R3);
G4 = medfilt2(G3);
B4 = medfilt2(B3);
I_hairgone = cat(3, R4, G4, B4);
figure, imagesc(I_hairgone), title('Final Image')

end


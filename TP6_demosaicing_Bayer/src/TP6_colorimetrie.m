clc; clear all; close all;

I = imread('Ima_phare.tif');   
figure; 
imshow(I); title('Image originale')

Ired=I(:,:,1);
Igreen = I(:,:,2);
Iblue = I(:,:,3);
figure;
subplot(2,2,1); imshow(Ired); title('R');
subplot(2,2,2); imshow(Igreen); title('G');
subplot(2,2,3); imshow(Iblue); title('B');

CFA = bayer(I);
figure; 
imshow(CFA); title('Image CFA')

gbrg = demosaic(CFA,"gbrg");
grbg = demosaic(CFA,"grbg");
bggr = demosaic(CFA,"bggr");
rggb = demosaic(CFA,"rggb");
figure;
subplot(2,2,1); imshow(gbrg); title('GBRG');
subplot(2,2,2); imshow(grbg); title('GRBG');
subplot(2,2,3); imshow(bggr); title('BGGR');
subplot(2,2,4); imshow(rggb); title('RGGB');

CFAred = rggb(:,:,1);
CFAgreen = rggb(:,:,2);
CFAblue = rggb(:,:,3);
diffRed = double(Ired-CFAred);
diffGreen = double(Igreen-CFAgreen);
diffBlue=double(Iblue-CFAblue);
distanceColorimetrique = sqrt(diffRed.^2 + diffGreen.^2 + diffBlue.^2);
figure;
imshow(distanceColorimetrique,[]); title('Distance colorimétrique');

L1a1b1=rgb2lab(I);
L2a2b2=rgb2lab(rggb);
deltaE = sqrt((L2a2b2(:,:,1) - L1a1b1(:,:,1)).^2 + (L2a2b2(:,:,2) - L1a1b1(:,:,2)).^2 + (L2a2b2(:,:,3) - L1a1b1(:,:,3)).^2);
figure;
imshow(deltaE, []); title('Delta E 76');

% la methode delta e76 est meilleure visuellement (moins pixelisée)
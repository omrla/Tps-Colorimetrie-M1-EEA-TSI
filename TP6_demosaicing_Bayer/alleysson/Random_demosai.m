%David Alleysson Janvier 2010
%DemosaicRandom
%Simulation program related to 
%Spatially Coherent Image Reconstruction from a Trichromatic Mosaic with
%Random Arrangement of Chromatic samples
%Ophalmic and Physiological Optic, Special Issue, nXX, ppXX, 2010
%This code is for research only and protected by
%FR07/04181 and PCTFR2008000806

close all
clear all

%Read an image from disk
%change file with your image
%image should be a colour image with three channel (i.e. RGB)
I = double(imread('TestImage.jpg'))/255;
figure
image(I)
axis('image')
title('Original Image')

%getting the size of the image
[H W P] = size(I);

%Create the random trichromatic mosaic
tmp = rand(H,W);
mR = tmp<1/3;
mG = (tmp>=1/3) & (tmp<2/3);
mB = (tmp>2/3);
figure
image(cat(3,mR,mG,mB))
axis('image')
title('Random trichromatic mosaic')

%Create the image as it is sampled by the mosaic
I2 = cat(3,I(:,:,1).*mR,I(:,:,2).*mG,I(:,:,3).*mB);


%Create a BW image from the mosaic to simulate
%responses of photoreceptors
CFA = sum(I2,3);
figure
image(CFA*255)
colormap(gray(256))
axis('image')
title('Simulated cone responses')

%spatial filter
f = [1 2 1
     2 4 2
     1 2 1];
f = conv2(conv2(f,f),f); %extension of the filter on a larger size
f = f/sum(f(:)); %normalisation of the filter


%Estimation of achromatic information with normalized convolution
L = conv2(I2(:,:,1),f,'same')./conv2(double(mR),f,'same')+...
    conv2(I2(:,:,2),f,'same')./conv2(double(mG),f,'same')+...
    conv2(I2(:,:,3),f,'same')./conv2(double(mB),f,'same');

%estimation of Parvocellular information (i.e. removal of low frequencies
% achromatic from the mosaic)
Parvo = CFA-L;

%Demultiplexage of Parvo information
Chr = cat(3,Parvo.*mR,Parvo.*mG,Parvo.*mB);
%Interpolation of the chrominance by normalized convolution
Chr2(:,:,1) = conv2(Chr(:,:,1),f,'same')./conv2(double(mR),f,'same');
Chr2(:,:,2) = conv2(Chr(:,:,2),f,'same')./conv2(double(mG),f,'same');
Chr2(:,:,3) = conv2(Chr(:,:,3),f,'same')./conv2(double(mB),f,'same');

%Reconstruction of colour image as a sum of luminance + chrominance
I3 = cat(3,L+Chr2(:,:,1),L+Chr2(:,:,2),L+Chr2(:,:,3));
figure
image(double(uint8(I3*255))/255)
axis('image')
title('Reconstructed image')

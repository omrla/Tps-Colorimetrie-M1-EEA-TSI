%function  Image_CFA  = bayer(Input_RGB,taille)
%     ImageCFA = zeros(16,16);%%%!!!!
%     for i=1:2:taille(1)-1    
%         for j=1:2:taille(2)-1
%             
%             Image_CFA(i,j) = Input_RGB(i,j,2);
%             Image_CFA(i,j+1) = Input_RGB(i,j+1,3);
%             Image_CFA(i+1,j) = Input_RGB(i+1,j,1);
%             Image_CFA(i+1,j+1) = Input_RGB(i+1,j+1,2);
% %             CFA1(i,j,1) = Input_RGB(i,j,1);
% %             CFA1(i,j+1,2) = Input_RGB(i,j+1,2);
% %             CFA1(i+1,j,2) = Input_RGB(i+1,j,2);
% %             CFA1(i+1,j+1,3) = Input_RGB(i+1,j+1,3);
%         end
%     end
%   %Image_CFA(1:taille(1)-1,:)=Image_CFA(2:taille(1),:);
%   Image_CFA(:,1:taille(2)-1)=Image_CFA(:,2:taille(2));
function  CFA  = bayer1(Input_RGB)

   %Input_RGB = imread('image/Demosaic5.tif');

    % Récupere notre image - RGB
    taille = size(Input_RGB);
    
    for i=1:2:taille(1)-1    
        for j=1:2:taille(2)-1
            
            CFA(i,j) = Input_RGB(i,j,1);
            CFA(i,j+1) = Input_RGB(i,j+1,2);
            CFA(i+1,j) = Input_RGB(i+1,j,2);
            CFA(i+1,j+1) = Input_RGB(i+1,j+1,3);
            CFA1(i,j,1) = Input_RGB(i,j,1);
            CFA1(i,j+1,2) = Input_RGB(i,j+1,2);
            CFA1(i+1,j,2) = Input_RGB(i+1,j,2);
            CFA1(i+1,j+1,3) = Input_RGB(i+1,j+1,3);
        end
    end
    %CFA1(:,:,1)=255;
    %CFA1(:,:,3)=0;
    %CFA1(:,:,2)=255;
%     subplot(1,2,1)
%     imshow(CFA);
%     subplot(1,2,2)
%     imshow(CFA1)
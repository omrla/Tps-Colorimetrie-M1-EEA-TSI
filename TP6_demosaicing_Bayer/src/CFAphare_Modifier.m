clear all
close all
clc
%%%%%%%%%Chargement de l'image%%%%%%

Image=imread('Ima_phare.tif');
ImageFiltre = zeros(16,16,3);

Taille = size(Image);

Image_CFA=bayer(Image,Taille);    %%%MATRICAGE_CFA%%%

%%%%%%%%%DEMATRICAGE CFA%%%%%%%%%%%%

for C=2:1:(Taille(2)-1)
   for L=2:1:(Taille(1)-1)
       detectC=mod(C,2);
       detectL=mod(L,2);
       
       if(detectC==0 && detectL==1)  
B1=Image_CFA(L+1,C-1)+Image_CFA(L+1,C+1)+Image_CFA(L-1,C-1)+Image_CFA(L-1,C+1);
Bc=(1/4)*B1;
V1=Image_CFA(L+1,C)+Image_CFA(L-1,C)+Image_CFA(L,C+1)+Image_CFA(L,C-1);
Vc=(1/4)*V1;
ImageFiltre(L,C,1)=Image_CFA(L,C);
ImageFiltre(L,C,2)=Vc;
ImageFiltre(L,C,3)=Bc;
       end
       if(detectC==1 && detectL==0 )  
 R1=Image_CFA(L+1,C-1)+Image_CFA(L+1,C+1)+Image_CFA(L-1,C-1)+Image_CFA(L-1,C+1);
 Rc=(1/4)*R1;
 V1=Image_CFA(L+1,C)+Image_CFA(L-1,C)+Image_CFA(L,C+1)+Image_CFA(L,C-1);
 Vc=(1/4)*V1;
 ImageFiltre(L,C,3)=Image_CFA(L,C);
 ImageFiltre(L,C,2)=Vc;
 ImageFiltre(L,C,1)=Rc;
       end
         if(detectC==1 && detectL==1 )  
 R1=Image_CFA(L,C-1)+Image_CFA(L,C+1);
 Rc=(1/2)*R1;
 B1=Image_CFA(L+1,C)+Image_CFA(L-1,C);
 Bc=(1/4)*B1;
 ImageFiltre(L,C,3)=Bc;
 ImageFiltre(L,C,2)=Image_CFA(L,C);
 ImageFiltre(L,C,1)=Rc;
         end
         if(detectC==0 && detectL==0 )  
 B1=Image_CFA(L,C-1)+Image_CFA(L,C+1);
 Bc=(1/2)*B1;
 R1=Image_CFA(L+1,C)+Image_CFA(L-1,C);
 Rc=(1/4)*B1;
 ImageFiltre(L,C,3)=Bc;
 ImageFiltre(L,C,2)=Image_CFA(L,C);
 ImageFiltre(L,C,1)=Rc;
         end
   end
end

%%%%%%%%%% Affichage %%%%%%

subplot(1,2,1);
imshow(Image_CFA);
subplot(1,2,2);
imshow(uint8(ImageFiltre));
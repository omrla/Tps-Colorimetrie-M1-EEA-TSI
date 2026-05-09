function Dematricage (Image,A)
Image_CFA=bayer(Image);
taille = size(Image_CFA);
Output_RGB = zeros(taille(1),taille(2),3);

Img_aux = zeros(taille(1)+2,taille(2)+2);
Img_aux(2:(taille(1)+1),2:(taille(2)+1)) = double(Image_CFA);

if A==1 %-- Interpolation Bilinéaire en utilisant une boucle!

%%%%Demosaicage du rouge:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux(i,j-1)+Img_aux(i,j+1))/2;
        
        elseif(mod(i,2)~=0 && mod(j,2)==0)
            Img_aux(i,j) = (Img_aux(i-1,j)+Img_aux(i+1,j))/2;
        
        elseif(mod(i,2)~=0 && mod(j,2)~=0)
            Img_aux(i,j)=(Img_aux(i-1,j-1)+Img_aux(i-1,j+1)+Img_aux(i+1,j+1)+Img_aux(i+1,j-1))/4;
        
        end
    
        
    end
end
Output_RGB(:,:,1)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;

%%%%Demosaicage du vert:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if mod(i+j,2)==0
           Img_aux(i,j)=(Img_aux(i-1,j)+Img_aux(i,j-1)+Img_aux(i,j+1)+Img_aux(i+1,j))/4;
        end
    end
end
Output_RGB(:,:,2)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;

%%%% Demosaicage du bleu:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)~=0 && mod(j,2)==0)
            Img_aux(i,j) = (Img_aux(i,j-1)+Img_aux(i,j+1))/2;
        elseif(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux(i-1,j)+Img_aux(i+1,j))/2;
        elseif(mod(i,2)==0 && mod(j,2)==0)
            Img_aux(i,j)=(Img_aux(i-1,j-1)+Img_aux(i-1,j+1)+Img_aux(i+1,j+1)+Img_aux(i+1,j-1))/4;
        end
    end
end
Output_RGB(:,:,3)=Img_aux(2:taille(1)+1,2:taille(2)+1);

%%% Réplication des Bords:
Output_RGB(1,:,1)=Output_RGB(2,:,1); Output_RGB(1,:,2)=Output_RGB(2,:,2); Output_RGB(1,:,3)=Output_RGB(2,:,3);
Output_RGB(taille(1),:,1)=Output_RGB(taille(1)-1,:,1); Output_RGB(taille(1),:,2)=Output_RGB(taille(1)-1,:,2); Output_RGB(taille(1),:,3)=Output_RGB(taille(1)-1,:,3);
Output_RGB(:,1,1)=Output_RGB(:,2,1); Output_RGB(:,1,2)=Output_RGB(:,2,2); Output_RGB(:,1,3)=Output_RGB(:,2,3);
Output_RGB(:,taille(2),1)=Output_RGB(:,taille(2)-1,1); Output_RGB(:,taille(2),2)=Output_RGB(:,taille(2)-1,2); Output_RGB(:,taille(2),3)=Output_RGB(:,taille(2)-1,3);
Output_RGB = uint8(Output_RGB);
end
if A==2
    %-- Interpolation sous la contrainte de constance de la teinte!

%%%%Demosaicage du vert:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if mod(i+j,2)==0
           Img_aux(i,j)=(Img_aux(i-1,j)+Img_aux(i,j-1)+Img_aux(i,j+1)+Img_aux(i+1,j))/4;
        end
    end
end
Img_aux1=Img_aux;
Output_RGB(:,:,2)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;

%%%Demosaicage du rouge:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)* (Img_aux(i,j-1)/Img_aux1(i,j-1)+Img_aux(i,j+1)/Img_aux1(i,j+1));
        elseif(mod(i,2)~=0 && mod(j,2)==0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)* (Img_aux(i-1,j)/Img_aux1(i-1,j)+Img_aux(i+1,j)/Img_aux1(i+1,j));
        elseif(mod(i,2)~=0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/4)*(Img_aux(i-1,j-1)/Img_aux1(i-1,j-1)+Img_aux(i-1,j+1)/Img_aux1(i-1,j+1)+Img_aux(i+1,j+1)/Img_aux1(i+1,j+1)+Img_aux(i+1,j-1)/Img_aux1(i+1,j-1));  
        end
    end
end
Output_RGB(:,:,1)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;
%%%Demosaicage du bleu:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)~=0 && mod(j,2)==0)
           Img_aux(i,j) = (Img_aux1(i,j)/2)*(Img_aux(i,j-1)/Img_aux1(i,j-1)+Img_aux(i,j+1)/Img_aux1(i,j+1));
        
        elseif(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)*(Img_aux(i-1,j)/Img_aux1(i-1,j)+Img_aux(i+1,j)/Img_aux1(i+1,j));
        elseif(mod(i,2)==0 && mod(j,2)==0)  
            Img_aux(i,j)=(Img_aux1(i,j)/4)*(Img_aux(i-1,j-1)/Img_aux1(i-1,j-1)+Img_aux(i-1,j+1)/Img_aux(i-1,j+1)+Img_aux(i+1,j+1)/Img_aux1(i+1,j+1)+Img_aux(i+1,j-1)/Img_aux(i+1,j-1));
        end
    end
end
Output_RGB(:,:,3)=Img_aux(2:taille(1)+1,2:taille(2)+1);

%%% Réplication des Bords:
Output_RGB(1,:,1)=Output_RGB(2,:,1); Output_RGB(1,:,2)=Output_RGB(2,:,2); Output_RGB(1,:,3)=Output_RGB(2,:,3);
Output_RGB(taille(1),:,1)=Output_RGB(taille(1)-1,:,1); Output_RGB(taille(1),:,2)=Output_RGB(taille(1)-1,:,2); Output_RGB(taille(1),:,3)=Output_RGB(taille(1)-1,:,3);
Output_RGB(:,1,1)=Output_RGB(:,2,1); Output_RGB(:,1,2)=Output_RGB(:,2,2); Output_RGB(:,1,3)=Output_RGB(:,2,3);
Output_RGB(:,taille(2),1)=Output_RGB(:,taille(2)-1,1); Output_RGB(:,taille(2),2)=Output_RGB(:,taille(2)-1,2); Output_RGB(:,taille(2),3)=Output_RGB(:,taille(2)-1,3);
Output_RGB = uint8(Output_RGB);
end
if A==3
    %-- Interpolation sous la contrainte de préservation des contours!

taille = size(Image_CFA);

Img_aux = zeros(taille(1)+2,taille(2)+2);
Img_aux(2:(taille(1)+1),2:(taille(2)+1)) = Image_CFA;

%%%Demosaicage du vert:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if mod(i+j,2)==0
           delta_H = abs(Img_aux(i,j-1)-Img_aux(i,j+1));
           delta_V = abs(Img_aux(i-1,j)-Img_aux(i+1,j));
           if delta_H<delta_V
              Img_aux(i,j) = (Img_aux(i-1,j)+Img_aux(i+1,j))/2;
           end
           if delta_H>delta_V
              Img_aux(i,j) = (Img_aux(i,j-1)+Img_aux(i,j+1))/2;
           else
             Img_aux(i,j) = (Img_aux(i-1,j)+Img_aux(i+1,j)+Img_aux(i,j-1)+Img_aux(i,j+1))/4;
           end
         end
    end
end
Img_aux1 = Img_aux;
Output_RGB(:,:,2)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;

%%%Demosaicage du rouge:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)* (Img_aux(i,j-1)/Img_aux1(i,j-1)+Img_aux(i,j+1)/Img_aux1(i,j+1));
        elseif(mod(i,2)~=0 && mod(j,2)==0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)* (Img_aux(i-1,j)/Img_aux1(i-1,j)+Img_aux(i+1,j)/Img_aux1(i+1,j));
        elseif(mod(i,2)~=0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/4)*(Img_aux(i-1,j-1)/Img_aux1(i-1,j-1)+Img_aux(i-1,j+1)/Img_aux1(i-1,j+1)+Img_aux(i+1,j+1)/Img_aux1(i+1,j+1)+Img_aux(i+1,j-1)/Img_aux1(i+1,j-1));  
        end
    end
end
Output_RGB(:,:,1)=Img_aux(2:taille(1)+1,2:taille(2)+1);
Img_aux(2:taille(1)+1,2:taille(2)+1) = Image_CFA;
%%%Demosaicage du bleu:
for i=2:taille(1)+1
    for j=2:taille(2)+1
        if(mod(i,2)~=0 && mod(j,2)==0)
           Img_aux(i,j) = (Img_aux1(i,j)/2)*(Img_aux(i,j-1)/Img_aux1(i,j-1)+Img_aux(i,j+1)/Img_aux1(i,j+1));
        
        elseif(mod(i,2)==0 && mod(j,2)~=0)
            Img_aux(i,j) = (Img_aux1(i,j)/2)*(Img_aux(i-1,j)/Img_aux1(i-1,j)+Img_aux(i+1,j)/Img_aux1(i+1,j));
        elseif(mod(i,2)==0 && mod(j,2)==0)  
            Img_aux(i,j)=(Img_aux1(i,j)/4)*(Img_aux(i-1,j-1)/Img_aux1(i-1,j-1)+Img_aux(i-1,j+1)/Img_aux(i-1,j+1)+Img_aux(i+1,j+1)/Img_aux1(i+1,j+1)+Img_aux(i+1,j-1)/Img_aux(i+1,j-1));
        end
    end
end
Output_RGB(:,:,3)=Img_aux(2:taille(1)+1,2:taille(2)+1);

%%% Réplication des Bords:
Output_RGB(1,:,1)=Output_RGB(2,:,1); Output_RGB(1,:,2)=Output_RGB(2,:,2); Output_RGB(1,:,3)=Output_RGB(2,:,3);
Output_RGB(taille(1),:,1)=Output_RGB(taille(1)-1,:,1); Output_RGB(taille(1),:,2)=Output_RGB(taille(1)-1,:,2); Output_RGB(taille(1),:,3)=Output_RGB(taille(1)-1,:,3);
Output_RGB(:,1,1)=Output_RGB(:,2,1); Output_RGB(:,1,2)=Output_RGB(:,2,2); Output_RGB(:,1,3)=Output_RGB(:,2,3);
Output_RGB(:,taille(2),1)=Output_RGB(:,taille(2)-1,1); Output_RGB(:,taille(2),2)=Output_RGB(:,taille(2)-1,2); Output_RGB(:,taille(2),3)=Output_RGB(:,taille(2)-1,3);
Output_RGB = uint8(Output_RGB);
end
if A==4
    %-- Interpolation bilinéaire en utilisant un masque de convolution!


% Msq1=[0 1 0;1 1 1;0 1 0];
% Msq2=[1 0 1;0 1 0;1 0 1];
% Msq3=[1 1 1;1 0 1;1 1 1];
% Les masques!!
Msq1=[1 0 1;0 0 0;1 0 1];
Msq2=[0 1 0;1 0 1;0 1 0];
Msq3=[0 0 0;0 1 0;0 0 0];

% Output_RGB(:,:,1) = Image_CFA;
% Output_RGB(:,:,2) = Image_CFA;
% Output_RGB(:,:,3) = Image_CFA;
Output_RGB(:,:,1)=imfilter(Image_CFA,Msq1,'conv');
Output_RGB(:,:,2)=imfilter(Image_CFA,Msq2,'conv');
Output_RGB(:,:,3)=imfilter(Image_CFA,Msq3,'conv');
end
Output_RGB=uint8(Output_RGB);
subplot(1,3,3)
imshow(Output_RGB)
% ImageFiltre = zeros(16,16,3);
% ImageCFA = zeros(16,16);
% Taille = size(Image);
% 
% %%%%%%%%% MATRICAGE CFA %%%%%%%%%%%%
% for C=2:1:(Taille(2))
%    for L=2:1:(Taille(1))
%        detectC=mod(C,2);
%        detectL=mod(L,2);
%        
%        if(detectC==0 && detectL==1)    
%             ImageCFA(L,C)=Image(L,C,1);
%        end
% 
%        
%        if(detectC==1 && detectL==0 )  
%              ImageCFA(L,C)=Image(L,C,3);
%        end
%        
%          if(detectC==1 && detectL==1 )  
%             ImageCFA(L,C)=Image(L,C,2); 
%          end
%          
%          if(detectC==0 && detectL==0 )  
%         ImageCFA(L,C)=Image(L,C,2); 
%          end
%    end
% end
% 
% 
% %%%%%%%%%DEMATRICAGE CFA%%%%%%%%%%%%
% 
% for C=2:1:(Taille(2)-1)
%    for L=2:1:(Taille(1)-1)
%        detectC=mod(C,2);
%        detectL=mod(L,2);
%        
%        if(detectC==0 && detectL==1)  
% B1=ImageCFA(L+1,C-1)+ImageCFA(L+1,C+1)+ImageCFA(L-1,C-1)+ImageCFA(L-1,C+1);
% Bc=(1/4)*B1;
% V1=ImageCFA(L+1,C)+ImageCFA(L-1,C)+ImageCFA(L,C+1)+ImageCFA(L,C-1);
% Vc=(1/4)*V1;
% ImageFiltre(L,C,1)=ImageCFA(L,C);
% ImageFiltre(L,C,2)=Vc;
% ImageFiltre(L,C,3)=Bc;
%        end
%        if(detectC==1 && detectL==0 )  
%  R1=ImageCFA(L+1,C-1)+ImageCFA(L+1,C+1)+ImageCFA(L-1,C-1)+ImageCFA(L-1,C+1);
%  Rc=(1/4)*R1;
%  V1=ImageCFA(L+1,C)+ImageCFA(L-1,C)+ImageCFA(L,C+1)+ImageCFA(L,C-1);
%  Vc=(1/4)*V1;
%  ImageFiltre(L,C,3)=ImageCFA(L,C);
%  ImageFiltre(L,C,2)=Vc;
%  ImageFiltre(L,C,1)=Rc;
%        end
%          if(detectC==1 && detectL==1 )  
%  R1=ImageCFA(L,C-1)+ImageCFA(L,C+1);
%  Rc=(1/2)*R1;
%  B1=ImageCFA(L+1,C)+ImageCFA(L-1,C);
%  Bc=(1/4)*B1;
%  ImageFiltre(L,C,3)=Bc;
%  ImageFiltre(L,C,2)=ImageCFA(L,C);
%  ImageFiltre(L,C,1)=Rc;
%          end
%          if(detectC==0 && detectL==0 )  
%  B1=ImageCFA(L,C-1)+ImageCFA(L,C+1);
%  Bc=(1/2)*B1;
%  R1=ImageCFA(L+1,C)+ImageCFA(L-1,C);
%  Rc=(1/4)*B1;
%  ImageFiltre(L,C,3)=Bc;
%  ImageFiltre(L,C,2)=ImageCFA(L,C);
%  ImageFiltre(L,C,1)=Rc;
%          end
%    end
% end
% 
% %%%%%%%%%% Affichage %%%%%%
% imshow(uint8(ImageFiltre));
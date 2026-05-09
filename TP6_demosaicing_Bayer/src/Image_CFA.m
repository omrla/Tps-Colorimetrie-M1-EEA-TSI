function Image_CFA(Input_RGB)
% 
% 
% ImageCFA = zeros(16,16);
% Taille = size(Image);
% 
% 
% 
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

   %Input_RGB = imread('image/Demosaic5.tif');

    % Récupere notre image - RGB
    taille = size(Input_RGB);
    
    for i=1:2:taille(1)-1    
        for j=1:2:taille(2)-1
            
            CFA(i,j) = Input_RGB(i,j,1);
            CFA(i,j+1) = Input_RGB(i,j+1,2);
            CFA(i+1,j) = Input_RGB(i+1,j,2);
            CFA(i+1,j+1) = Input_RGB(i+1,j+1,3);
            
       end
    end
subplot(1,3,2)
imshow(CFA)

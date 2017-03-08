obj =VideoReader('abc.mp4') ; % video that you want to encrypt


%OPENING FILE FOR WRITING ENCRYPTED FRAMES%%
writerobj = VideoWriter('encrypted.avi');
writerobj2 = VideoWriter('decrypted.avi');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SETTEING FRAMERATE%%%
writerobj.FrameRate=1;
writerobj2.FrameRate=1;
%%%%%%%%%%%%%%%%%%%%%%

%OPENING VIDEO FILE OBJECT
open(writerobj);
open(writerobj2);
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Video Encryption Working %%%%%%%
for framess=10:15
s=read(obj,framess); 

I =s;
I=imresize(I,[128,128]);
%figure; 
%imshow(I);  
%title('original image'); 
%drawnow; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image encryption using LorentzSol%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n =size(I,1)*size(I,2); 
level =0; 
s=10; 
r=28; 
b=8/3; 
x0=1.1840; 
y0=1.3627; 
z0=1.2519; 
h=0.001;
[x,y,z]=lorentz(n,level,s,r,b,x0,y0,z0,h); 
drawnow; 
 
% 对实数混沌序列进行预处理 
X=10*x-round(10*x); 
Y=10*y-round(10*y); 
Z=10*z-round(10*z); 
drawnow; 
 
% 产生索引序列lx,ly,lz 
[~,lx]=sort(X); 
[~,ly]=sort(Y); 
[~,lz]=sort(Z); 
drawnow; 
 
% 对图像进行加密 
A=I(:,:,1); 
B=I(:,:,2); 
C=I(:,:,3); 
A1=reshape(A,1,[]); 
B1=reshape(B,1,[]); 
C1=reshape(C,1,[]); 
A2(1:n)=A1(lx); 
B2(1:n)=B1(ly); 
C2(1:n)=C1(lz); 
A3=reshape(A2,size(I,1),size(I,2)); 
B3=reshape(B2,size(I,1),size(I,2)); 
C3=reshape(C2,size(I,1),size(I,2)); 
 
I(:,:,1)=A3; 
I(:,:,2)=B3; 
I(:,:,3)=C3; 


%WRITING ENCRYPTED FRAMES ON FILE
writeVideo(writerobj,I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Video Encryption End %%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Video Frames Decryption %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I1=I;
A4=I1(:,:,1); 
B4=I1(:,:,2); 
C4=I1(:,:,3); 
A5=reshape(A4,1,[]); 
B5=reshape(B4,1,[]); 
C5=reshape(C4,1,[]); 
A6(lx)=A5(1:n); 
B6(ly)=B5(1:n); 
C6(lz)=C5(1:n); 
A7=reshape(A6,size(I1,1),size(I1,2)); 
B7=reshape(B6,size(I1,1),size(I1,2)); 
C7=reshape(C6,size(I1,1),size(I1,2)); 
I1(:,:,1)=A7; 
I1(:,:,2)=B7; 
I1(:,:,3)=C7; 


%WRITING ENCRYPTED FRAMES ON FILE
writeVideo(writerobj2,I1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Video Frames Decryption %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%CLOSING VIDEO FILE OBJECT
close(writerobj);
close(writerobj2);

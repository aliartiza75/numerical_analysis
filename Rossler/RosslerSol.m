function RosslerSol(I) 
I = imread('Lenna.png'); 
I=imresize(I,[128,128]);
figure; 
imshow(I);  
title('original image'); 
drawnow; 
 
% 产生实数混沌序列x,y,z 
n =size(I,1)*size(I,2); 
level =0; 
a=0.2; 
b=0.2; 
c=5.7; 
x0=1.1840; 
y0=1.3627; 
z0=1.2519; 
h=0.001;
[x,y,z]=rossler(n,level,a,b,c,x0,y0,z0,h); 
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
drawnow; 
 
% 显示加密后的图像 
I(:,:,1)=A3; 
I(:,:,2)=B3; 
I(:,:,3)=C3; 
figure; 
imshow(I);  
title('encrypted image'); 
imwrite(I,'encrypted.png'); 
%VedioWrite
drawnow; 
 
% 对图像进行解密 
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
drawnow; 
 
% 显示解密后的图像 
figure; 
imshow(I1);  
title('decrypted image'); 
imwrite(I1,'decrypted.png'); 

%VedioWrite
drawnow; 
 
% 错误密码解密后的图像x1=1.1840000001，y1=1.3627000001，z1=1.2519000001 
I2=I;
imread('encrypted.png'); 
n =size(I,1)*size(I,2); 
level =0; 
a=0.2; 
b=0.2; 
c=5.7; 
x0=1.1840; 
y0=1.3627; 
z0=1.2519; 
h=0.001;
[x2,y2,z2]=rossler(n,level,a,b,c,x0,y0,z0,h);
 
 
X2=10*x2-round(10*x2); 
Y2=10*y2-round(10*y2); 
Z2=10*z2-round(10*z2); 
 
[~,lx1]=sort(X2); 
[~,ly1]=sort(Y2); 
[~,lz1]=sort(Z2); 
 
A8=I2(:,:,1); 
B8=I2(:,:,2); 
C8=I2(:,:,3); 
 
A9=reshape(A8,1,[]); 
B9=reshape(B8,1,[]); 
C9=reshape(C8,1,[]); 
 
A10(lx1)=A9(1:n); 
B10(ly1)=B9(1:n); 
C10(lz1)=C9(1:n); 
 
A11=reshape(A10,size(I2,1),size(I2,2)); 
B11=reshape(B10,size(I2,1),size(I2,2)); 
C11=reshape(C10,size(I2,1),size(I2,2)); 
 
I2(:,:,1)=A11; 
I2(:,:,2)=B11; 
I2(:,:,3)=C11; 
 
figure; 
imshow(I2);  
title('error decrypted image'); 
imwrite(I2,'Decrypted.png'); 
drawnow; 
 

end


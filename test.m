clear all
clc;
I =imread('DRimgs/knee.tif');  %读入图像
figure(1),subplot(2,2,1),imshow(I,[0 4096]);
title('原图')

I=im2double(I);    %转换数据类型为double型
[M,N]=size(I);

P = 2*M; Q = 2*N; 
I2 = zeros(P,Q);

for i = 1:M
    for j =1:N
        I2(i,j) = I(i,j);  %对图像进行填充
    end
end

figure(1),subplot(2,2,2),imshow(I2,[]);
title('填充后的图像')

I2=log(I2+1);   %取对数
FI=fft2(I2);    %傅里叶变换 

rL=0.25;    
rH=2.2;      % 可根据需要效果调整参数 
c=2.0;       % 锐化参数
D0=20;

n1=floor(P/2); 
n2=floor(Q/2);
for u=1:P 
    for v=1:Q 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %频率域中点（u，v）与频率矩形中心的距离       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %高斯同态滤波 
    end
end

H=ifftshift(H);   %对H做反中心化
I3=ifft2(H.*FI);  %傅里叶逆变换
I4=real(I3); 
I5 =I4(1:M, 1:N);  %截取一部分
I6=exp(I5)-1;      %取指数
figure(1),subplot(223),imshow(I6,[]);
title('同态滤波增强');

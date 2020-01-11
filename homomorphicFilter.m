function [resultImg] = homomorphicFilter(originImg,rL,rH,c,D0)
% homomorphicFilter 同态滤波器
% originImg：原始医学图像
% resultImg: 结果医学图像
% 以下参数可选，要么全设置，要么
% rL: 低频分量
% rH: 高频分量
% c:c为一个常数，控制滤波器的形态，即从低频到高频过渡段的陡度（斜率），其值越大，斜坡带越陡峭

%转换数据类型为double型
I=im2double(originImg);    
[M,N]=size(I);

%对图像进行填充
P = 2*M; Q = 2*N; 
I2 = zeros(P,Q);
for i = 1:M
    for j =1:N
        I2(i,j) = I(i,j); 
    end
end
%取对数
I2=log(I2+1);  
%傅里叶变换
FI=fft2(I2);  
% 当函数没有设置参数时
if nargin < 5,D0 = 20;end
% 锐化参数
if nargin < 4,c =  2.0;end
% 可根据需要效果调整参数 
if nargin < 3,rH = 2.2;end
if nargin < 2,rL = 0.25;end

n1=floor(P/2); 
n2=floor(Q/2);
for u=1:P 
    for v=1:Q 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %频率域中点（u，v）与频率矩形中心的距离       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %高斯同态滤波 
    end
end
H=ifftshift(H);    %对H做反中心化
I3=ifft2(H.*FI);   %傅里叶逆变换
I4=real(I3); 
I5 =I4(1:M, 1:N);  %截取一部分
I6=exp(I5)-1;      %取指数

%结果图像
resultImg=I6;
end


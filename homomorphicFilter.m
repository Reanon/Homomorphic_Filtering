function [resultImg] = homomorphicFilter(originImg,rL,rH,c,D0)
% homomorphicFilter 同态滤波器
% originImg：原始医学图像
% resultImg: 结果医学图像

% 以下参数可选，要么全设置，要么设置为默认
% rL: 低频分量
% rH: 高频分量
% c:  c为一个常数，控制滤波器的形态，即从低频到高频过渡段的陡度（斜率），其值越大，斜坡带越陡峭
% D0: 截止频率
% 当函数没有设置参数时
if nargin < 5,D0 = 20;end
% 锐化参数
if nargin < 4,c =  2.0;end
% 可根据需要效果调整参数 
if nargin < 3,rH = 2.2;end
if nargin < 2,rL = 0.25;end

%转换数据类型为double型
I=im2double(originImg);    
% I=double(originImg);  
[Hight,Width]=size(I);

%对图像进行填充
extendedHight = 2*Hight; extendedWidth = 2*Width; 
interimImg = zeros(extendedHight,extendedWidth);

for i = 1:Hight
    for j =1:Width
        interimImg(i,j) = I(i,j); 
    end
end

%取对数
interimImg=log(interimImg+1);
 
%傅里叶变换
FI=fft2(interimImg);  

n1=floor(extendedHight/2); 
n2=floor(extendedWidth/2);

for u=1:extendedHight 
    for v=1:extendedWidth 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %频率域中点（u，v）与频率矩形中心的距离       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %高斯同态滤波 
    end
end

%对H做反中心化
H=ifftshift(H);    
%傅里叶逆变换
interimImg=ifft2(H.*FI);

%截取一部分
interimImg=real(interimImg); 
interimImg =interimImg(1:Hight, 1:Width);  

%取指数
interimImg=exp(interimImg)-1;      

%结果图像
resultImg=interimImg;
end


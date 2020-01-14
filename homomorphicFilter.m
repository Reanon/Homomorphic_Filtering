function [resultImg] = homomorphicFilter(originImg,rL,rH,c,D0)
% homomorphicFilter ̬ͬ�˲���
% originImg��ԭʼҽѧͼ��
% resultImg: ���ҽѧͼ��

% ���²�����ѡ��Ҫôȫ���ã�Ҫô����ΪĬ��
% rL: ��Ƶ����
% rH: ��Ƶ����
% c:  cΪһ�������������˲�������̬�����ӵ�Ƶ����Ƶ���ɶεĶ��ȣ�б�ʣ�����ֵԽ��б�´�Խ����
% D0: ��ֹƵ��
% ������û�����ò���ʱ
if nargin < 5,D0 = 20;end
% �񻯲���
if nargin < 4,c =  2.0;end
% �ɸ�����ҪЧ���������� 
if nargin < 3,rH = 2.2;end
if nargin < 2,rL = 0.25;end

%ת����������Ϊdouble��
I=im2double(originImg);    
% I=double(originImg);  
[Hight,Width]=size(I);

%��ͼ��������
extendedHight = 2*Hight; extendedWidth = 2*Width; 
interimImg = zeros(extendedHight,extendedWidth);

for i = 1:Hight
    for j =1:Width
        interimImg(i,j) = I(i,j); 
    end
end

%ȡ����
interimImg=log(interimImg+1);
 
%����Ҷ�任
FI=fft2(interimImg);  

n1=floor(extendedHight/2); 
n2=floor(extendedWidth/2);

for u=1:extendedHight 
    for v=1:extendedWidth 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %Ƶ�����е㣨u��v����Ƶ�ʾ������ĵľ���       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %��˹̬ͬ�˲� 
    end
end

%��H�������Ļ�
H=ifftshift(H);    
%����Ҷ��任
interimImg=ifft2(H.*FI);

%��ȡһ����
interimImg=real(interimImg); 
interimImg =interimImg(1:Hight, 1:Width);  

%ȡָ��
interimImg=exp(interimImg)-1;      

%���ͼ��
resultImg=interimImg;
end


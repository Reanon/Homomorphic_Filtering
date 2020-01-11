function [resultImg] = homomorphicFilter(originImg,rL,rH,c,D0)
% homomorphicFilter ̬ͬ�˲���
% originImg��ԭʼҽѧͼ��
% resultImg: ���ҽѧͼ��
% ���²�����ѡ��Ҫôȫ���ã�Ҫô
% rL: ��Ƶ����
% rH: ��Ƶ����
% c:cΪһ�������������˲�������̬�����ӵ�Ƶ����Ƶ���ɶεĶ��ȣ�б�ʣ�����ֵԽ��б�´�Խ����

%ת����������Ϊdouble��
I=im2double(originImg);    
[M,N]=size(I);

%��ͼ��������
P = 2*M; Q = 2*N; 
I2 = zeros(P,Q);
for i = 1:M
    for j =1:N
        I2(i,j) = I(i,j); 
    end
end
%ȡ����
I2=log(I2+1);  
%����Ҷ�任
FI=fft2(I2);  
% ������û�����ò���ʱ
if nargin < 5,D0 = 20;end
% �񻯲���
if nargin < 4,c =  2.0;end
% �ɸ�����ҪЧ���������� 
if nargin < 3,rH = 2.2;end
if nargin < 2,rL = 0.25;end

n1=floor(P/2); 
n2=floor(Q/2);
for u=1:P 
    for v=1:Q 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %Ƶ�����е㣨u��v����Ƶ�ʾ������ĵľ���       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %��˹̬ͬ�˲� 
    end
end
H=ifftshift(H);    %��H�������Ļ�
I3=ifft2(H.*FI);   %����Ҷ��任
I4=real(I3); 
I5 =I4(1:M, 1:N);  %��ȡһ����
I6=exp(I5)-1;      %ȡָ��

%���ͼ��
resultImg=I6;
end


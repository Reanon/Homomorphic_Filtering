clear all
clc;
I =imread('DRimgs/knee.tif');  %����ͼ��
figure(1),subplot(2,2,1),imshow(I,[0 4096]);
title('ԭͼ')

I=im2double(I);    %ת����������Ϊdouble��
[M,N]=size(I);

P = 2*M; Q = 2*N; 
I2 = zeros(P,Q);

for i = 1:M
    for j =1:N
        I2(i,j) = I(i,j);  %��ͼ��������
    end
end

figure(1),subplot(2,2,2),imshow(I2,[]);
title('�����ͼ��')

I2=log(I2+1);   %ȡ����
FI=fft2(I2);    %����Ҷ�任 

rL=0.25;    
rH=2.2;      % �ɸ�����ҪЧ���������� 
c=2.0;       % �񻯲���
D0=20;

n1=floor(P/2); 
n2=floor(Q/2);
for u=1:P 
    for v=1:Q 
        D(u,v)=sqrt(((u-n1).^2+(v-n2).^2));  %Ƶ�����е㣨u��v����Ƶ�ʾ������ĵľ���       
        H(u,v)=(rH-rL).*(1-exp(-c.*(D(u,v)^2./D0^2)))+rL; %��˹̬ͬ�˲� 
    end
end

H=ifftshift(H);   %��H�������Ļ�
I3=ifft2(H.*FI);  %����Ҷ��任
I4=real(I3); 
I5 =I4(1:M, 1:N);  %��ȡһ����
I6=exp(I5)-1;      %ȡָ��
figure(1),subplot(223),imshow(I6,[]);
title('̬ͬ�˲���ǿ');

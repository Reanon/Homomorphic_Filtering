clear all
clc;

% ԭʼͼ���·��
originImgPath = 'DRimgs/';
% �ο����ͼ��·��
referenceImgPath = 'RefImgs/';
% ��������jpg��ʽ�ļ�
imgDir  = dir([originImgPath '*.tif']);
% �����ṹ��Ϳ���һһ����ͼƬ��
for i = 1:(length(imgDir)-4) 
    % ��ȡÿ��ͼƬ�ļ���
    name = imgDir(i).name((1:end-4)); 
    originImg = imread([originImgPath name '.tif']);           %��ȡԭʼͼƬ
    referenceImg = imread([referenceImgPath name '_out.tif']); %��ȡ�ο����ͼƬ
    
    %��ʾԭʼͼ��
    figure('name',name),subplot(2,2,1),imshow(originImg,[0 4096]);title('ԭʼͼƬ');
    %��ʾ�ο�ͼ��
    subplot(2,2,2),imshow(referenceImg,[]);title('�ο����ͼ��');
    
    % ʹ��̬ͬ�˲���ǿ
    resultImg=homomorphicFilter(originImg);
    
    %��ʾ���ͼ��
    subplot(223),imshow(resultImg,[]);title('̬ͬ�˲���ǿ');
    
end

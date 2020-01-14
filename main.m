clear all;
clc;
% ԭʼͼ���·��
originImgPath = 'DRimgs/';
% �ο����ͼ��·��
referenceImgPath = 'RefImgs/';
% ��������jpg��ʽ�ļ�
imgDir  = dir([originImgPath '*.tif']);
% �����ṹ��Ϳ���һһ����ͼƬ��

% ѡȡ��������Ҫ�鿴��ͼƬ��
number=7;    
% number=length(imgDir); % �鿴ȫ��ͼ��

for i = 1:number
    % ��ȡÿ��ͼƬ�ļ���
    name = imgDir(i).name((1:end-4)); 
    originImg = imread([originImgPath name '.tif']);           %��ȡԭʼͼƬ
    referenceImg = imread([referenceImgPath name '_out.tif']); %��ȡ�ο����ͼƬ
    
    %��ʾԭʼͼ��
    figure('name',name),subplot(1,3,1),imshow(originImg,[0 4096]);title('ԭʼͼƬ');
    %��ʾ�ο�ͼ��
    subplot(1,3,2),imshow(referenceImg,[0 4096]);title('�ο����ͼ��');
    
%     ����һ��ʹ��̬ͬ�˲���ǿ:homomorphicFilter(originImg,rL,rH,c,D0),��ѹ��ͼ��
%     resultImg=homomorphicFilter(originImg,0.25,2.2,2.0,30); 
    
    %��������ֱ��ͼ���⻯�����ǲ���ѹ��ԭʼͼ��
    resultImg  = HistogramEqualization(originImg);
    
    %����ʵ����ͼ
    resultPath = 'ResImgs/';
    resultImgName=[name,'_result_4096.tif'];
    saveImg(resultImg,resultPath,resultImgName);

    %��ʾ���ͼ��
    subplot(1,3,3),imshow(resultImg,[]);title('̬ͬ�˲���ǿ');
end

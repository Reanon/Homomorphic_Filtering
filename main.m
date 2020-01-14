clear all;
clc;
% 原始图像库路径
originImgPath = 'DRimgs/';
% 参考结果图像路径
referenceImgPath = 'RefImgs/';
% 遍历所有jpg格式文件
imgDir  = dir([originImgPath '*.tif']);
% 遍历结构体就可以一一处理图片了

% 选取本次运行要查看的图片数
number=7;    
% number=length(imgDir); % 查看全部图像

for i = 1:number
    % 提取每张图片文件名
    name = imgDir(i).name((1:end-4)); 
    originImg = imread([originImgPath name '.tif']);           %读取原始图片
    referenceImg = imread([referenceImgPath name '_out.tif']); %读取参考结果图片
    
    %显示原始图像
    figure('name',name),subplot(1,3,1),imshow(originImg,[0 4096]);title('原始图片');
    %显示参考图像
    subplot(1,3,2),imshow(referenceImg,[0 4096]);title('参考结果图像');
    
%     方法一：使用同态滤波增强:homomorphicFilter(originImg,rL,rH,c,D0),会压缩图像
%     resultImg=homomorphicFilter(originImg,0.25,2.2,2.0,30); 
    
    %方法二：直方图均衡化，就是不会压缩原始图像
    resultImg  = HistogramEqualization(originImg);
    
    %保存实验结果图
    resultPath = 'ResImgs/';
    resultImgName=[name,'_result_4096.tif'];
    saveImg(resultImg,resultPath,resultImgName);

    %显示结果图像
    subplot(1,3,3),imshow(resultImg,[]);title('同态滤波增强');
end

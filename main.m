clear all
clc;

% 原始图像库路径
originImgPath = 'DRimgs/';
% 参考结果图像路径
referenceImgPath = 'RefImgs/';
% 遍历所有jpg格式文件
imgDir  = dir([originImgPath '*.tif']);
% 遍历结构体就可以一一处理图片了
for i = 1:(length(imgDir)-4) 
    % 提取每张图片文件名
    name = imgDir(i).name((1:end-4)); 
    originImg = imread([originImgPath name '.tif']);           %读取原始图片
    referenceImg = imread([referenceImgPath name '_out.tif']); %读取参考结果图片
    
    %显示原始图像
    figure('name',name),subplot(2,2,1),imshow(originImg,[0 4096]);title('原始图片');
    %显示参考图像
    subplot(2,2,2),imshow(referenceImg,[]);title('参考结果图像');
    
    % 使用同态滤波增强
    resultImg=homomorphicFilter(originImg);
    
    %显示结果图像
    subplot(223),imshow(resultImg,[]);title('同态滤波增强');
    
end

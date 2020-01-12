function  saveImg(Img,Path,name)
% saveImg 保存实验结果图的函数，需要控制好变量，其中name需要包含文件的后缀名，如'.tif'
% Img:  要保存的实验结果
% Path: 保存到的路径
% name: 文件名
imwrite(Img,[Path,name]); 
end


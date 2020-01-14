function  [resultImg]  = HistogramEqualization(originImg)
%HistogramEqualization 直方图均衡

[Hight, Width] = size(originImg);

%图像的值范围
range=max(max(originImg))+1;

% 统计每个像素值出现次数
count = zeros(1, range);

for i = 1 : Hight
    for j = 1 : Width
        count(1, originImg(i, j) + 1) = count(1, originImg(i, j) + 1) + 1;
    end
end


%一下编写T函数[2]
T = zeros(1, range);
T = double(T); count = double(count);
 
% 统计每个像素值出现的概率， 得到概率直方图
for i = 1 : range
    T(1, i) = count(1, i) / (Hight * Width);
end
 
% 求累计概率，得到累计直方图
for i = 2 : range
    T(1, i) = T(1, i - 1) + T(1, i);
end
 
% 完善T函数的定义
for i = 1 : range
    T(1, i) = T(1, i) * range;
end

% 完成每个像素点的映射
resultImg = double(originImg);
for i = 1 : Hight
    for j = 1 : Width
        resultImg(i, j) = T(1, resultImg(i, j) + 1);
    end
end
 
% 输出仍然要记得改数据类型
resultImg = uint16(resultImg);
end


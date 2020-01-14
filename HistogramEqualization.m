function  [resultImg]  = HistogramEqualization(originImg)
%HistogramEqualization ֱ��ͼ����

[Hight, Width] = size(originImg);

%ͼ���ֵ��Χ
range=max(max(originImg))+1;

% ͳ��ÿ������ֵ���ִ���
count = zeros(1, range);

for i = 1 : Hight
    for j = 1 : Width
        count(1, originImg(i, j) + 1) = count(1, originImg(i, j) + 1) + 1;
    end
end


%һ�±�дT����[2]
T = zeros(1, range);
T = double(T); count = double(count);
 
% ͳ��ÿ������ֵ���ֵĸ��ʣ� �õ�����ֱ��ͼ
for i = 1 : range
    T(1, i) = count(1, i) / (Hight * Width);
end
 
% ���ۼƸ��ʣ��õ��ۼ�ֱ��ͼ
for i = 2 : range
    T(1, i) = T(1, i - 1) + T(1, i);
end
 
% ����T�����Ķ���
for i = 1 : range
    T(1, i) = T(1, i) * range;
end

% ���ÿ�����ص��ӳ��
resultImg = double(originImg);
for i = 1 : Hight
    for j = 1 : Width
        resultImg(i, j) = T(1, resultImg(i, j) + 1);
    end
end
 
% �����ȻҪ�ǵø���������
resultImg = uint16(resultImg);
end


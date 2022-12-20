clear all;close all;clc;
brainimage=load('F:\Desktop\homework\exp2\brainimage.txt');
% normaliz
img = brainimage / 255;
figure;subplot(1,2,1);imshow(img);title('raw data');

%设置聚类数
cluster_num = 3;
% 方差设置为样本方差
mu=[0.3 0.5 0.7];
sigma = var(img,0,'all')*ones(1,cluster_num);
pw = zeros(cluster_num,size(img,1)*size(img,2));
pc = ones(1,cluster_num);
pc = pc/sum(pc);%类概率1/3
max_iter = 30;%以迭代次数来作为停止的条件
iter = 1;
label = zeros(1,size(img,1)*size(img,2));%每个点的类别标签
subplot(1,2,2);
while iter <= max_iter
    %----------E-------------------
    for i = 1:cluster_num
        MU = repmat(mu(i),size(img,1)*size(img,2),1);
        %高斯模型
        temp = 1/sqrt(2*pi*sigma(i))*exp(-(img(:)-MU).^2/2/sigma(i));
        temp(temp<0.000001) = 0.000001;%防止出现0
        pw(i,:) = pc(i) * temp;
    end
    pw = pw./(repmat(sum(pw),cluster_num,1));%归一
    %----------M---------------------
    %更新参数集
    for i = 1:cluster_num
         pc(i) = mean(pw(i,:));
         mu(i) = pw(i,:)*img(:)/sum(pw(i,:));
         sigma(i) = pw(i,:)*((img(:)-mu(i)).^2)/sum(pw(i,:));
    end
    %------------show-result---------------
    [~,label] = max(pw);%得到最大值的索引
    label = reshape(label,size(img));
    imshow(label,[])
    title(['iter = ',num2str(iter)]);
    pause(0.1);
    M(iter,:) = mu;
    S(iter,:) = sigma;

%     % 录制gif
%     F=getframe(gcf);
%     I=frame2im(F);
%     [I,map]=rgb2ind(I,256);
%     if iter == 1
%         imwrite(I,map,'./test_gray.gif','gif','Loopcount',inf,'DelayTime',0.2);
%     else
%         imwrite(I,map,'./test_gray.gif','gif','WriteMode','append','DelayTime',0.2);
%     end

    iter = iter + 1;
end

% 分别绘制三类点,白色的是目标点
figure;
label_1 = zeros(size(img));label_1(label==1) = 1;
label_2 = zeros(size(img));label_2(label==2) = 1;
label_3 = zeros(size(img));label_3(label==3) = 1;
subplot(1,3,1);imshow(label_1,[]);title('gray matter');
subplot(1,3,2);imshow(label_2,[]);title('white matter');
subplot(1,3,3);imshow(label_3,[]);title('outside brain');

%将均值与方差的迭代过程显示出来
figure;
for i = 1:cluster_num
    plot(M(:,i));
    hold on
end
title('均值变化过程');
figure;
for i = 1:cluster_num
    plot(S(:,i));
    hold on
end
title('方差变化过程');
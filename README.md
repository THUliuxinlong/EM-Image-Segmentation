## Image segmentation

#### 1.初值设置

``` python
%设置聚类数
cluster_num=3;
%方差设置为样本方差
mu=[0.30.50.7];
sigma=var(img,0,'all')*ones(1,cluster_num);
pw=zeros(cluster_num,size(img,1)*size(img,2));
%类概率1/3
pc=ones(1,cluster_num);
pc=pc/sum(pc);
max_iter=30;%以迭代次数来作为停止的条件
```

#### 2.分割结果

![image-20221220222728249](http://rmaux11hx.hn-bkt.clouddn.com/img/image-20221220222728249.png)

![image-20221220222740348](http://rmaux11hx.hn-bkt.clouddn.com/img/image-20221220222740348.png)

<img src="http://rmaux11hx.hn-bkt.clouddn.com/img/image-20221220222754611.png" alt="image-20221220222754611" style="zoom:80%;" />

<img src="http://rmaux11hx.hn-bkt.clouddn.com/img/image-20221220222802937.png" alt="image-20221220222802937" style="zoom:80%;" />

程序里面的参数初始化设置中，尤其是对均值Mu的设置很重要，设置的不好的话分割的效果就很常，也就是说参数估计的也很差，并且分割要求的类数越大（也就是需要估计的参数越多），对初始值的要求越高。  
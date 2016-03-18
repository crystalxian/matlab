function [ aver,var1,y,x ] = Analyse1(dataset)
%返回测试数据的平均反应时间，反应时间的方差，以及错误个数和判断颜色和字义不匹配时反应时间与平均时间的差
fourth_col=dataset(:,4);
record_un=0; count_un=0; count_error=0;
aver=mean(fourth_col);
var1=var(fourth_col,1);
for i=1:10
    if(dataset(i,1)~=dataset(i,2))
        record_un =record_un+dataset(i,4);
        count_un=count_un+1;
    end
    if(dataset(i,1)~=dataset(i,3))
        count_error=count_error+1;
    end
end
x=(record_un/count_un-aver)/aver;
y=count_error;
end



function [ aver,var1,y,x ] = Analyse1(dataset)
%���ز������ݵ�ƽ����Ӧʱ�䣬��Ӧʱ��ķ���Լ�����������ж���ɫ�����岻ƥ��ʱ��Ӧʱ����ƽ��ʱ��Ĳ�
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



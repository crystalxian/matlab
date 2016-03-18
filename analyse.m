ID= '2013011182';
data_file = [ID '.mat'];
if exist(data_file, 'file');
    load(data_file);
else
    data = {};
    data.ID = ID;
    data.results_count = 0;
end
data_analyze_en = data.(['result_' int2str(data.results_count)]).en;
data_analyze_cs = data.(['result_' int2str(data.results_count)]).cs;
data_analyze_zh = data.(['result_' int2str(data.results_count)]).zh;

[en_av,en_var,en_er,en_re]=Analyse1(data_analyze_en);
[cs_av,cs_var,cs_er,cs_re]=Analyse1(data_analyze_cs);
[zh_av,zh_var,zh_er,zh_re]=Analyse1(data_analyze_zh);

A(1,:)=[en_av,en_var,en_er,en_re];
A(2,:)=[cs_av,cs_var,cs_er,cs_re];
A(3,:)=[zh_av,zh_var,zh_er,zh_re];
[ma,I]=max(A(:,1));
             
% run.m
% ���ݲɼ�������

% ѧ����Ϣ
ID = '2013011182';

% ȷ��ѧ��Ϊ�ַ���
if ~isstr(ID)
    ID = int2str(ID);
end

% ��ȡ����
data_file = [ID '.mat'];
if exist(data_file, 'file');
    load(data_file);
else
    data = {};
    data.ID = ID;
    data.results_count = 0;
end


% ÿ�����зֱ�����������֣�ÿ�����ֲ��Դ����� Stroop��������
result_en = stroop(10, 'en');
result_cs = stroop(10, 'cs');
result_zh = stroop(10, 'zh');


% ������Խ��
data.results_count = data.results_count + 1;
data = setfield(data, ['result_' int2str(data.results_count)], ...
                struct('en', result_en, 'zh', result_zh, 'cs', result_cs));

% ��������
save(data_file, 'data');

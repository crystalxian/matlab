% run.m
% 数据采集主程序

% 学号信息
ID = '2013011182';

% 确认学号为字符串
if ~isstr(ID)
    ID = int2str(ID);
end

% 读取数据
data_file = [ID '.mat'];
if exist(data_file, 'file');
    load(data_file);
else
    data = {};
    data.ID = ID;
    data.results_count = 0;
end


% 每次运行分别测试三个语种，每个语种测试次数见 Stroop函数参数
result_en = stroop(10, 'en');
result_cs = stroop(10, 'cs');
result_zh = stroop(10, 'zh');


% 保存测试结果
data.results_count = data.results_count + 1;
data = setfield(data, ['result_' int2str(data.results_count)], ...
                struct('en', result_en, 'zh', result_zh, 'cs', result_cs));

% 保存数据
save(data_file, 'data');

function [trials, nright] = stroop(num, lang)
% STROOP The Stroop test
% Created based on https://github.com/liborw/stroop
%
% SYNOPSIS
%   [trials, nright] = stroop(num, lang);
%
% INPUT
%   num     Number of trials
%   lang    Language for experiment: ['en' 'cs' 'zh']

% Check params
if nargin < 2
    error('params wrong');
end;

instruction = {['You will be shown words, one at a time, printed in different colors.',...
                ' Press r for word printed in red, g for green, b for blue and m for',...
                ' magenta. Try to make your choice as fast as possible.'], ['[press space',...
                ' to start]']};

config = {};
config.colors = {'red', 'green', 'blue', 'magenta'};
config.keys = 'rgbm';
config.words.en = {'red', 'green', 'blue', 'magenta'};
config.words.cs = {'¨¨erven¨¢', 'zelen¨¢', 'modr¨¢', 'fialov¨¢'};
config.words.zh = {'ºì', 'ÂÌ', 'À¶', 'Ñóºì'};
config.right = 'right';
config.wrong = 'wrong';

% Load language
config.words = getfield(config.words, lang);

% Create Interface
screen_size =  get(0,'ScreenSize');
h = figure();
set(h, 'NumberTitle', 'off', ...
       'Name', 'Stroop Test', ...
       'Color', 'black', ...
       'MenuBar','none', ...
       'ToolBar', 'none', ...
       'Position',[screen_size(3)/4, screen_size(4)/4, screen_size(3)/2, screen_size(4)/2]);

% Display instruction
ht = show_text(h, instruction, 'Position', [5, 5, screen_size(3)/2-10, screen_size(4)/2-10]);
waitforspace(h);
delete(ht);

% Session variables
ntrials = 0; % Number of trials already preformed
nmixed  = 0; % Number of mixed trials
nwrong = 0; % Number of incorrect replies
nright = 0; % Number of correct replies
trials  = zeros(num, 4);

% Start test
while ntrials < num

    % Chose between normal or mixed
    mixed = rand() > (nmixed/(ntrials - nmixed))/2;

    % Create trial
    perm = randperm(4);
    iStimul = perm(1);
    iNoise = iif(mixed, perm(2), perm(1));

    % Pause for 1 + (0-2) s and display
    pause(0.5 + rand*2);
    ht = show_text(h, config.words(iNoise),...
                'FontSize', 40,...
                'ForegroundColor', config.colors{iStimul});
    tic;

    % Wait for user input
    waitforbuttonpress;
    rtime = toc;
    ch = get(h, 'CurrentCharacter');
    delete(ht);

    ntrials = ntrials + 1;
    if ch == config.keys(iStimul)
        if mixed, nmixed = nmixed + 1; end;
        nright = nright + 1;
        ht = show_text(h, config.right, 'ForegroundColor', 'green');
    else
        % Check for unknown characters
        nwrong = nwrong + 1;
        ht = show_text(h, config.wrong, 'ForegroundColor', 'red');
    end

    % Store result
    trials(ntrials, 1) = iStimul;
    trials(ntrials, 2) = iNoise;
    if length(find(config.keys == ch)) > 0
        trials(ntrials, 3) = find(config.keys == ch);
    else
        trials(ntrials, 3) = 0;
    end
    trials(ntrials, 4) = rtime;

    % Show result for 0.5 s and continue
    pause(0.5)
    delete(ht);
end

close(h);

% Some stats
fprintf('\n');
fprintf('# all trials:         %d\n', num);
fprintf('# correct trials:     %d\n', nright);
fprintf('# accuracy :          %0.3f\n', nright / num);
fprintf('# mixed trials:       %d\n', nmixed);
end

function waitforspace(h)
waitforbuttonpress;
key = get(h, 'CurrentKey');
while ~strcmp(key, 'space')
    waitforbuttonpress;
    key = get(h, 'CurrentKey');
end

end

function handle = show_text(parent, string, varargin)
parpos = get(parent, 'Position');
pos = [5 round(parpos(4)/2)-30 parpos(3)-10 60];
handle = uicontrol(parent,...
    'Style','Text',...
    'BackgroundColor', 'black',...
    'ForegroundColor', 'white',...
    'Position', pos,...
    'String', string,...
    'FontSize', 30,...
    'FontUnits', 'pixels');

if length(varargin) > 0
    set(handle, varargin{:});
end

drawnow;

end

function ret = iif(test, valif, valelse)
if test
    ret = valif;
else
    ret = valelse;
end

end

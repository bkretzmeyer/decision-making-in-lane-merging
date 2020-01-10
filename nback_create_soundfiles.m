%% create nback_soundfiles

% create nback soundfiles using the sounds of the single stimuli and the
% created nback arrays

%% header
clear all;
close all;
clc;

slCharacterEncoding('UTF-8');

cd('C:\Users\zuse\OneDrive\Masterarbeit\Code\')
PATHIN_SOUND = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\';
PATHIN_ARRAY = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_sequences\final_';
PATHIN_INSTRUCTIONS = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\instructions\';
PATHOUT = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_soundfiles\';


% cd('C:\Users\bened\OneDrive\Masterarbeit\Code\')
% PATHIN_SOUND = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\';
% PATHIN_ARRAY = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_sequences\';
% PATHIN_INSTRUCTIONS = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\instructions\';
% PATHOUT = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_soundfiles\';

%% load soundfiles (single numbers)

for ind = 1:10
    [numbers.(['nr_',num2str(ind-1)]), Fs] = audioread([PATHIN_SOUND,num2str(ind-1),'.wav']);
end

%% load soundfiles (instructions)

for ind = 1:9
    [instructions.(['nr_',num2str(ind)]), Fs] = audioread([PATHIN_INSTRUCTIONS,'instruction',num2str(ind),'.wav']);
end

%% load nback arrays

load([PATHIN_ARRAY,'array_nback0.mat']);

load([PATHIN_ARRAY,'array_nback0_vid_1_1.mat']);
load([PATHIN_ARRAY,'array_nback0_vid_1_2.mat']);
load([PATHIN_ARRAY,'array_nback0_vid_2_1.mat']);
load([PATHIN_ARRAY,'array_nback0_vid_2_2.mat']);
load([PATHIN_ARRAY,'array_nback0_vid_3_1.mat']);
load([PATHIN_ARRAY,'array_nback0_vid_3_2.mat']);
load([PATHIN_ARRAY,'array_nback0_training.mat']);

load([PATHIN_ARRAY,'array_nback1.mat']);

load([PATHIN_ARRAY,'array_nback1_vid_1_1.mat']);
load([PATHIN_ARRAY,'array_nback1_vid_1_2.mat']);
load([PATHIN_ARRAY,'array_nback1_vid_2_1.mat']);
load([PATHIN_ARRAY,'array_nback1_vid_2_2.mat']);
load([PATHIN_ARRAY,'array_nback1_vid_3_1.mat']);
load([PATHIN_ARRAY,'array_nback1_vid_3_2.mat']);
load([PATHIN_ARRAY,'array_nback1_training.mat']);


load([PATHIN_ARRAY,'array_nback2.mat']);

load([PATHIN_ARRAY,'array_nback2_vid_1_1.mat']);
load([PATHIN_ARRAY,'array_nback2_vid_1_2.mat']);
load([PATHIN_ARRAY,'array_nback2_vid_2_1.mat']);
load([PATHIN_ARRAY,'array_nback2_vid_2_2.mat']);
load([PATHIN_ARRAY,'array_nback2_vid_3_1.mat']);
load([PATHIN_ARRAY,'array_nback2_vid_3_2.mat']);
load([PATHIN_ARRAY,'array_nback2_training.mat']);

%% Put arrays and single sequences for videos into on cell array:

nback0cell = {};
for ind = 1:size(nback0,1)
    nback0cell{ind,1} = nback0(ind,:);
end

nback0cell{7,1} = nback0_vid_1_1;
nback0cell{8,1} = nback0_vid_1_2;
nback0cell{9,1} = nback0_vid_2_1;
nback0cell{10,1} = nback0_vid_2_2;
nback0cell{11,1} = nback0_vid_3_1;
nback0cell{12,1} = nback0_vid_3_2;
nback0cell{13,1} = nback0_training;

nback1cell = {};
for ind = 1:size(nback1,1)
    nback1cell{ind,1} = nback1(ind,:);
end

nback1cell{7,1} = nback1_vid_1_1;
nback1cell{8,1} = nback1_vid_1_2;
nback1cell{9,1} = nback1_vid_2_1;
nback1cell{10,1} = nback1_vid_2_2;
nback1cell{11,1} = nback1_vid_3_1;
nback1cell{12,1} = nback1_vid_3_2;
nback1cell{13,1} = nback1_training;

nback2cell = {};
for ind = 1:size(nback2,1)
    nback2cell{ind,1} = nback2(ind,:);
end

nback2cell{7,1} = nback2_vid_1_1;
nback2cell{8,1} = nback2_vid_1_2;
nback2cell{9,1} = nback2_vid_2_1;
nback2cell{10,1} = nback2_vid_2_2;
nback2cell{11,1} = nback2_vid_3_1;
nback2cell{12,1} = nback2_vid_3_2;
nback2cell{13,1} = nback2_training;


%% create soundfiles for different nbacklevels using the arrays

% define interstimulusinterval:
isi = 4;

%% nback0

% predefine empty sound cell
nback0_sound = cell(1,size(nback0, 1)+7); % +7 because of video conditions and training

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback0, 1)+7 % loop over sequences
    for stim = 1:1:size(nback0cell{seq},2) % loop over stimuli
        if nback0cell{seq}(stim) == 0
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_0);
        elseif nback0cell{seq}(stim) == 1
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_1);
        elseif nback0cell{seq}(stim) == 2
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_2);
        elseif nback0cell{seq}(stim) == 3
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_3);
        elseif nback0cell{seq}(stim) == 4
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_4);
        elseif nback0cell{seq}(stim) == 5
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_5);
        elseif nback0cell{seq}(stim) == 6
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_6);
        elseif nback0cell{seq}(stim) == 7
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_7);
        elseif nback0cell{seq}(stim) == 8
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_8);
        elseif nback0cell{seq}(stim) == 9
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback0_sound{seq} = vertcat(nback0_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end



%% nback1

% predefine empty sound cell
nback1_sound = cell(1,size(nback1, 1)+7);

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback0, 1)+7 % loop over sequences
    for stim = 1:1:size(nback1cell{seq},2) % loop over stimuli
        if nback1cell{seq}(stim) == 0
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_0);
        elseif nback1cell{seq}(stim) == 1
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_1);
        elseif nback1cell{seq}(stim) == 2
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_2);
        elseif nback1cell{seq}(stim) == 3
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_3);
        elseif nback1cell{seq}(stim) == 4
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_4);
        elseif nback1cell{seq}(stim) == 5
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_5);
        elseif nback1cell{seq}(stim) == 6
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_6);
        elseif nback1cell{seq}(stim) == 7
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_7);
        elseif nback1cell{seq}(stim) == 8
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_8);
        elseif nback1cell{seq}(stim) == 9
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback1_sound{seq} = vertcat(nback1_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end


%% nback2

% predefine empty sound cell
nback2_sound = cell(1,size(nback2, 1)+7);

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback2, 1)+7 % loop over sequences
    for stim = 1:1:size(nback2cell{seq},2) % loop over stimuli
        if nback2cell{seq}(stim) == 0
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_0);
        elseif nback2cell{seq}(stim) == 1
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_1);
        elseif nback2cell{seq}(stim) == 2
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_2);
        elseif nback2cell{seq}(stim) == 3
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_3);
        elseif nback2cell{seq}(stim) == 4
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_4);
        elseif nback2cell{seq}(stim) == 5
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_5);
        elseif nback2cell{seq}(stim) == 6
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_6);
        elseif nback2cell{seq}(stim) == 7
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_7);
        elseif nback2cell{seq}(stim) == 8
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_8);
        elseif nback2cell{seq}(stim) == 9
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback2_sound{seq} = vertcat(nback2_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end

%% create instructions

% nback0

nback0_instructions = vertcat(zeros(Fs*2, size(numbers.nr_1, 2)), instructions.nr_1, zeros(Fs*5, size(numbers.nr_1, 2)), instructions.nr_2, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_3, zeros(Fs*2, size(numbers.nr_1, 2))); 
nback1_instructions = vertcat(zeros(Fs*2, size(numbers.nr_4, 2)), instructions.nr_4, zeros(Fs*6, size(numbers.nr_1, 2)), instructions.nr_5, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_6, zeros(Fs*2, size(numbers.nr_1, 2))); 
nback2_instructions = vertcat(zeros(Fs*2, size(numbers.nr_7, 2)), instructions.nr_7, zeros(Fs*6, size(numbers.nr_1, 2)), instructions.nr_8, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_9, zeros(Fs*2, size(numbers.nr_1, 2))); 

fehl0 = Fs*20 - length(nback0_instructions);
fehl1 = Fs*20 - length(nback1_instructions);
fehl2 = Fs*20 - length(nback2_instructions);

nback0_instructions = vertcat(zeros(fehl0, size(numbers.nr_1, 2)), nback0_instructions);
nback1_instructions = vertcat(zeros(fehl1, size(numbers.nr_1, 2)), nback1_instructions);
nback2_instructions = vertcat(zeros(fehl2, size(numbers.nr_1, 2)), nback2_instructions);

%% concatenate instructions and nback sounds

for seq = 1:size(nback0_sound,2)
    nback0_sound{seq} = vertcat(nback0_instructions, nback0_sound{seq});
    nback1_sound{seq} = vertcat(nback1_instructions, nback1_sound{seq});
    nback2_sound{seq} = vertcat(nback2_instructions, nback2_sound{seq});
end

%% save soundfiles

%% nback0

for seq = 1:size(nback0_sound, 2)
    help = ['nback0\nback0_nr_',num2str(seq)];
    if seq == 7
        help = 'nback0\nback0_video_1_1';
    elseif seq == 8
        help = 'nback0\nback0_video_1_2';
    elseif seq == 9
        help = 'nback0\nback0_video_2_1';
    elseif seq == 10
        help = 'nback0\nback0_video_2_2';
    elseif seq == 11
        help = 'nback0\nback0_video_3_1';
    elseif seq == 12
        help = 'nback0\nback0_video_3_2';
    elseif seq == 13
        help = 'nback0\nback0_video_training';
    end    
    filename = [PATHOUT,help,'.wav'];
    audiowrite(filename,nback0_sound{seq},Fs);
end

%% nback10

for seq = 1:size(nback1_sound, 2)
    help = ['nback1\nback1_nr_',num2str(seq)];
    if seq == 7
        help = 'nback1\nback1_video_1_1';
    elseif seq == 8
        help = 'nback1\nback1_video_1_2';
    elseif seq == 9
        help = 'nback1\nback1_video_2_1';
    elseif seq == 10
        help = 'nback1\nback1_video_2_2';
    elseif seq == 11
        help = 'nback1\nback1_video_3_1';
    elseif seq == 12
        help = 'nback1\nback1_video_3_2';
    elseif seq == 13
        help = 'nback1\nback1_video_training';
    end    
    filename = [PATHOUT,help,'.wav'];
    audiowrite(filename,nback1_sound{seq},Fs);
end

%% nback2

for seq = 1:size(nback2_sound, 2)
    help = ['nback2\nback2_nr_',num2str(seq)];
    if seq == 7
        help = 'nback2\nback2_video_1_1';
    elseif seq == 8
        help = 'nback2\nback2_video_1_2';
    elseif seq == 9
        help = 'nback2\nback2_video_2_1';
    elseif seq == 10
        help = 'nback2\nback2_video_2_2';
    elseif seq == 11
        help = 'nback2\nback2_video_3_1';
    elseif seq == 12
        help = 'nback2\nback2_video_3_2';
    elseif seq == 13
        help = 'nback2\nback2_video_training';
    end    
    filename = [PATHOUT,help,'.wav'];
    audiowrite(filename,nback2_sound{seq},Fs);
end
        

        
        
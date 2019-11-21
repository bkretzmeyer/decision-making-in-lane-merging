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
PATHIN_ARRAY = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_sequences\';
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
load([PATHIN_ARRAY,'array_nback1.mat']);
load([PATHIN_ARRAY,'array_nback2.mat']);

%% create soundfiles for different nbacklevels using the arrays

% define interstimulusinterval:
isi = 4;

%% nback0

% predefine empty sound cell
nback0_sound = cell(1,size(nback0, 1));

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback0, 1) % loop over sequences
    for stim = 1:1:size(nback0, 2) % loop over stimuli
        if nback0(seq, stim) == 0
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_0);
        elseif nback0(seq, stim) == 1
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_1);
        elseif nback0(seq, stim) == 2
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_2);
        elseif nback0(seq, stim) == 3
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_3);
        elseif nback0(seq, stim) == 4
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_4);
        elseif nback0(seq, stim) == 5
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_5);
        elseif nback0(seq, stim) == 6
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_6);
        elseif nback0(seq, stim) == 7
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_7);
        elseif nback0(seq, stim) == 8
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_8);
        elseif nback0(seq, stim) == 9
            nback0_sound{seq} = vertcat(nback0_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback0_sound{seq} = vertcat(nback0_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end


%% nback1

% predefine empty sound cell
nback1_sound = cell(1,size(nback1, 1));

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback0, 1) % loop over sequences
    for stim = 1:1:size(nback1, 2) % loop over stimuli
        if nback1(seq, stim) == 0
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_0);
        elseif nback1(seq, stim) == 1
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_1);
        elseif nback1(seq, stim) == 2
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_2);
        elseif nback1(seq, stim) == 3
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_3);
        elseif nback1(seq, stim) == 4
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_4);
        elseif nback1(seq, stim) == 5
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_5);
        elseif nback1(seq, stim) == 6
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_6);
        elseif nback1(seq, stim) == 7
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_7);
        elseif nback1(seq, stim) == 8
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_8);
        elseif nback1(seq, stim) == 9
            nback1_sound{seq} = vertcat(nback1_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback1_sound{seq} = vertcat(nback1_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end


%% nback2

% predefine empty sound cell
nback2_sound = cell(1,size(nback2, 1));

% add sound stimuli according to the nback array in a loop:
for seq = 1:size(nback2, 1) % loop over sequences
    for stim = 1:1:size(nback2, 2) % loop over stimuli
        if nback2(seq, stim) == 0
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_0);
        elseif nback2(seq, stim) == 1
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_1);
        elseif nback2(seq, stim) == 2
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_2);
        elseif nback2(seq, stim) == 3
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_3);
        elseif nback2(seq, stim) == 4
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_4);
        elseif nback2(seq, stim) == 5
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_5);
        elseif nback2(seq, stim) == 6
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_6);
        elseif nback2(seq, stim) == 7
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_7);
        elseif nback2(seq, stim) == 8
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_8);
        elseif nback2(seq, stim) == 9
            nback2_sound{seq} = vertcat(nback2_sound{seq}, numbers.nr_9);
        end
        % add interstimulus interval:
        nback2_sound{seq} = vertcat(nback2_sound{seq}, zeros(Fs*isi, size(numbers.nr_1, 2)));   
        end
end

%% create instructions

% nback0

nback0_instructions = vertcat(zeros(Fs*2, size(numbers.nr_1, 2)), instructions.nr_1, zeros(Fs*5, size(numbers.nr_1, 2)), instructions.nr_2, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_3, zeros(Fs*2, size(numbers.nr_1, 2))); 
nback1_instructions = vertcat(zeros(Fs*2, size(numbers.nr_4, 2)), instructions.nr_1, zeros(Fs*6, size(numbers.nr_1, 2)), instructions.nr_5, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_6, zeros(Fs*2, size(numbers.nr_1, 2))); 
nback2_instructions = vertcat(zeros(Fs*2, size(numbers.nr_7, 2)), instructions.nr_1, zeros(Fs*6, size(numbers.nr_1, 2)), instructions.nr_8, zeros(Fs*1, size(numbers.nr_1, 2)), instructions.nr_9, zeros(Fs*2, size(numbers.nr_1, 2))); 

fehl0 = Fs*20 - length(nback0_instructions);
fehl1 = Fs*20 - length(nback1_instructions);
fehl2 = Fs*20 - length(nback2_instructions);

nback0_instructions = vertcat(zeros(fehl0, size(numbers.nr_1, 2)), nback0_instructions);
nback1_instructions = vertcat(zeros(fehl1, size(numbers.nr_1, 2)), nback1_instructions);
nback2_instructions = vertcat(zeros(fehl2, size(numbers.nr_1, 2)), nback2_instructions);

%% concatenate instructions and nback sounds

for seq = 1:8
    nback0_sound{seq} = vertcat(nback0_instructions, nback0_sound{seq});
    nback1_sound{seq} = vertcat(nback1_instructions, nback1_sound{seq});
    nback2_sound{seq} = vertcat(nback2_instructions, nback2_sound{seq});
end

%% save soundfiles

%% nback0

for seq = 1:size(nback0_sound, 2)
    filename = [PATHOUT,'nback0\nback0_nr_',num2str(seq),'.wav'];
    audiowrite(filename,nback0_sound{seq},Fs);
end

%% nback10

for seq = 1:size(nback1_sound, 2)
    filename = [PATHOUT,'nback1\nback1_nr_',num2str(seq),'.wav'];
    audiowrite(filename,nback0_sound{seq},Fs);
end

%% nback2

for seq = 1:size(nback2_sound, 2)
    filename = [PATHOUT,'nback2\nback2_nr_',num2str(seq),'.wav'];
    audiowrite(filename,nback2_sound{seq},Fs);
end
        

        
        
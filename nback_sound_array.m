%% nback_sound_array

%%% questions:
% - How many different nback-arrays? 
    % - For each nback condition: 3 for manual driving, 3 for video, 1 for
    % training, hence 7
% - How many different stimuli?
    % - No real arguments in literature against usage of 10 (numbers from
    % zero to nine)
% - What target-foil-ration?
    % - something between 1/6 and 1/3?
    % - Let's go for 1/4 to avoid too much button hitting and too less
    % targets
% - What interstimulus-interval?
    % - 4 seconds (at least exists in literature as "long ISI")
% - What total time?
    % - Each drive should not require way more than 6 minutes, so 8 minutes
    % should be fine (in addition, the actual sounds also add up to the
    % length of the soundfile
    %%%% Because of bloody PRESENTATION: Length of nback soundfiles for
    %%%% video conditions need to be of the exact length as videos
% - What total amount of stimuli?
    % - 4s ISI and 1s of stimulus means 12/minute --> 12*8 = 96
    % - Going for 1/5 target-/foil-ratio it would mean 19 targets
% - random sampling?
    % - random sampling but in a way, terhat there are nor lure trials in
    % either n+1 or n-1
    % - perhaps also take care about having each stimulus being a target with 
    % approx. the same frequency? --> Should probably average out over the
    % whole time
    
%% header 
clear all;
close all;
clc;

slCharacterEncoding('UTF-8');

cd('C:\Users\zuse\OneDrive\Masterarbeit\Code\')
PATHIN = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\';
PATHOUT = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_sequences\';

% cd('C:\Users\bened\OneDrive\Masterarbeit\Code\')
% PATHIN = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\';
% PATHOUT = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\nback_sequences\';


%% load sound files


for ind = 1:10
    [numbers.(['nr_',num2str(ind-1)]), Fs] = audioread([PATHIN,num2str(ind-1),'.wav']);
end


%% create arrays for different soundfiles 

% general variables:

% define amount of arrays, amount of total stimuli and amount of targets:
amount_arrays = 6; % only 6 as the 3 arrays for video condition need to be calculated indvidually
amount_stimuli = 96; % take care that it is dividable by 10
amount_targets = 24;

% amount stimuli and targets for video conditions, based on video length
% as instructions last 20 seconds, subtract 20 seconds from video length
% and subtract one more stimulus to not have longer length of sound
% compared to video

% video_1_1: 5.50min --> 5.30 min --> 330s --> 330/5 = 66 --> 65 stimuli
amount_stimuli_vid_1_1 = 65;
amount_targets_vid_1_1 = round(amount_stimuli_vid_1_1/4);
% video_1_2: 5.27min --> 5.07 min --> 307s --> 307/5 = 61.4 --> 60 stimuli
amount_stimuli_vid_1_2 = 60;
amount_targets_vid_1_2 = round(amount_stimuli_vid_1_2/4);
% video_2_1: 5.49min --> 5.29 min --> 329s --> 329/5 = 65.8 --> 65 stimuli
amount_stimuli_vid_2_1 = 65;
amount_targets_vid_2_1 = round(amount_stimuli_vid_1_2/4);
% video_2_2: 5.49min --> 5.29 min --> 329s --> 329/5 = 65.8 --> 65 stimuli
amount_stimuli_vid_2_2 = 65;
amount_targets_vid_2_2 = round(amount_stimuli_vid_2_2/4);
% video_3_1: 5.28min --> 5.08 min --> 308s --> 308/5 = 61.6 --> 61 stimuli
amount_stimuli_vid_3_1 = 61;
amount_targets_vid_3_1 = round(amount_stimuli_vid_3_1/4);
% video_3_2: 5.46min --> 5.26 min --> 326s --> 326/5 = 65.2 --> 64 stimuli
amount_stimuli_vid_3_2 = 64;
amount_targets_vid_3_2 = round(amount_stimuli_vid_3_2/4);
% video_training: 5.37 min --> 5.17 min --> 317s --> 317/5 = 63.4 --> 62 stimuli
amount_stimuli_training = 62;
amount_targets_training = round(amount_stimuli_vid_3_2/4);

% calculate target probability:
target_prob = amount_targets/amount_stimuli;

%% 1: target identification: 

% take zero as a target

% create array with targets:
array_targets = zeros(1, amount_targets);

array_targets_vid_1_1 = zeros(1,amount_targets_vid_1_1);
array_targets_vid_1_2 = zeros(1,amount_targets_vid_1_2);
array_targets_vid_2_1 = zeros(1,amount_targets_vid_2_1);
array_targets_vid_2_2 = zeros(1,amount_targets_vid_2_2);
array_targets_vid_3_1 = zeros(1,amount_targets_vid_3_1);
array_targets_vid_3_2 = zeros(1,amount_targets_vid_3_2);
array_targets_training = zeros(1,amount_targets_training);

% predefine matrix to store final arrays:
nback0 = zeros(amount_arrays, amount_stimuli);

nback0_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
nback0_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
nback0_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
nback0_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
nback0_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
nback0_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
nback0_training = zeros(1, amount_stimuli_training);

% create final arrays:
for ind = 1:amount_arrays
    % create array with other numbers between one and 9 (foils):
    array_foils = randi(9,amount_stimuli-amount_targets,1)';
    % concatenate arrays of targets and foils:
    array_stimuli = [array_targets, array_foils];
    % shuffle array:
    array_stimuli = array_stimuli(randperm(length(array_stimuli)));
    % store in matrix
    nback0(ind,:) = array_stimuli;
end

% create array with other numbers between one and 9 (foils):
array_foils_vid_1_1 = randi(9,amount_stimuli_vid_1_1-amount_targets_vid_1_1,1)';
array_foils_vid_1_2 = randi(9,amount_stimuli_vid_1_2-amount_targets_vid_1_2,1)';
array_foils_vid_2_1 = randi(9,amount_stimuli_vid_2_1-amount_targets_vid_2_1,1)';
array_foils_vid_2_2 = randi(9,amount_stimuli_vid_2_2-amount_targets_vid_2_2,1)';
array_foils_vid_3_1 = randi(9,amount_stimuli_vid_3_1-amount_targets_vid_3_1,1)';
array_foils_vid_3_2 = randi(9,amount_stimuli_vid_3_2-amount_targets_vid_3_2,1)';
array_foils_training = randi(9,amount_stimuli_training-amount_targets_training,1)';

% concatenate arrays of targets and foils:
array_stimuli_vid_1_1 = [array_targets_vid_1_1, array_foils_vid_1_1];
array_stimuli_vid_1_2 = [array_targets_vid_1_2, array_foils_vid_1_2];
array_stimuli_vid_2_1 = [array_targets_vid_2_1, array_foils_vid_2_1];
array_stimuli_vid_2_2 = [array_targets_vid_2_2, array_foils_vid_2_2];
array_stimuli_vid_3_1 = [array_targets_vid_3_1, array_foils_vid_3_1];
array_stimuli_vid_3_2 = [array_targets_vid_3_2, array_foils_vid_3_2];
array_stimuli_training = [array_targets_training, array_foils_training];

% shuffle array:
array_stimuli_vid_1_1 = array_stimuli_vid_1_1(randperm(length(array_stimuli_vid_1_1)));
array_stimuli_vid_1_2 = array_stimuli_vid_1_2(randperm(length(array_stimuli_vid_1_2)));
array_stimuli_vid_2_1 = array_stimuli_vid_2_1(randperm(length(array_stimuli_vid_2_1)));
array_stimuli_vid_2_2 = array_stimuli_vid_2_2(randperm(length(array_stimuli_vid_2_2)));
array_stimuli_vid_3_1 = array_stimuli_vid_3_1(randperm(length(array_stimuli_vid_3_1)));
array_stimuli_vid_3_2 = array_stimuli_vid_3_2(randperm(length(array_stimuli_vid_3_2)));
array_stimuli_training = array_stimuli_training(randperm(length(array_stimuli_training)));

% store in matrix
nback0_vid_1_1(1,:) = array_stimuli_vid_1_1;
nback0_vid_1_2(1,:) = array_stimuli_vid_1_2;
nback0_vid_2_1(1,:) = array_stimuli_vid_2_1;
nback0_vid_2_2(1,:) = array_stimuli_vid_2_2;
nback0_vid_3_1(1,:) = array_stimuli_vid_3_1;
nback0_vid_3_2(1,:) = array_stimuli_vid_3_2;
nback0_training(1,:) = array_stimuli_training;

% check amount of targets in sequences and create list of targets:

target_list_nb0 = zeros(amount_arrays, amount_stimuli);
target_list_nb0(nback0 == 0) = 1;

target_list_nb0_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
target_list_nb0_vid_1_1(nback0_vid_1_1 == 0) = 1;    

target_list_nb0_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
target_list_nb0_vid_1_2(nback0_vid_1_2 == 0) = 1;    

target_list_nb0_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
target_list_nb0_vid_2_1(nback0_vid_2_1 == 0) = 1;    

target_list_nb0_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
target_list_nb0_vid_2_2(nback0_vid_2_2 == 0) = 1;    

target_list_nb0_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
target_list_nb0_vid_3_1(nback0_vid_3_1 == 0) = 1;    

target_list_nb0_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
target_list_nb0_vid_3_2(nback0_vid_3_2 == 0) = 1;    

target_list_nb0_training = zeros(1, amount_stimuli_training);
target_list_nb0_training(nback0_training == 0) = 1;  
%% 2: nback1: 

% target is a match of the current(n) and the last stimulus(n-1)
% avoid so called lure trials by not allowing for having a match of
% the current stimulus and the second last on (n-2 --> nback-1)

%%%%%%% idea: 
% - Fill up empty array from stimuli array
% - With the specified target probability put in a target
% - Try to avoid lure trials while doing so
% - Check if target ratio is given at the end

% initialize help value for assigning if a target value should be used later on:
x = 1/target_prob;
help_prob = 1:x;

% predefine nback array:
nback1 = zeros(amount_arrays, amount_stimuli);

nback1_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
nback1_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
nback1_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
nback1_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
nback1_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
nback1_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
nback1_training = zeros(1, amount_stimuli_training);

% initialize stimuli arrays
stimuli = 0:9;

stimuli_vid_1_1 = 0:9;
stimuli_vid_1_2 = 0:9;
stimuli_vid_2_1 = 0:9;
stimuli_vid_2_2 = 0:9;
stimuli_vid_3_1 = 0:9;
stimuli_vid_3_2 = 0:9;
stimuli_training = 0:9;

% loop over all needed arrays:
for a = 1:amount_arrays

    % put first value into it:
    nback1(a,1) = randi([0, 9],1,1);

    % put second value into it:
    % avoid to draw same number again:
    stimuli(stimuli == nback1(a,1)) = []; % delete previous value from stimuli array
    pos = randi(length(stimuli)); % random position in the resulting array
    nback1(a,2) = stimuli(pos); % assign next value

    % start a loop for all other values:
    for ind = 3:amount_stimuli
        stimuli = 0:9; 
        stimuli(stimuli == nback1(a,ind-2)) = []; % to avoid lure trials
        stimuli(stimuli == nback1(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
        pos = randi(length(stimuli)); % random position in the resulting array
        % decide if number should be a target: 
        target = randi(length(help_prob));
        if target == 1 
            nback1(a,ind) = nback1(a,ind-1); % assign target value with chosen probability
        else 
            nback1(a,ind) = stimuli(pos); % otherwise choose non-lur number from stimuli array
        end
    end % end of value loop
end % end of loop over needed arrays

% same for video condition sequences without arrray loop:

a = 1;

% put first value into it:
nback1_vid_1_1(a,1) = randi([0, 9],1,1);
nback1_vid_1_2(a,1) = randi([0, 9],1,1);
nback1_vid_2_1(a,1) = randi([0, 9],1,1);
nback1_vid_2_2(a,1) = randi([0, 9],1,1);
nback1_vid_3_1(a,1) = randi([0, 9],1,1);
nback1_vid_3_2(a,1) = randi([0, 9],1,1);
nback1_training(a,1) = randi([0, 9],1,1);

% put second value into it:
% avoid to draw same number again:
stimuli_vid_1_1(stimuli_vid_1_1 == nback1_vid_1_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_1_2(stimuli_vid_1_2 == nback1_vid_1_2(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_2_1(stimuli_vid_2_1 == nback1_vid_2_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_2_2(stimuli_vid_2_2 == nback1_vid_2_2(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_3_1(stimuli_vid_3_1 == nback1_vid_3_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_3_2(stimuli_vid_3_2 == nback1_vid_3_2(a,1)) = []; % delete previous value from stimuli array
stimuli_training(stimuli_training == nback1_training(a,1)) = []; % delete previous value from stimuli array

pos_vid_1_1 = randi(length(stimuli_vid_1_1)); % random position in the resulting array
pos_vid_1_2 = randi(length(stimuli_vid_1_2)); % random position in the resulting array
pos_vid_2_1 = randi(length(stimuli_vid_2_1)); % random position in the resulting array
pos_vid_2_2 = randi(length(stimuli_vid_2_2)); % random position in the resulting array
pos_vid_3_1 = randi(length(stimuli_vid_3_1)); % random position in the resulting array
pos_vid_3_2 = randi(length(stimuli_vid_3_2)); % random position in the resulting array
pos_training = randi(length(stimuli_training)); % random position in the resulting array

nback1_vid_1_1(a,2) = stimuli_vid_1_1(pos_vid_1_1); % assign next value
nback1_vid_1_2(a,2) = stimuli_vid_1_2(pos_vid_1_2); % assign next value
nback1_vid_2_1(a,2) = stimuli_vid_2_1(pos_vid_2_1); % assign next value
nback1_vid_2_2(a,2) = stimuli_vid_2_2(pos_vid_2_2); % assign next value
nback1_vid_3_1(a,2) = stimuli_vid_3_1(pos_vid_3_1); % assign next value
nback1_vid_3_2(a,2) = stimuli_vid_3_2(pos_vid_3_2); % assign next value
nback1_training(a,2) = stimuli_training(pos_training); % assign next value

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_1_1
    stimuli_vid_1_1 = 0:9;
    stimuli_vid_1_1(stimuli_vid_1_1 == nback1_vid_1_1(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_1_1(stimuli_vid_1_1 == nback1_vid_1_1(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_1_1 = randi(length(stimuli_vid_1_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_1_1(a,ind) = nback1_vid_1_1(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_1_1(a,ind) = stimuli_vid_1_1(pos_vid_1_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_1_2
    stimuli_vid_1_2 = 0:9;
    stimuli_vid_1_2(stimuli_vid_1_2 == nback1_vid_1_2(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_1_2(stimuli_vid_1_2 == nback1_vid_1_2(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_1_2 = randi(length(stimuli_vid_1_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_1_2(a,ind) = nback1_vid_1_2(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_1_2(a,ind) = stimuli_vid_1_2(pos_vid_1_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_2_1
    stimuli_vid_2_1 = 0:9;
    stimuli_vid_2_1(stimuli_vid_2_1 == nback1_vid_2_1(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_2_1(stimuli_vid_2_1 == nback1_vid_2_1(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_2_1 = randi(length(stimuli_vid_2_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_2_1(a,ind) = nback1_vid_2_1(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_2_1(a,ind) = stimuli_vid_2_1(pos_vid_2_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_2_2
    stimuli_vid_2_2 = 0:9;
    stimuli_vid_2_2(stimuli_vid_2_2 == nback1_vid_2_2(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_2_2(stimuli_vid_2_2 == nback1_vid_2_2(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_2_2 = randi(length(stimuli_vid_2_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_2_2(a,ind) = nback1_vid_2_2(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_2_2(a,ind) = stimuli_vid_2_2(pos_vid_2_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_3_1
    stimuli_vid_3_1 = 0:9;
    stimuli_vid_3_1(stimuli_vid_3_1 == nback1_vid_3_1(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_3_1(stimuli_vid_3_1 == nback1_vid_3_1(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_3_1 = randi(length(stimuli_vid_3_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_3_1(a,ind) = nback1_vid_3_1(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_3_1(a,ind) = stimuli_vid_3_1(pos_vid_3_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_vid_3_2
    stimuli_vid_3_2 = 0:9;
    stimuli_vid_3_2(stimuli_vid_3_2 == nback1_vid_3_2(a,ind-2)) = []; % to avoid lure trials
    stimuli_vid_3_2(stimuli_vid_3_2 == nback1_vid_3_2(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_vid_3_2 = randi(length(stimuli_vid_3_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_vid_3_2(a,ind) = nback1_vid_3_2(a,ind-1); % assign target value with chosen probability
    else
        nback1_vid_3_2(a,ind) = stimuli_vid_3_2(pos_vid_3_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 3:amount_stimuli_training
    stimuli_training = 0:9;
    stimuli_training(stimuli_training == nback1_training(a,ind-2)) = []; % to avoid lure trials
    stimuli_training(stimuli_training == nback1_training(a,ind-1)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    pos_training = randi(length(stimuli_training)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback1_training(a,ind) = nback1_training(a,ind-1); % assign target value with chosen probability
    else
        nback1_training(a,ind) = stimuli_training(pos_training); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

    
% check amount of targets in sequences and create list of targets:
target_count_nb1 = zeros(amount_arrays, 1);
target_count_nb1_vid_1_1 = zeros(1, 1);
target_count_nb1_vid_1_2 = zeros(1, 1);
target_count_nb1_vid_2_1 = zeros(1, 1);
target_count_nb1_vid_2_2 = zeros(1, 1);
target_count_nb1_vid_3_1 = zeros(1, 1);
target_count_nb1_vid_3_2 = zeros(1, 1);
target_count_nb1_training = zeros(1, 1);

target_list_nb1 = zeros(amount_arrays, amount_stimuli);
target_list_nb1_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
target_list_nb1_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
target_list_nb1_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
target_list_nb1_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
target_list_nb1_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
target_list_nb1_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
target_list_nb1_training = zeros(1, amount_stimuli_training);

for row = 1:amount_arrays
    for col = 2:amount_stimuli
        if nback1(row,col) == nback1(row,col-1)
            target_count_nb1(row) = target_count_nb1(row) + 1;
            target_list_nb1(row, col) = 1;
        end
    end
end

row = 1;

for col = 2:amount_stimuli_vid_1_1
    if nback1_vid_1_1(row,col) == nback1_vid_1_1(row,col-1)
        target_count_nb1_vid_1_1(row) = target_count_nb1_vid_1_1(row) + 1;
        target_list_nb1_vid_1_1(row, col) = 1;
    end
end

for col = 2:amount_stimuli_vid_1_2
    if nback1_vid_1_2(row,col) == nback1_vid_1_2(row,col-1)
        target_count_nb1_vid_1_2(row) = target_count_nb1_vid_1_2(row) + 1;
        target_list_nb1_vid_1_2(row, col) = 1;
    end
end

for col = 2:amount_stimuli_vid_2_1
    if nback1_vid_2_1(row,col) == nback1_vid_2_1(row,col-1)
        target_count_nb1_vid_2_1(row) = target_count_nb1_vid_2_1(row) + 1;
        target_list_nb1_vid_2_1(row, col) = 1;
    end
end

for col = 2:amount_stimuli_vid_2_2
    if nback1_vid_2_2(row,col) == nback1_vid_2_2(row,col-1)
        target_count_nb1_vid_2_2(row) = target_count_nb1_vid_2_2(row) + 1;
        target_list_nb1_vid_2_2(row, col) = 1;
    end
end

for col = 2:amount_stimuli_vid_3_1
    if nback1_vid_3_1(row,col) == nback1_vid_3_1(row,col-1)
        target_count_nb1_vid_3_1(row) = target_count_nb1_vid_3_1(row) + 1;
        target_list_nb1_vid_3_1(row, col) = 1;
    end
end

for col = 2:amount_stimuli_vid_3_2
    if nback1_vid_3_2(row,col) == nback1_vid_3_2(row,col-1)
        target_count_nb1_vid_3_2(row) = target_count_nb1_vid_3_2(row) + 1;
        target_list_nb1_vid_3_2(row, col) = 1;
    end
end

for col = 2:amount_stimuli_training
    if nback1_training(row,col) == nback1_training(row,col-1)
        target_count_nb1_training(row) = target_count_nb1_training(row) + 1;
        target_list_nb1_training(row, col) = 1;
    end
end


%% 3: nback2:

% more or less the same procedure as for nback1
% differences: - nback level
% lure trials are avoided by not allowing for having a match of
% the current stimulus and the third last on (n-3 --> nback-1) AND
% the current stimulus and the previous one (n-1)

% initialize help value for assigning if a target value should be used later on:
x = 1/target_prob;
help_prob = 1:x;

% predefine nback arrays:
nback2 = zeros(amount_arrays, amount_stimuli);

nback2_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
nback2_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
nback2_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
nback2_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
nback2_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
nback2_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
nback2_training = zeros(1, amount_stimuli_training);


% initialize stimuli arrays:
stimuli = 0:9;

stimuli_vid_1_1 = 0:9;
stimuli_vid_1_2 = 0:9;
stimuli_vid_2_1 = 0:9;
stimuli_vid_2_2 = 0:9;
stimuli_vid_3_1 = 0:9;
stimuli_vid_3_2 = 0:9;
stimuli_training = 0:9;

% loop over all needed arrays:
for a = 1:amount_arrays

    % put first value into it:
    nback2(a,1) = randi([0, 9],1,1);

    % put second value into it:
    % avoid to use same number again:
    stimuli(stimuli == nback2(a,1)) = []; % delete previous value from stimuli array
    pos = randi(length(stimuli)); % random position in the resulting array
    nback2(a,2) = stimuli(pos); % assign next value
    
    % put third value into it:
    % avoid to use one of the same numbers again:
    stimuli(stimuli == nback2(a,2)) = []; % delete previous value from stimuli array
    pos = randi(length(stimuli)); % random position in the resulting array
    nback2(a,3) = stimuli(pos); % assign next value

    % start a loop for all other values:
    for ind = 4:amount_stimuli
        stimuli = 0:9; 
        stimuli(stimuli == nback2(a,ind-3)) = []; % to avoid lure trials at n-1
        stimuli(stimuli == nback2(a,ind-1)) = []; % to avoid lure trials at n+1
        stimuli(stimuli == nback2(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
        pos = randi(length(stimuli)); % random position in the resulting array
        % decide if number should be a target: 
        target = randi(length(help_prob));
        if target == 1 
            nback2(a,ind) = nback2(a,ind-2); % assign target value with chosen probability
        else 
            nback2(a,ind) = stimuli(pos); % otherwise choose non-lur number from stimuli array
        end
    end % end of value loop
end % end of loop over needed arrays

% same for video condition sequences without arrray loop:

a = 1;

% put first value into it:
nback2_vid_1_1(a,1) = randi([0, 9],1,1);
nback2_vid_1_2(a,1) = randi([0, 9],1,1);
nback2_vid_2_1(a,1) = randi([0, 9],1,1);
nback2_vid_2_2(a,1) = randi([0, 9],1,1);
nback2_vid_3_1(a,1) = randi([0, 9],1,1);
nback2_vid_3_2(a,1) = randi([0, 9],1,1);
nback2_training(a,1) = randi([0, 9],1,1);

% put second value into it:
% avoid to draw same number again:
stimuli_vid_1_1(stimuli_vid_1_1 == nback2_vid_1_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_1_2(stimuli_vid_1_2 == nback2_vid_1_2(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_2_1(stimuli_vid_2_1 == nback2_vid_2_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_2_2(stimuli_vid_2_2 == nback2_vid_2_2(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_3_1(stimuli_vid_3_1 == nback2_vid_3_1(a,1)) = []; % delete previous value from stimuli array
stimuli_vid_3_2(stimuli_vid_3_2 == nback2_vid_3_2(a,1)) = []; % delete previous value from stimuli array
stimuli_training(stimuli_training == nback2_training(a,1)) = []; % delete previous value from stimuli array

pos_vid_1_1 = randi(length(stimuli_vid_1_1)); % random position in the resulting array
pos_vid_1_2 = randi(length(stimuli_vid_1_2)); % random position in the resulting array
pos_vid_2_1 = randi(length(stimuli_vid_2_1)); % random position in the resulting array
pos_vid_2_2 = randi(length(stimuli_vid_2_2)); % random position in the resulting array
pos_vid_3_1 = randi(length(stimuli_vid_3_1)); % random position in the resulting array
pos_vid_3_2 = randi(length(stimuli_vid_3_2)); % random position in the resulting array
pos_training = randi(length(stimuli_training)); % random position in the resulting array

nback2_vid_1_1(a,2) = stimuli_vid_1_1(pos_vid_1_1); % assign next value
nback2_vid_1_2(a,2) = stimuli_vid_1_2(pos_vid_1_2); % assign next value
nback2_vid_2_1(a,2) = stimuli_vid_2_1(pos_vid_2_1); % assign next value
nback2_vid_2_2(a,2) = stimuli_vid_2_2(pos_vid_2_2); % assign next value
nback2_vid_3_1(a,2) = stimuli_vid_3_1(pos_vid_3_1); % assign next value
nback2_vid_3_2(a,2) = stimuli_vid_3_2(pos_vid_3_2); % assign next value
nback2_training(a,2) = stimuli_training(pos_training); % assign next value

% put third value into it:
% avoid to use one of the same numbers again:
stimuli_vid_1_1(stimuli_vid_1_1 == nback2_vid_1_1(a,2)) = []; % delete previous value from stimuli array
stimuli_vid_1_2(stimuli_vid_1_2 == nback2_vid_1_2(a,2)) = []; % delete previous value from stimuli array
stimuli_vid_2_1(stimuli_vid_2_1 == nback2_vid_2_1(a,2)) = []; % delete previous value from stimuli array
stimuli_vid_2_2(stimuli_vid_2_2 == nback2_vid_2_2(a,2)) = []; % delete previous value from stimuli array
stimuli_vid_3_1(stimuli_vid_3_1 == nback2_vid_3_1(a,2)) = []; % delete previous value from stimuli array
stimuli_vid_3_2(stimuli_vid_3_2 == nback2_vid_3_2(a,2)) = []; % delete previous value from stimuli array
stimuli_training(stimuli_training == nback2_training(a,2)) = []; % delete previous value from stimuli array

pos_vid_1_1 = randi(length(stimuli_vid_1_1)); % random position in the resulting array
pos_vid_1_2 = randi(length(stimuli_vid_1_2)); % random position in the resulting array
pos_vid_2_1 = randi(length(stimuli_vid_2_1)); % random position in the resulting array
pos_vid_2_2 = randi(length(stimuli_vid_2_2)); % random position in the resulting array
pos_vid_3_1 = randi(length(stimuli_vid_3_1)); % random position in the resulting array
pos_vid_3_2 = randi(length(stimuli_vid_3_2)); % random position in the resulting array
pos_training = randi(length(stimuli_training)); % random position in the resulting array

nback2_vid_1_1(a,3) = stimuli_vid_1_1(pos_vid_1_1); % assign next value
nback2_vid_1_2(a,3) = stimuli_vid_1_2(pos_vid_1_2); % assign next value
nback2_vid_2_1(a,3) = stimuli_vid_2_1(pos_vid_2_1); % assign next value
nback2_vid_2_2(a,3) = stimuli_vid_2_2(pos_vid_2_2); % assign next value
nback2_vid_3_1(a,3) = stimuli_vid_3_1(pos_vid_3_1); % assign next value
nback2_vid_3_2(a,3) = stimuli_vid_3_2(pos_vid_3_2); % assign next value
nback2_training(a,3) = stimuli_training(pos_training); % assign next value

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_1_1
    stimuli_vid_1_1 = 0:9;
    stimuli_vid_1_1(stimuli_vid_1_1 == nback2_vid_1_1(a,ind-3)) = []; % to avoid lure trials 
    stimuli_vid_1_1(stimuli_vid_1_1 == nback2_vid_1_1(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_1_1(stimuli_vid_1_1 == nback2_vid_1_1(a,ind-1)) = []; % to avoid lure trials
    pos_vid_1_1 = randi(length(stimuli_vid_1_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_1_1(a,ind) = nback2_vid_1_1(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_1_1(a,ind) = stimuli_vid_1_1(pos_vid_1_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_1_2
    stimuli_vid_1_2 = 0:9;
    stimuli_vid_1_2(stimuli_vid_1_2 == nback2_vid_1_2(a,ind-3)) = []; % to avoid lure trials
    stimuli_vid_1_2(stimuli_vid_1_2 == nback2_vid_1_2(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_1_2(stimuli_vid_1_2 == nback2_vid_1_2(a,ind-1)) = []; % to avoid lure trials
    pos_vid_1_2 = randi(length(stimuli_vid_1_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_1_2(a,ind) = nback2_vid_1_2(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_1_2(a,ind) = stimuli_vid_1_2(pos_vid_1_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_2_1
    stimuli_vid_2_1 = 0:9;
    stimuli_vid_2_1(stimuli_vid_2_1 == nback2_vid_2_1(a,ind-3)) = []; % to avoid lure trials
    stimuli_vid_2_1(stimuli_vid_2_1 == nback2_vid_2_1(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_2_1(stimuli_vid_2_1 == nback2_vid_2_1(a,ind-1)) = []; % to avoid lure trials
    pos_vid_2_1 = randi(length(stimuli_vid_2_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_2_1(a,ind) = nback2_vid_2_1(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_2_1(a,ind) = stimuli_vid_2_1(pos_vid_2_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_2_2
    stimuli_vid_2_2 = 0:9;
    stimuli_vid_2_2(stimuli_vid_2_2 == nback2_vid_2_2(a,ind-3)) = []; % to avoid lure trials
    stimuli_vid_2_2(stimuli_vid_2_2 == nback2_vid_2_2(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_2_2(stimuli_vid_2_2 == nback2_vid_2_2(a,ind-1)) = []; % to avoid lure trials
    pos_vid_2_2 = randi(length(stimuli_vid_2_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_2_2(a,ind) = nback2_vid_2_2(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_2_2(a,ind) = stimuli_vid_2_2(pos_vid_2_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_3_1
    stimuli_vid_3_1 = 0:9;
    stimuli_vid_3_1(stimuli_vid_3_1 == nback2_vid_3_1(a,ind-3)) = []; % to avoid lure trials
    stimuli_vid_3_1(stimuli_vid_3_1 == nback2_vid_3_1(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_3_1(stimuli_vid_3_1 == nback2_vid_3_1(a,ind-1)) = []; % to avoid lure trials
    pos_vid_3_1 = randi(length(stimuli_vid_3_1)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_3_1(a,ind) = nback2_vid_3_1(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_3_1(a,ind) = stimuli_vid_3_1(pos_vid_3_1); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_vid_3_2
    stimuli_vid_3_2 = 0:9;
    stimuli_vid_3_2(stimuli_vid_3_2 == nback2_vid_3_2(a,ind-3)) = []; % to avoid lure trials
    stimuli_vid_3_2(stimuli_vid_3_2 == nback2_vid_3_2(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_vid_3_2(stimuli_vid_3_2 == nback2_vid_3_2(a,ind-1)) = []; % to avoid lure trials
    pos_vid_3_2 = randi(length(stimuli_vid_3_2)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_vid_3_2(a,ind) = nback2_vid_3_2(a,ind-2); % assign target value with chosen probability
    else
        nback2_vid_3_2(a,ind) = stimuli_vid_3_2(pos_vid_3_2); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop

% start a loop for all other values:
for ind = 4:amount_stimuli_training
    stimuli_training = 0:9;
    stimuli_training(stimuli_training == nback2_training(a,ind-3)) = []; % to avoid lure trials
    stimuli_training(stimuli_training == nback2_training(a,ind-2)) = []; % to avoid targets, as targets are assigned independent of the stimuli array
    stimuli_training(stimuli_training == nback2_training(a,ind-1)) = []; % to avoid lure trials
    pos_training = randi(length(stimuli_training)); % random position in the resulting array
    % decide if number should be a target:
    target = randi(length(help_prob));
    if target == 1
        nback2_training(a,ind) = nback2_training(a,ind-2); % assign target value with chosen probability
    else
        nback2_training(a,ind) = stimuli_training(pos_training); % otherwise choose non-lur number from stimuli array
    end
end % end of value loop


    
% check amount of targets in sequences and create list of targets:
target_count_nb2 = zeros(amount_arrays, 1);
target_count_nb2_vid_1_1 = zeros(1, 1);
target_count_nb2_vid_1_2 = zeros(1, 1);
target_count_nb2_vid_2_1 = zeros(1, 1);
target_count_nb2_vid_2_2 = zeros(1, 1);
target_count_nb2_vid_3_1 = zeros(1, 1);
target_count_nb2_vid_3_2 = zeros(1, 1);
target_count_nb2_training = zeros(1, 1);

target_list_nb2 = zeros(amount_arrays, amount_stimuli);
target_list_nb2_vid_1_1 = zeros(1, amount_stimuli_vid_1_1);
target_list_nb2_vid_1_2 = zeros(1, amount_stimuli_vid_1_2);
target_list_nb2_vid_2_1 = zeros(1, amount_stimuli_vid_2_1);
target_list_nb2_vid_2_2 = zeros(1, amount_stimuli_vid_2_2);
target_list_nb2_vid_3_1 = zeros(1, amount_stimuli_vid_3_1);
target_list_nb2_vid_3_2 = zeros(1, amount_stimuli_vid_3_2);
target_list_nb2_training = zeros(1, amount_stimuli_training);

for row = 1:amount_arrays
    for col = 3:amount_stimuli
        if nback2(row,col) == nback2(row,col-2)
            target_count_nb2(row) = target_count_nb2(row) + 1;
            target_list_nb2(row, col) = 1;
        end
    end
end

row = 1;

for col = 3:amount_stimuli_vid_1_1
    if nback2_vid_1_1(row,col) == nback2_vid_1_1(row,col-2)
        target_count_nb2_vid_1_1(row) = target_count_nb2_vid_1_1(row) + 1;
        target_list_nb2_vid_1_1(row, col) = 1;
    end
end

for col = 3:amount_stimuli_vid_1_2
    if nback2_vid_1_2(row,col) == nback2_vid_1_2(row,col-2)
        target_count_nb2_vid_1_2(row) = target_count_nb2_vid_1_2(row) + 1;
        target_list_nb2_vid_1_2(row, col) = 1;
    end
end

for col = 3:amount_stimuli_vid_2_1
    if nback1_vid_2_1(row,col) == nback2_vid_2_1(row,col-2)
        target_count_nb2_vid_2_1(row) = target_count_nb2_vid_2_1(row) + 1;
        target_list_nb2_vid_2_1(row, col) = 1;
    end
end

for col = 3:amount_stimuli_vid_2_2
    if nback2_vid_2_2(row,col) == nback2_vid_2_2(row,col-2)
        target_count_nb2_vid_2_2(row) = target_count_nb2_vid_2_2(row) + 1;
        target_list_nb2_vid_2_2(row, col) = 1;
    end
end

for col = 3:amount_stimuli_vid_3_1
    if nback2_vid_3_1(row,col) == nback2_vid_3_1(row,col-2)
        target_count_nb2_vid_3_1(row) = target_count_nb2_vid_3_1(row) + 1;
        target_list_nb2_vid_3_1(row, col) = 1;
    end
end

for col = 3:amount_stimuli_vid_3_2
    if nback2_vid_3_2(row,col) == nback2_vid_3_2(row,col-2)
        target_count_nb2_vid_3_2(row) = target_count_nb2_vid_3_2(row) + 1;
        target_list_nb2_vid_3_2(row, col) = 1;
    end
end

for col = 3:amount_stimuli_training
    if nback2_training(row,col) == nback2_training(row,col-2)
        target_count_nb2_training(row) = target_count_nb2_training(row) + 1;
        target_list_nb2_training(row, col) = 1;
    end
end



%% save resulting arrays

%% nback0

save([PATHOUT,'array_nback0.mat'],'nback0');

save([PATHOUT,'array_nback0_vid_1_1.mat'],'nback0_vid_1_1');
save([PATHOUT,'array_nback0_vid_1_2.mat'],'nback0_vid_1_2');
save([PATHOUT,'array_nback0_vid_2_1.mat'],'nback0_vid_2_1');
save([PATHOUT,'array_nback0_vid_2_2.mat'],'nback0_vid_2_2');
save([PATHOUT,'array_nback0_vid_3_1.mat'],'nback0_vid_3_1');
save([PATHOUT,'array_nback0_vid_3_2.mat'],'nback0_vid_3_2');
save([PATHOUT,'array_nback0_training.mat'],'nback0_training');

save([PATHOUT,'targets_nback0.mat'],'target_list_nb0');

save([PATHOUT,'targets_nback0_vid_1_1.mat'],'target_list_nb0_vid_1_1');
save([PATHOUT,'targets_nback0_vid_1_2.mat'],'target_list_nb0_vid_1_2');
save([PATHOUT,'targets_nback0_vid_2_1.mat'],'target_list_nb0_vid_2_1');
save([PATHOUT,'targets_nback0_vid_2_2.mat'],'target_list_nb0_vid_2_2');
save([PATHOUT,'targets_nback0_vid_3_1.mat'],'target_list_nb0_vid_3_1');
save([PATHOUT,'targets_nback0_vid_3_2.mat'],'target_list_nb0_vid_3_2');
save([PATHOUT,'targets_nback0_training.mat'],'target_list_nb0_training');

%% nback1

save([PATHOUT,'array_nback1.mat'],'nback1');

save([PATHOUT,'array_nback1_vid_1_1.mat'],'nback1_vid_1_1');
save([PATHOUT,'array_nback1_vid_1_2.mat'],'nback1_vid_1_2');
save([PATHOUT,'array_nback1_vid_2_1.mat'],'nback1_vid_2_1');
save([PATHOUT,'array_nback1_vid_2_2.mat'],'nback1_vid_2_2');
save([PATHOUT,'array_nback1_vid_3_1.mat'],'nback1_vid_3_1');
save([PATHOUT,'array_nback1_vid_3_2.mat'],'nback1_vid_3_2');
save([PATHOUT,'array_nback1_training.mat'],'nback1_training');

save([PATHOUT,'targets_nback1.mat'],'target_list_nb1');

save([PATHOUT,'targets_nback1_vid_1_1.mat'],'target_list_nb1_vid_1_1');
save([PATHOUT,'targets_nback1_vid_1_2.mat'],'target_list_nb1_vid_1_2');
save([PATHOUT,'targets_nback1_vid_2_1.mat'],'target_list_nb1_vid_2_1');
save([PATHOUT,'targets_nback1_vid_2_2.mat'],'target_list_nb1_vid_2_2');
save([PATHOUT,'targets_nback1_vid_3_1.mat'],'target_list_nb1_vid_3_1');
save([PATHOUT,'targets_nback1_vid_3_2.mat'],'target_list_nb1_vid_3_2');
save([PATHOUT,'targets_nback1_training.mat'],'target_list_nb1_training');
%% nback2

save([PATHOUT,'array_nback2.mat'],'nback2');

save([PATHOUT,'array_nback2_vid_1_1.mat'],'nback2_vid_1_1');
save([PATHOUT,'array_nback2_vid_1_2.mat'],'nback2_vid_1_2');
save([PATHOUT,'array_nback2_vid_2_1.mat'],'nback2_vid_2_1');
save([PATHOUT,'array_nback2_vid_2_2.mat'],'nback2_vid_2_2');
save([PATHOUT,'array_nback2_vid_3_1.mat'],'nback2_vid_3_1');
save([PATHOUT,'array_nback2_vid_3_2.mat'],'nback2_vid_3_2');
save([PATHOUT,'array_nback2_training.mat'],'nback2_training');

save([PATHOUT,'targets_nback2.mat'],'target_list_nb2');

save([PATHOUT,'targets_nback2_vid_1_1.mat'],'target_list_nb2_vid_1_1');
save([PATHOUT,'targets_nback2_vid_1_2.mat'],'target_list_nb2_vid_1_2');
save([PATHOUT,'targets_nback2_vid_2_1.mat'],'target_list_nb2_vid_2_1');
save([PATHOUT,'targets_nback2_vid_2_2.mat'],'target_list_nb2_vid_2_2');
save([PATHOUT,'targets_nback2_vid_3_1.mat'],'target_list_nb2_vid_3_1');
save([PATHOUT,'targets_nback2_vid_3_2.mat'],'target_list_nb2_vid_3_2');
save([PATHOUT,'targets_nback2_training.mat'],'target_list_nb2_training');










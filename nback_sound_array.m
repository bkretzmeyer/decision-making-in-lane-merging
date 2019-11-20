%% nback_sound_array

%%% questions:
% - How many different nback-arrays? 
    % - For each nback condition: 3 for manual driving, 3 for video, 2 for
    % training, hence 8
% - How many different stimuli?
    % - No real arguments in literature against usage of 10 (numbers from
    % zero to nine)
% - What target-foil-ration?
    % - something between 1/6 and 1/3?
    % - Let's go for 1/5 to avoid too much button hitting
% - What interstimulus-interval?
    % - 4 seconds (at least exists in literature as "long ISI")
% - What total time?
    % - Each drive should not require way more than 6 minutes, so 8 minutes
    % should be fine (in addition, the actual sounds also add up to the
    % length of the soundfile
% - What total amount of stimuli?
    % - 4s ISI means 15/minute --> 15*8 = 120
    % - Going for 1/5 target-/foil-ratio it would mean 24 targets
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

%general variables:

% define amount of arrays, amount of total stimuli and amount of targets:
amount_arrays = 8;
amount_stimuli = 120; % take care that it is dividable by 10
amount_targets = 24;
% calculate target probability:
target_prob = amount_targets/amount_stimuli;

%% 1: target identification: 

% take zero as a target

% create array with targets:
array_targets = zeros(1, amount_targets);

% predefine matrix to store final arrays:
nback0 = zeros(amount_arrays, amount_stimuli);

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
    

%% 2: nback1: 

% target is a match of the current(n) and the last stimulus(n-1)
% avoid so called lure trials by not allowing for having a match of
% the current stimulus and the second last on (n-2 --> nback-1)

%%%%%%% idea: 
% - Fill up empty array from stimuli array
% - With the specified target probability put in a target
% - Try to avoid lure trials while doing so
% - Check if target ratio is given at the end

% initialize stimuli array
stimuli = 0:9;

% initialize help value for assigning if a target value should be used later on:
x = 1/target_prob;
help_prob = 1:x;

% predefine nback array:
nback1 = zeros(amount_arrays, amount_stimuli);

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
    
% check amount of targets in sequences:
target_count_nb1 = zeros(amount_arrays, 1);
for row = 1:amount_arrays
    for col = 2:amount_stimuli
        if nback1(row,col) == nback1(row,col-1)
            target_count_nb1(row) = target_count_nb1(row) + 1;
        end
    end
end


%% 3: nback2:

% more or less the same procedure as for nback1
% differences: - nback level
% lure trials are avoided by not allowing for having a match of
% the current stimulus and the third last on (n-3 --> nback-1) AND
% the current stimulus and the previous one (n-1)

% initialize stimuli array
stimuli = 0:9;

% initialize help value for assigning if a target value should be used later on:
x = 1/target_prob;
help_prob = 1:x;

% predefine nback array:
nback2 = zeros(amount_arrays, amount_stimuli);

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
    
% check amount of targets in sequences:
target_count_nb2 = zeros(amount_arrays, 1);
for row = 1:amount_arrays
    for col = 3:amount_stimuli
        if nback2(row,col) == nback2(row,col-2)
            target_count_nb2(row) = target_count_nb2(row) + 1;
        end
    end
end


%% save resulting arrays

%% nback0

save([PATHOUT,'array_nback0.mat'],'nback0');

%% nback1

save([PATHOUT,'array_nback1.mat'],'nback1');

%% nback2

save([PATHOUT,'array_nback2.mat'],'nback2');













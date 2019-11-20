%% calculate reasonable gap sizes based on results of previous studies

clear all;
close all;
clc;

cd = 'C:\Users\zuse\OneDrive\Masterarbeit\Code\merging_probs_old_studies\';
PATHIN = 'C:\Users\zuse\OneDrive\Masterarbeit\Code\merging_probs_old_studies\';

%% load data

load([PATHIN,'behav_data_fMRI.mat']);

%% info from Viviane:
% the gap_sizes_combined_all matrix contains all the necessary data. In
% total we have 5475 decisions (even the ones where the subject waited and
% didn't merge:
% first column: gap size
% second column: merging decision (0 / 1)
% third column: interaction type: 1 == AV and 2 == H
% forth column: subject id

gap = gap_sizes_combined_all;
% sort array:
gap = sortrows(gap);
% get rid of NaN:
gap = rmmissing(gap);

%% get basic info about data

min_gap = min(gap(:,1));
max_gap = max(gap(:,1));
mean_gap = mean(gap(:,1));
std_gap = std(gap(:,1));
% gap sizes between 16.152 and 80.76

% plot distribution:
figure;
histogram(gap(:,1));
% wtf?

% amount of different gap sizes:
U = unique(gap(:,1));

% Gap size vs. acceptance (from Viviane):
figure;
x = gap_sizes_combined_all;
step = 5;
prob_AV = [];
counter = 1;
for uu = 5:step:100
    idx_AV = find((x(:,1) >= uu) & (x(:,1) <= uu+step));
    taken_AV = sum(x(idx_AV,2));
    prob_AV(counter,1) = uu+step/2;
    prob_AV(counter,2) = taken_AV/length(idx_AV);

    counter = counter + 1;
end

plot(prob_AV(:,1), prob_AV(:,2), '.', 'MarkerSize', 15); hold on;

xlabel('Gap size [m]')
ylabel('Acceptance')



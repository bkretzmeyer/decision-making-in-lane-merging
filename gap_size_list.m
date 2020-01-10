%% list of all gap sizes in all szenarios

clear all;
close all;
clc;

slCharacterEncoding('UTF-8');

cd('C:\Users\zuse\OneDrive\Masterarbeit\Code\')

% rows in position matrix:

% self driven scenarios:
% scenario 1:
    % position matrix self 1:
    % [1,3,4,5,6,7,8,22]
    % position matrix self 2:
    % [2,3,4,5,6,7,8,22]
    
% scenario 2: 
    % position matrix self 2:
    % [1,9,10,11,12,13,14,23]
    % position matrix self 1:
    % [9,10,11,12,13,14,15,23]
    
% scenario 3:
    % position matrix self 1:
    % [2,16,17,18,19,20,21,24]
    % position matrix self 2:
    % [15,16,17,18,19,20,21,24]
    
% video scnearios:
% scenario 1_1:
    % position matrix self 1:
    % [1,4,5,6,7,8,9,22]
    
% scenario 1_2: 
    % position matrix self 2:
    % [1,4,5,6,7,8,9,22]
    
% scenario 2_1:
    % position matrix self 2:
    % [2,10,11,12,13,14,15,23]
    
% scenario 2_2: 
    % position matrix self 1:
    % [2,10,11,12,13,14,15,23]
    
% scenario 3_1:
    % position matrix self 1:
    % [3,16,17,18,19,20,21,24]
    
% scenario 3_2: 
    % position matrix self 2:
    % [3,16,17,18,19,20,21,24]
    

%% load position matrices
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_self_1.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_self_2.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_video_1.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_video_2.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_training_1.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_training_2.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_training_video_1.mat');
load('C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\final_position_matrix_training_video_2.mat');

%% get correct gaps for each szenario

% create matrices with positions for all scenarios according to the
% information on top of this file
pos_self_1(1:8,:) = P_1([1,3,4,5,6,7,8,22],:);
pos_self_1(9:16,:) = P_2([2,3,4,5,6,7,8,22],:);
pos_self_2(1:8,:) = P_2([1,9,10,11,12,13,14,23],:);
pos_self_2(9:16,:) = P_1([9,10,11,12,13,14,15,23],:);
pos_self_3(1:8,:) = P_1([2,16,17,18,19,20,21,24],:);
pos_self_3(9:16,:) = P_2([15,16,17,18,19,20,21,24],:);

pos_vid_1_1 = P_3([1,4,5,6,7,8,9,22],:);
pos_vid_1_2 = P_4([1,4,5,6,7,8,9,22],:);
pos_vid_2_1 = P_4([2,10,11,12,13,14,15,23],:);
pos_vid_2_2 = P_3([2,10,11,12,13,14,15,23],:);
pos_vid_3_1 = P_3([3,16,17,18,19,20,21,24],:);
pos_vid_3_2 = P_4([3,16,17,18,19,20,21,24],:);

pos_training_self(1:8,:) = P_5([1,3,4,5,6,7,8,22],:);
pos_training_self(9:16,:) = P_6([2,3,4,5,6,7,8,22],:);

pos_training_video = P_7([1,4,5,6,7,8,9,22],:);

% create gap size matrices
gap_self_1 = pos_self_1(:,1:7)-pos_self_1(:,2:8);
gap_self_2 = pos_self_2(:,1:7)-pos_self_2(:,2:8);
gap_self_3 = pos_self_3(:,1:7)-pos_self_3(:,2:8);

gap_vid_1_1 = pos_vid_1_1(:,1:7)-pos_vid_1_1(:,2:8);
gap_vid_1_2 = pos_vid_1_2(:,1:7)-pos_vid_1_2(:,2:8);
gap_vid_2_1 = pos_vid_2_1(:,1:7)-pos_vid_2_1(:,2:8);
gap_vid_2_2 = pos_vid_2_2(:,1:7)-pos_vid_2_2(:,2:8);
gap_vid_3_1 = pos_vid_3_1(:,1:7)-pos_vid_3_1(:,2:8);
gap_vid_3_2 = pos_vid_3_2(:,1:7)-pos_vid_3_2(:,2:8);

gap_training_self = pos_training_self(:,1:7)-pos_training_self(:,2:8);
gap_training_video = pos_training_video(:,1:7)-pos_training_video(:,2:8);
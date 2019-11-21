%% adjust length of numbers sound stimuli

% adjust length of all numbers to equal one second

%% header
clear all;
close all;
clc;

slCharacterEncoding('UTF-8');

cd('C:\Users\zuse\OneDrive\Masterarbeit\Code\')
PATHIN = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\original\';
PATHOUT = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\nback\numbers_soundfiles\';


%% load soundfiles (single numbers)

for ind = 1:10
    [numbers.(['nr_',num2str(ind-1)]), Fs] = audioread([PATHIN,num2str(ind-1),'.wav']);
end

%% calculate missing time to equal one second

for ind = 1:10
    fehl(ind) = Fs - length(numbers.(['nr_',num2str(ind-1)]));
end

%% enlarge numbers 

for ind = 1:10
    numbers.(['nr_',num2str(ind-1)]) = vertcat(numbers.(['nr_',num2str(ind-1)]), zeros(fehl(ind), size(numbers.nr_1, 2)));
end

%% save new numbers soundfiles

for ind = 1:10
    filename = [PATHOUT,num2str(ind-1),'.wav'];
    audiowrite(filename,numbers.(['nr_',num2str(ind-1)]),Fs);
end

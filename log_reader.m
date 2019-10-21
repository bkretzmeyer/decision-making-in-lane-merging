%% read in SILAB log files

clear all;
close all;
clc;

cd = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\Silab_Pilot_Log\';
PATHIN = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\Silab_Pilot_Log\';

% cd = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\Silab_Pilot_Log\';
% PATHIN = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\Silab_Pilot_Log\';

%% specify datasets

datasets = {'gapSizeJune_s1.6.csv'};

datasetnames = {'pilot_test_1'};


for ind = 1:length(datasets)
    
    logdata.(datasetnames{ind}) = importdata([PATHIN,datasets{ind}]);
    
end

%% test anaylysis

testy = logdata.(datasetnames{1}).textdata(2:end,[1,3]);
testy = str2double(testy);

start = 0;

for ind = 1:length(testy)
    if testy(ind,2)>0
        start = ind;
        break
    end
end

start_ms = testy(start,1);
stop_ms = testy(46058,1);

time = stop_ms - start_ms;

time = round(time/1000);
time = time/60;






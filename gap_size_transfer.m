%% read in gap size matrix into TRF files

clear all;
close all;
clc;

cd('C:\Users\zuse\OneDrive\Masterarbeit\Code')

%% load position matrices

load('C:\Users\zuse\OneDrive\Masterarbeit\Data\gap_sizes\position_matrix_1.mat');
load('C:\Users\zuse\OneDrive\Masterarbeit\Data\gap_sizes\position_matrix_2.mat');

%% convert values to strings

P_1 = string(P_1);
P_2 = string(P_2);

%% filenames

% nback_1:
filenames_1 = {
    'crossing_start_1_';
    'crossing_1_1_';
    'crossing_1_2_';
    'crossing_1_3_';
    'crossing_1_4_';
    'crossing_1_5_';
    'crossing_1_6_';
    'crossing_1_7_';
    'crossing_1_8_';
    'crossing_1_9_';
    'crossing_1_10_';
    'crossing_1_11_';
    'crossing_1_12_';
    'crossing_1_13_';
    'crossing_1_14_';
    'crossing_1_15_';
    'crossing_1_16_';
    'crossing_1_17_';
    'crossing_1_18_';
    'crossing_1_19_';
    'crossing_1_20_';
    'crossing_1_break_1_';
    'crossing_1_break_2_';
    'crossing_1_break_3_';
        };
    
% nback_2:
filenames_2 = {
    'crossing_start_2_';
    'crossing_2_1_';
    'crossing_2_2_';
    'crossing_2_3_';
    'crossing_2_4_';
    'crossing_2_5_';
    'crossing_2_6_';
    'crossing_2_7_';
    'crossing_2_8_';
    'crossing_2_9_';
    'crossing_2_10_';
    'crossing_2_11_';
    'crossing_2_12_';
    'crossing_2_13_';
    'crossing_2_14_';
    'crossing_2_15_';
    'crossing_2_16_';
    'crossing_2_17_';
    'crossing_2_18_';
    'crossing_2_19_';
    'crossing_2_20_';
    'crossing_2_break_1_';
    'crossing_2_break_2_';
    'crossing_2_break_3_';
        };
    
    
%% read in TRF files

cd('C:\Users\zuse\OneDrive\Masterarbeit\SILAB\pire_v5_1\modules\area2')

for nback = 1:2 % loop over nback level
    
    for f = 1:length(filenames_1) % loop over files
        
        content = {}; % cell to read in file line by line
        count = 1; % count lines to index in content
        position = 1; % count replaced positions to index in position matrix
        
        % access and open files of respective nback level:
        if nback == 1 
            fid = fopen([filenames_1{f},'TRF.cfg']);
        elseif nback == 2
            fid = fopen([filenames_2{f},'TRF.cfg']);
        end
        
        % read in line by line and store in content cell:
        tline = fgetl(fid);
        while ischar(tline)
            content{count} = tline;
            if strfind(content{count}, 'Position') % find any line with "Position" in it
                % change position by creating whole new line:
                if nback == 1
                    temp = char(strcat('Position = (',filenames_1{f},'instance.lc6.l129, ',P_1(f,position),');'));
                elseif nback == 2
                    temp = char(strcat('Position = (',filenames_2{f},'instance.lc6.l129, ',P_2(f,position),');'));
                end
                content{count} = temp; % replace line
                position = position + 1;
            end
            tline = fgetl(fid);
            count = count + 1;
        end
        
        fclose(fid); % close file
        
        % access and open files of respective nback level to write:
        if nback == 1
            filePh = fopen([filenames_1{f},'TRF.cfg'],'w');
        elseif nback == 2
            filePh = fopen([filenames_2{f},'TRF.cfg'],'w');
        end
        
        % write in lines from content cells:
        fprintf(filePh,'%s\n',content{:});
        fclose(filePh);
        
    end % end of files loop
    
end % end of nback loop


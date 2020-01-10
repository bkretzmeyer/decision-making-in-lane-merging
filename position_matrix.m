%% gap size matrix for scenarios

clear all;
close all;
clc;

slCharacterEncoding('UTF-8');

cd = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\';
PATHOUT = 'C:\Users\zuse\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\';

% cd = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\';
% PATHOUT = 'C:\Users\bened\OneDrive - FernUniversit?t Hagen\Masterarbeit_Data\gap_sizes\';

%% define gap sizes:
% 6 different gap sizes in total

a = 20;
b = 30;
c = 40;
d = 50;
e = 60;
f = 70;

% position of Truck:
truck = 360;

% position of first Car:
first = 340;

% position of second Car:
second = 320;


%% scatterplot search space for gap size combinations:

searchspace = figure;
scatter([c,d],[a,a],'k')
hold on;
scatter([b,c,d,e],[b,b,b,b],'k');
hold on;
scatter([a,b,c,d,e,f],[c,c,c,c,c,c],'k');
hold on;
scatter([a,b,c,d,e,f],[d,d,d,d,d,d],'k');
hold on;
scatter([b,c,d,e],[e,e,e,e],'k');
hold on;
scatter([c,d],[f,f],'k')
xlim([10,80]);
ylim([10,80]);

%% prepare gap size matrix with following properties:
% 24 scenarios per workload condition
% 7 gaps per scenario
% 24 x 5 gaps (first two gaps are always 20)
% 24 different gap size combinations
% all 24 appear in each column of the 24 x 5 matrix

% combinations:
% a:       c, d
% b:    b, c, d, e
% c: a, b, c, d, e, f
% d: a, b, c, d, e, f
% e:    b, c, d, e
% f:       c, d

%    2  4  6  6  4  2

% array for first gap:
g1 = [a,a,b,b,b,b,c,c,c,c,c,c,d,d,d,d,d,d,e,e,e,e,f,f];

% arrays for subseqent gap:
a2 = [c,d];
b2 = [b,c,d,e];
c2 = [a,b,c,d,e,f];
d2 = [a,b,c,d,e,f];
e2 = [b,c,d,e];
f2 = [c,d];


%% constrcuct gap size matrix:

for con = 1:4 % for self-driven and video condition and training
    
    for n = 1:2 % for both n_back levels
        
        % predefine gap size matrix
        G = zeros(24, 5);
        
        % first gap:
        G(:,1) = g1(randperm(length(g1)));
        
        % gaps 2 until 6:
        for ind1 = 2:size(G,2) % loop through gaps
            
            % support variables:
            
            % shuffling arrays for subsequent gaps
            temp_a2 = a2(randperm(length(a2)));
            temp_b2 = b2(randperm(length(b2)));
            temp_c2 = c2(randperm(length(c2)));
            temp_d2 = d2(randperm(length(d2)));
            temp_e2 = e2(randperm(length(e2)));
            temp_f2 = f2(randperm(length(f2)));
            
            % indices for shuffled arrays:
            ind_a2 = 1;
            ind_b2 = 1;
            ind_c2 = 1;
            ind_d2 = 1;
            ind_e2 = 1;
            ind_f2 = 1;
            
            for ind2 = 1:size(G,1) % loop through scenarios
                
                if G(ind2,ind1-1) == a
                    G(ind2,ind1) = temp_a2(ind_a2);
                    ind_a2 = ind_a2 + 1;
                elseif G(ind2,ind1-1) == b
                    G(ind2,ind1) = temp_b2(ind_b2);
                    ind_b2 = ind_b2 + 1;
                elseif G(ind2,ind1-1) == c
                    G(ind2,ind1) = temp_c2(ind_c2);
                    ind_c2 = ind_c2 + 1;
                elseif G(ind2,ind1-1) == d
                    G(ind2,ind1) = temp_d2(ind_d2);
                    ind_d2 = ind_d2 + 1;
                elseif G(ind2,ind1-1) == e
                    G(ind2,ind1) = temp_e2(ind_e2);
                    ind_e2 = ind_e2 + 1;
                elseif G(ind2,ind1-1) == f
                    G(ind2,ind1) = temp_f2(ind_f2);
                    ind_f2 = ind_f2 + 1;
                end
                
            end % end of scenario loop
            
        end % end of gap loop
        
        % store matrices for both n_back levels:
        if n == 1 && con == 1
            G_1 = G;
        elseif n == 2 && con == 2
            G_2 = G;
        elseif n == 1 && con == 2
            G_3 = G;
        elseif n == 2 && con == 2
            G_4 = G;
        elseif n == 1 && con == 3
            G_5 = G;
        elseif n == 2 && con == 3
            G_6 = G;
        elseif n == 1 && con == 4
            G_5 = G;
        elseif n == 2 && con == 4
            G_6 = G;
        end
        
    end % end of n_back loop
    
end % end of condition loop


%% use gap_size matrix to create position matrix

for con = 1:4 % for self-driven and video condition and training
    
    for n = 1:2 % for both n_back levels
        
        % adress correct gap_size matrix:
        if n == 1 && con == 1
            G = G_1;
        elseif n == 2 && con == 2
            G = G_2;
        elseif n == 1 && con == 2
            G = G_3;
        elseif n == 2 && con == 2
            G = G_4;
        elseif n == 1 && con == 3
            G = G_5;
        elseif n == 2 && con == 3
            G = G_6;
        elseif n == 1 && con == 4
            G = G_5;
        elseif n == 2 && con == 4
            G = G_6;
        end
        
        % predifine position matrix:
        P = zeros(24,8);
        
        % position of truck:
        P(:,1) = truck;
        
        % position of first car:
        P(:,2) = first;
        
        % position of second car:
        P(:,3) = second;
        
        % all other positions:
        for c = 4:size(P,2) % loop through positions of cars
            
            for s = 1:size(P,1) % loop through scenarios
                
                P(s,c) = P(s,c-1)-G(s,c-3);
                if P(s,c) < 0
                    warning("negative position")
                end
                
            end % end of scenario loop
            
        end % end of position loop
        
        % store positions for both n_back levels and save:
        if n == 1 && con == 1
            P_1 = P;
            save([PATHOUT,'position_matrix_self_1.mat'],'P_1')
        elseif n == 2 && con == 1
            P_2 = P;
            save([PATHOUT,'position_matrix_self_2.mat'],'P_2')
        elseif n == 1 && con == 2
            P_3 = P;
            save([PATHOUT,'position_matrix_video_1.mat'],'P_3')
        elseif n == 2 && con == 2
            P_4 = P;
            save([PATHOUT,'position_matrix_video_2.mat'],'P_4')
        elseif n == 1 && con == 3
            P_5 = P;
            save([PATHOUT,'position_matrix_training_1.mat'],'P_5')
        elseif n == 2 && con == 3
            P_6 = P;
            save([PATHOUT,'position_matrix_training_2.mat'],'P_6')
        elseif n == 1 && con == 4
            P_7 = P;
            save([PATHOUT,'position_matrix_training_video_1.mat'],'P_7')
        elseif n == 2 && con == 4
            P_8 = P;
            save([PATHOUT,'position_matrix_training_video_2.mat'],'P_8')
        end
        
    end % end of n_back loop
    
end % end of condition loop


        










%% gap size matrix for scenarios

clear all
close all
clc

%% define gap sizes:
% 6 different gap sizes in total

a = 20;
b = 30;
c = 40;
d = 50;
e = 60;
f = 70;


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
% 24 x 7 gaps
% 24 different gap size combinations
% all 24 appear in each column of the 24 x 7 matrix

% combinations:
% a:       c, d
% b:    b, c, d, e
% c: a, b, c, d, e, f
% d: a, b, c, d, e, f
% e:    b, c, d, e
% f:       c, d

%    2  4  6  6  4  2

% predefine gap size matrix:
G = zeros(24, 7); 

% array dor first gap:
g1 = [a,a,b,b,b,b,c,c,c,c,c,c,d,d,d,d,d,d,e,e,e,e,f,f];

% arrays for subseqent gap:
a2 = [c,d];
b2 = [b,c,d,e];
c2 = [a,b,c,d,e,f];
d2 = [a,b,c,d,e,f];
e2 = [b,c,d,e];
f2 = [c,d];


%% constrcuct gap size matrix:

% first gap:
G(:,1) = g1(randperm(length(g1)));

% gaps 2 until 7:

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
    end
    
end

% save('C:\Users\zuse\OneDrive\Masterarbeit\Data\gap_sizes\gap_size_matrix.mat','G')










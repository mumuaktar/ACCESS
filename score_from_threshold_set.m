% addpath(genpath("C:\mumu\data\all_patients\sensitivity analysis\poor_score"));
% addpath(genpath("C:\mumu\data\all_patients\sensitivity analysis\good_score"));
% addpath(genpath("C:\mumu\data\all_patients\sensitivity analysis\intermediate_score"));
% load('score_for_t5_g_nf.mat');
% t1=score_all;
% load('score_for_t5_i_nf.mat')
% t2=score_all;
clc;clear;
load('score_for_10.mat')
t3=score_all;

PATH='C:\mumu\data\all_patients\sensitivity analysis\scores';
for i=1:17
%     t=[t1(i,:)'; t2(i,:)'; t3(i,:)'];
      t=t3(i,:)';
    outputFileName = fullfile(PATH, ['score_10_' num2str(i) '.mat']);
    save(outputFileName,'t');
end


clear;
close all;
clc;
%(0) Load data:
 load('NATURE_women12.mat')
 load('elderly_subj_final.mat')
%% Hotellings T2 Paired and posthoc t-test paired with sidak correction for p-value
%LAPAFI (Right vs Left) 
%[results.LAPAFI.spm,results.LAPAFI.spmi,results.LAPAFI.spm_sidak,results.LAPAFI.spmi_sidak] = hotellingT2_posthoc_paired(elderly_subj_final,'Older Adult Women LAPAFI ');
%  
% %NATURE (Right vs Left)
% [spm_young,spmi_young,spm_sidak_young,spmi_sidak_young] = hotellingT2_posthoc_paired(NATURE_women12.young,'Young Women');
% [spm_adult,spmi_adult,spm_sidak_adult,spmi_sidak_adult] = hotellingT2_posthoc_paired(NATURE_women12.adult,'Adult Women ');
% [spm_olderAdult,spmi_olderAdult,spm_sidak_olderAdult,spmi_sidak_olderAdult] = hotellingT2_posthoc_paired(NATURE_women12.olderAdult,'Older Adult Women');
% 
% %% Hotellings T2 and posthoc t-test2 with sidak correction for p-value
% %NATURE vs NATURE (groups)
% [spm_young_adult,spmi_young_adult,spm_sidak_young_adult,spmi_sidak_young_adult] = hotellingT2_posthoc(NATURE_women12.young,NATURE_women12.adult,'Young vs Adult Women (NATURE)');
% [spm_young_olderAdult,spmi_young_olderAdult,spm_sidak_young_olderAdult,spmi_sidak_young_olderAdult] = hotellingT2_posthoc(NATURE_women12.young,NATURE_women12.olderAdult,'Young vs Older Adult Women (NATURE)');
% [spm_adult_olderAdult,spmi_adult_olderAdult,spm_sidak_adult_olderAdult,spmi_sidak_adult_olderAdult] = hotellingT2_posthoc(NATURE_women12.adult,NATURE_women12.olderAdult,'Adult vs Older Adult Women (NATURE)');
% 
% %LAPAFI vs NATURE 
% [spm_LAP_NAT_young,spmi_LAP_NAT_young,spm_sidak_LAP_NAT_young,spmi_sidak__LAP_NAT_young] = hotellingT2_posthoc(NATURE_women12.young,elderly_subj_final,'Young (NATURE) vs Older Adult (LAPAFI) Women');
% [spm_LAP_NAT_Adult,spmi_LAP_NAT_Adult,spm_sidak_LAP_NAT_Adult,spmi_sidak__LAP_NAT_Adult] = hotellingT2_posthoc(NATURE_women12.adult,elderly_subj_final,'Adult(NATURE) vs Older Adult(LAPAFI) Women');
% [spm_LAP_NAT_olderAdult,spmi_LAP_NAT_olderAdult,spm_sidak__LAP_NAT_olderAdult,spmi_sidak_LAP_NAT_olderAdult] = hotellingT2_posthoc(NATURE_women12.olderAdult,elderly_subj_final,'Older Adult(NATURE) vs Older Adult(LAPAFI) Women');

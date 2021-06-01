clear;
close all;
clc;
%(0) Load data:
 load('GAITREC_women12.mat')
 load('elderly_subj_final.mat')

%% Hotellings T2 Paired and posthoc t-test paired with sidak correction for p-value
%GAITREC (Right vs Left)
[results.GAITREC.spm.young,results.GAITREC.spmi.young,results.GAITREC.spm_sidak.young,results.GAITREC.spmi_sidak.young] = hotellingT2_posthoc_paired(GAITREC_women12.young,'Young Women (Right vs Left)','Right','SD Right','Left','SD Left');
[results.GAITREC.spm.adult,results.GAITREC.spmi.adult,results.GAITREC.spm_sidak.adult,results.GAITREC.spmi_sidak.adult] = hotellingT2_posthoc_paired(GAITREC_women12.adult,'Adult Women (Right vs Left)','Right','SD Right','Left','SD Left');
[results.GAITREC.spm.olderAdult,results.GAITREC.spmi.olderAdult,results.GAITREC.spm_sidak.olderAdult,results.GAITREC.spmi_sidak.olderAdult] = hotellingT2_posthoc_paired(GAITREC_women12.olderAdult,'Older Adult Women (Right vs Left)','Right','SD Right','Left','SD Left');

%% Hotellings T2 and posthoc t-test2 with sidak correction for p-value
%GAITREC vs GAITREC (groups)
[results.GAITREC.spm.young_adult,results.GAITREC.spmi.young_adult,results.GAITREC.spm_sidak.young_adult,results.GAITREC.spmi_sidak.young_adult] = hotellingT2_posthoc(GAITREC_women12.young,GAITREC_women12.adult,'Young vs Adult Women (GAITREC)','young','SD young','adult','SD adult');
[results.GAITREC.spm.young_olderAdult,results.GAITREC.spmi.young_olderAdult,results.GAITREC.spm_sidak.young_olderAdult,results.GAITREC.spmi_sidak.young_olderAdult] = hotellingT2_posthoc(GAITREC_women12.young,GAITREC_women12.olderAdult,'Young vs Older Adult Women (GAITREC)','young','SD young','olderAdult','SD olderAdult');
[results.GAITREC.spm.adult_olderAdult,results.GAITREC.spmi.adult_olderAdult,results.GAITREC.spm_sidak.adult_olderAdult,results.GAITREC.spmi_sidak.adult_olderAdult] = hotellingT2_posthoc(GAITREC_women12.adult,GAITREC_women12.olderAdult,'Adult vs Older Adult Women (GAITREC)','adult','SD adult','olderAdult','SD olderAdult');

%LAPAFI vs GAITREC 
[results.LAPAFI_GAITREC.spm.young,results.LAPAFI_GAITREC.spmi.young,results.LAPAFI_GAITREC.spm_sidak.young,results.LAPAFI_GAITREC.spmi_sidak.young] = hotellingT2_posthoc(GAITREC_women12.young,elderly_subj_final,'Young (GAITREC) vs Older Adult (LAPAFI) Women','GaitRec','SD GaitRec','LAPAFI','SD LAPAFI');
[results.LAPAFI_GAITREC.spm.Adult,results.LAPAFI_GAITREC.spmi.Adult,results.LAPAFI_GAITREC.spm_sidak.Adult,results.LAPAFI_GAITREC.spmi_sidak.Adult] = hotellingT2_posthoc(GAITREC_women12.adult,elderly_subj_final,'Adult (GAITREC) vs Older Adult (LAPAFI) Women','GaitRec','SD GaitRec','LAPAFI','SD LAPAFI');
[results.LAPAFI_GAITREC.spm.olderAdult,results.LAPAFI_GAITREC.spmi.olderAdult,results.LAPAFI_GAITREC.spm_sidak.olderAdult,results.LAPAFI_GAITREC.spmi_sidak.olderAdult] = hotellingT2_posthoc(GAITREC_women12.olderAdult,elderly_subj_final,'Older Adult (GAITREC) vs Older Adult (LAPAFI) Women','GaitRec','SD GaitRec','LAPAFI','SD LAPAFI');

%%tabelas e results.spm organizar em estruturas
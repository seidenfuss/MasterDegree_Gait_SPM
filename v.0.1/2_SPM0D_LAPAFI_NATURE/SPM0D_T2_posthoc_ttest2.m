%DO SPM 0D
%compare impulses and peaks using traditional statistical models
%load file containing the 0D data: peaks and impulses

%(1) second peak anterior posterior  force (discrete_GRF.max_AP_R)
%(2) first peak vertical force (discrete_GRF.peak1_V_R)
%(3) first peak lateral force (discrete_GRF.peak1_ML_R)

clear;  clc

%(0) Load dataset:

load('discrete_GRF_NATURE.mat')
load('discrete_GRF_LAPAFI.mat');

[results.NATURE.spm.young_adult,results.NATURE.spmi.young_adult,results.NATURE.spm_sidak.young_adult,results.NATURE.spmi_sidak.young_adult]=hotellingT2_posthoc0D(discrete_GRF_NATURE.young,discrete_GRF_NATURE.adult);
[results.NATURE.spm.young_olderAdult,results.NATURE.spmi.young_olderAdult,results.NATURE.spm_sidak.young_olderAdult,results.NATURE.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_NATURE.young,discrete_GRF_NATURE.olderAdult);
[results.NATURE.spm.adult_olderAdult,results.NATURE.spmi.adult_olderAdult,results.NATURE.spm_sidak.adult_olderAdult,results.NATURE.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_NATURE.adult,discrete_GRF_NATURE.olderAdult);

[results.LAPAFI.spm.young_olderAdult,results.LAPAFI.spmi.young_olderAdult,results.LAPAFI.spm_sidak.young_olderAdult,results.LAPAFI.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_NATURE.young);
[results.LAPAFI.spm.adult_olderAdult,results.LAPAFI.spmi.adult_olderAdult,results.LAPAFI.spm_sidak.adult_olderAdult,results.LAPAFI.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_NATURE.adult);
[results.LAPAFI.spm.olderAdult_olderAdult,results.LAPAFI.spmi.olderAdult_olderAdult,results.LAPAFI.spm_sidak.olderAdult_olderAdult,results.LAPAFI.spmi_sidak.olderAdult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_NATURE.olderAdult);

%% create a table to compare results

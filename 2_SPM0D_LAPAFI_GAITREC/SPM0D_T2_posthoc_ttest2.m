%DO SPM 0D
%compare impulses and peaks using traditional statistical models
%load file containing the 0D data: peaks and impulses

%(1) first peak anterior posterior  force (discrete_GRF.min_AP_R)
%(2) first peak vertical force (discrete_GRF.peak1_V_R)
%(3) first peak lateral force (discrete_GRF.peak1_ML_R)

clear;  clc

%(0) Load dataset:

load('discrete_GRF_GAITREC.mat')
load('discrete_GRF_LAPAFI.mat');

[results.GAITREC.spm.young_adult,results.GAITREC.spmi.young_adult,results.GAITREC.spm_sidak.young_adult,results.GAITREC.spmi_sidak.young_adult]=hotellingT2_posthoc0D(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.adult);
[results.GAITREC.spm.young_olderAdult,results.GAITREC.spmi.young_olderAdult,results.GAITREC.spm_sidak.young_olderAdult,results.GAITREC.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.olderAdult);
[results.GAITREC.spm.adult_olderAdult,results.GAITREC.spmi.adult_olderAdult,results.GAITREC.spm_sidak.adult_olderAdult,results.GAITREC.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_GAITREC.adult,discrete_GRF_GAITREC.olderAdult);

[results.LAPAFI.spm.young_olderAdult,results.LAPAFI.spmi.young_olderAdult,results.LAPAFI.spm_sidak.young_olderAdult,results.LAPAFI.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.young);
[results.LAPAFI.spm.adult_olderAdult,results.LAPAFI.spmi.adult_olderAdult,results.LAPAFI.spm_sidak.adult_olderAdult,results.LAPAFI.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.adult);
[results.LAPAFI.spm.olderAdult_olderAdult,results.LAPAFI.spmi.olderAdult_olderAdult,results.LAPAFI.spm_sidak.olderAdult_olderAdult,results.LAPAFI.spmi_sidak.olderAdult_olderAdult]=hotellingT2_posthoc0D(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.olderAdult);

%% create a table to compare results


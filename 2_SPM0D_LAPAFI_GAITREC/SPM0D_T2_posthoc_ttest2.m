%DO SPM 0D
%compare impulses and peaks using traditional statistical models
%load file containing the 0D data: peaks and impulses

clear;  clc; close all;

%(0) Load dataset:

load('discrete_GRF_GAITREC.mat')
load('discrete_GRF_LAPAFI.mat');

% SPM 0D peak (first)
[results.peak.GAITREC.spm.young_adult,results.peak.GAITREC.spmi.young_adult,results.peak.GAITREC.spm_sidak.young_adult,results.peak.GAITREC.spmi_sidak.young_adult]=hotellingT2_posthoc0D_peak(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.adult);
[results.peak.GAITREC.spm.young_olderAdult,results.peak.GAITREC.spmi.young_olderAdult,results.peak.GAITREC.spm_sidak.young_olderAdult,results.peak.GAITREC.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D_peak(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.olderAdult);
[results.peak.GAITREC.spm.adult_olderAdult,results.peak.GAITREC.spmi.adult_olderAdult,results.peak.GAITREC.spm_sidak.adult_olderAdult,results.peak.GAITREC.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D_peak(discrete_GRF_GAITREC.adult,discrete_GRF_GAITREC.olderAdult);

[results.peak.LAPAFI.spm.young_olderAdult,results.peak.LAPAFI.spmi.young_olderAdult,results.peak.LAPAFI.spm_sidak.young_olderAdult,results.peak.LAPAFI.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D_peak(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.young);
[results.peak.LAPAFI.spm.adult_olderAdult,results.peak.LAPAFI.spmi.adult_olderAdult,results.peak.LAPAFI.spm_sidak.adult_olderAdult,results.peak.LAPAFI.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D_peak(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.adult);
[results.peak.LAPAFI.spm.olderAdult_olderAdult,results.peak.LAPAFI.spmi.olderAdult_olderAdult,results.peak.LAPAFI.spm_sidak.olderAdult_olderAdult,results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult]=hotellingT2_posthoc0D_peak(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.olderAdult);

%SPM 0D impulse (total) 

[results.impulse.GAITREC.spm.young_adult,results.impulse.GAITREC.spmi.young_adult,results.impulse.GAITREC.spm_sidak.young_adult,results.impulse.GAITREC.spmi_sidak.young_adult]=hotellingT2_posthoc0D_impulse(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.adult);
[results.impulse.GAITREC.spm.young_olderAdult,results.impulse.GAITREC.spmi.young_olderAdult,results.impulse.GAITREC.spm_sidak.young_olderAdult,results.impulse.GAITREC.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D_impulse(discrete_GRF_GAITREC.young,discrete_GRF_GAITREC.olderAdult);
[results.impulse.GAITREC.spm.adult_olderAdult,results.impulse.GAITREC.spmi.adult_olderAdult,results.impulse.GAITREC.spm_sidak.adult_olderAdult,results.impulse.GAITREC.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D_impulse(discrete_GRF_GAITREC.adult,discrete_GRF_GAITREC.olderAdult);

[results.impulse.LAPAFI.spm.young_olderAdult,results.impulse.LAPAFI.spmi.young_olderAdult,results.impulse.LAPAFI.spm_sidak.young_olderAdult,results.impulse.LAPAFI.spmi_sidak.young_olderAdult]=hotellingT2_posthoc0D_impulse(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.young);
[results.impulse.LAPAFI.spm.adult_olderAdult,results.impulse.LAPAFI.spmi.adult_olderAdult,results.impulse.LAPAFI.spm_sidak.adult_olderAdult,results.impulse.LAPAFI.spmi_sidak.adult_olderAdult]=hotellingT2_posthoc0D_impulse(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.adult);
[results.impulse.LAPAFI.spm.olderAdult_olderAdult,results.impulse.LAPAFI.spmi.olderAdult_olderAdult,results.impulse.LAPAFI.spm_sidak.olderAdult_olderAdult,results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult]=hotellingT2_posthoc0D_impulse(discrete_GRF_LAPAFI,discrete_GRF_GAITREC.olderAdult);


%% create a table to compare results

%table or color map - decide

%rows: conditions: peak_Lapafi_gaitrecyoung ... impulse_Lapafi_gaitrec

%col: 







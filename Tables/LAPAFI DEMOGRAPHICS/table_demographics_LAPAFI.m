clear; close all; clc;
load('elderly_subj_final.mat')


for i = 1:length(elderly_subj_final)
S(i).ID=elderly_subj_final(i).ID;
S(i).DOB=elderly_subj_final(i).DOB;
S(i).DOE=elderly_subj_final(i).DOE;
S(i).AGE_calculated=elderly_subj_final(i).AGE_calc;
S(i).AGE_informed=elderly_subj_final(i).AGE_infor;
S(i).MASS_measured=elderly_subj_final(i).MASS_kg;
S(i).HEIGHT_m=elderly_subj_final(i).HEIGHT_m;
S(i).WEIGHT_N=elderly_subj_final(i).WEIGHT_N;
S(i).MASS_calculated=elderly_subj_final(i).MASS_measured_kg;
end

T_dg = struct2table(S);


%% MEAN_SD

A=table2array(T_dg(:,4:end));

stat.N=length(A);
stat.mean_age_calc=nanmean(A(:,1));
stat.sd__age_calc=nanstd(A(:,1));
stat.mean_age_infor=nanmean(A(:,2));
stat.sd_age_infor=nanstd(A(:,2));
stat.mean_mass_meas=nanmean(A(:,3));
stat.sd_mass_meas=nanstd(A(:,3));
stat.mean_height_meas=nanmean(A(:,4));
stat.sd_height_meas=nanstd(A(:,4));
stat.mean_weight_calc=nanmean(A(:,5));
stat.sd_weight_calc=nanstd(A(:,5));
stat.mean_mass_calc=nanmean(A(:,6));
stat.sd_mass_calc=nanstd(A(:,6));

[stat.h_age_calc,stat.p_age_calc]=ttest(A(:,1));
[stat.h_age_inform,stat.p_age_inform]=ttest(A(:,2));
[stat.h_mass_meas,stat.p_mass_meas]=ttest(A(:,3));
[stat.h_height_meas,stat.p_height_meas]=ttest(A(:,4));
[stat.h_weight_meas,stat.p_weight_meas]=ttest(A(:,5));
[stat.h_mass_calc,stat.p_mass_calc]=ttest(A(:,6));


T_stat=struct2table(stat);

% export csv

writetable(T_dg,'T_demographics_LAPAFI.csv','Delimiter','comma');
type 'T_demographics_LAPAFI.csv';

writetable(T_stat,'T_stat_LAPAFI.csv','Delimiter','comma');
type 'T_stat_LAPAFI.csv';



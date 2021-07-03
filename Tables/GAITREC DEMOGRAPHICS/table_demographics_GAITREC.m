clear; close all; clc;
load('GAITREC_women12.mat')

for i = 1:length(GAITREC_women12.olderAdult)
S(i).ID=GAITREC_women12.olderAdult(i).ID;
S(i).AGE=GAITREC_women12.olderAdult(i).AGE;
S(i).WEIGHT=GAITREC_women12.olderAdult(i).BODY_WEIGHT;
S(i).MASS=GAITREC_women12.olderAdult(i).BODY_MASS;
S(i).HEIGHT=GAITREC_women12.olderAdult(i).HEIGHT;
end

T_dg = struct2table(S);


%% MEAN_SD

A=table2array(T_dg(:,2:end));

stat.N=length(A);
stat.mean_age_calc=nanmean(A(:,1));
stat.sd__age_calc=nanstd(A(:,1));

stat.mean_mass=nanmean(A(:,3));
stat.sd_mass=nanstd(A(:,3));

stat.mean_weight=nanmean(A(:,2));
stat.sd_weight=nanstd(A(:,2));

stat.mean_height_meas=nanmean(A(:,4));
stat.sd_height_meas=nanstd(A(:,4));

[stat.h_age,stat.p_age]=ttest(A(:,1));
[stat.h_mass,stat.p_mass]=ttest(A(:,3));
[stat.h_height,stat.p_height]=ttest(A(:,4));
[stat.h_weight,stat.p_weight]=ttest(A(:,2));


T_stat=struct2table(stat);
% export csv

writetable(T_dg,'T_demographics_GAITREC_olderAdult.csv','Delimiter','comma');
type 'T_demographics_GAITREC_olderAdult.csv';

writetable(T_stat,'T_stat_GAITREC_olderAdult.csv','Delimiter','comma');
type 'T_stat_GAITREC_olderAdult.csv';



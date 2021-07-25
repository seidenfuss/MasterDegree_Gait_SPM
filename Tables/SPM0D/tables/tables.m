clear;  clc; close all;

load('discrete_GRF_GAITREC.mat');
load('discrete_GRF_LAPAFI.mat');


data1=discrete_GRF_LAPAFI;
data2=discrete_GRF_GAITREC.young;
data3=discrete_GRF_GAITREC.adult;
data4=discrete_GRF_GAITREC.olderAdult;

 dim=size(data1,2);
 
 [lapafi_peak, lapafi_impulse] = getPeaks(data1);
 [young_peak, young_impulse] = getPeaks(data2);
 [adult_peak, adult_impulse] = getPeaks(data3);
 [olderadult_peak, olderadult_impulse] = getPeaks(data4);
 
 for d = 1:3
 stat.mean_peaks_lapafi(d,1)=mean(lapafi_peak(:,d));
 stat.SD_peaks_lapafi(d,1)=std(lapafi_peak(:,d));
 
 stat.mean_peaks_young(d,1)=mean(young_peak(:,d));
 stat.SD_peaks_young(d,1)=std(young_peak(:,d));
 
 stat.mean_peaks_adult(d,1)=mean(adult_peak(:,d));
 stat.SD_peaks_adult(d,1)=std(adult_peak(:,d));
 
 stat.mean_peaks_olderadult(d,1)=mean(olderadult_peak(:,d));
 stat.SD_peaks_olderadult(d,1)=std(olderadult_peak(:,d));
 end
 
 T_peaks=struct2table(stat);
 
 
  for d = 1:3
 stat2.mean_impulse_lapafi(d,1)=mean(lapafi_impulse(:,d));
 stat2.SD_impulse_lapafi(d,1)=std(lapafi_impulse(:,d));
 
 stat2.mean_impulse_young(d,1)=mean(young_impulse(:,d));
 stat2.SD_impulse_young(d,1)=std(young_impulse(:,d));
 
 stat2.mean_impulse_adult(d,1)=mean(adult_impulse(:,d));
 stat2.SD_impulse_adult(d,1)=std(adult_impulse(:,d));
 
 stat2.mean_impulse_olderadult(d,1)=mean(olderadult_impulse(:,d));
 stat2.SD_impulse_olderadult(d,1)=std(olderadult_impulse(:,d));
 end
 
 T_impulse=struct2table(stat2);
 
writetable(T_peaks,'T_peaks.csv','Delimiter','comma');
type 'T_peaks.csv';
 
writetable(T_impulse,'T_impulse.csv','Delimiter','comma');
type 'T_impulse.csv';
 



% %tabela_1_hotellings
% %peaks
% 
% stat(1).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.h0reject;
% stat(1).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.h0reject;
% stat(1).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.h0reject;
% stat(1).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.h0reject;
% 
% stat(2).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.z;
% stat(2).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.z;
% stat(2).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.z;
% stat(2).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.z;
% 
% stat(3).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.p;
% stat(3).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.p;
% stat(3).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.p;
% stat(3).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.p;
% 
% 
% STATS_peak_HT2 =struct2table(stat);
% writetable(STATS_peak_HT2,'T_peak_HT2.csv','Delimiter','comma');
% type 'T_peak_HT2.csv';
% 
% 
% 
% 
% % %tabela_1_hotellings
% % %impulses
% 
% stat(1).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.h0reject;
% stat(1).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.h0reject;
% stat(1).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.h0reject;
% stat(1).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.h0reject;
% 
% stat(2).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.z;
% stat(2).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.z;
% stat(2).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.z;
% stat(2).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.z;
% 
% stat(3).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.p;
% stat(3).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.p;
% stat(3).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.p;
% stat(3).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.p;
% 
% 
% STATS_impulse_HT2 =struct2table(stat);
% writetable(STATS_impulse_HT2,'T_impulse_HT2.csv','Delimiter','comma');
% type 'T_impulse_HT2.csv';

 


% %tabela_1_hotellings
% %peaks
% 
% stat(1).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.h0reject;
% stat(1).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.h0reject;
% stat(1).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.h0reject;
% stat(1).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.h0reject;
% 
% stat(2).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.z;
% stat(2).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.z;
% stat(2).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.z;
% stat(2).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.z;
% 
% stat(3).GAITRECyoung_adult=results.peak.GAITREC.spmi.young_adult.p;
% stat(3).GAITRECyoung_olderadult=results.peak.GAITREC.spmi.young_olderAdult.p;
% stat(3).GAITRECadult_olderadult=results.peak.GAITREC.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_young=results.peak.LAPAFI.spmi.young_olderAdult.p;
% stat(3).LAPAFI_adult=results.peak.LAPAFI.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_olderadult=results.peak.LAPAFI.spmi.olderAdult_olderAdult.p;
% 
% 
% STATS_peak_HT2 =struct2table(stat);
% writetable(STATS_peak_HT2,'T_peak_HT2.csv','Delimiter','comma');
% type 'T_peak_HT2.csv';



% 
% % %tabela_1_hotellings
% % %impulses
% 
% stat(1).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.h0reject;
% stat(1).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.h0reject;
% stat(1).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.h0reject;
% stat(1).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.h0reject;
% stat(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.h0reject;
% 
% stat(2).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.z;
% stat(2).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.z;
% stat(2).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.z;
% stat(2).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.z;
% stat(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.z;
% 
% stat(3).GAITRECyoung_adult=results.impulse.GAITREC.spmi.young_adult.p;
% stat(3).GAITRECyoung_olderadult=results.impulse.GAITREC.spmi.young_olderAdult.p;
% stat(3).GAITRECadult_olderadult=results.impulse.GAITREC.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_young=results.impulse.LAPAFI.spmi.young_olderAdult.p;
% stat(3).LAPAFI_adult=results.impulse.LAPAFI.spmi.adult_olderAdult.p;
% stat(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi.olderAdult_olderAdult.p;
% 
% 
% STATS_impulse_HT2 =struct2table(stat);
% writetable(STATS_impulse_HT2,'T_impulse_HT2.csv','Delimiter','comma');
% type 'T_impulse_HT2.csv';





% %tabela_2_post_hoc
% % 
% %AP
% stat_AP(1).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 1).z;
% stat_AP(1).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).z;
% stat_AP(1).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).z;
% 
% stat_AP(2).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 1).p;
% stat_AP(2).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).p;
% stat_AP(2).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).p;
% 
% stat_AP(3).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 1).h0reject;
% stat_AP(3).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).h0reject;
% stat_AP(3).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).h0reject;
% %V
% stat_V(1).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 2).z;
% stat_V(1).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).z;
% stat_V(1).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).z;
% 
% stat_V(2).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 2).p;
% stat_V(2).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).p;
% stat_V(2).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).p;
% 
% stat_V(3).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 2).h0reject;
% stat_V(3).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).h0reject;
% stat_V(3).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).h0reject;
% %ML
% stat_ML(1).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 3).z;
% stat_ML(1).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).z;
% stat_ML(1).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).z;
% 
% stat_ML(2).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 3).p;
% stat_ML(2).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).p;
% stat_ML(2).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).p;
% 
% stat_ML(3).LAPAFI_young=results.peak.LAPAFI.spmi_sidak.young_olderAdult(1, 3).h0reject;
% stat_ML(3).LAPAFI_adult=results.peak.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).h0reject;
% stat_ML(3).LAPAFI_olderadult=results.peak.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).h0reject;
% 
% STATS_AP =struct2table(stat_AP);
% STATS_V =struct2table(stat_V);
% STATS_ML =struct2table(stat_ML);
% 
% writetable(STATS_AP,'AP_peak.csv','Delimiter','comma');
% type 'AP_peak.csv';
% 
% writetable(STATS_V,'V_peak.csv','Delimiter','comma');
% type 'V_peak.csv';
% 
% writetable(STATS_ML,'ML_peak.csv','Delimiter','comma');
% type 'ML_peak.csv';

% % 
% %AP
% stat_AP(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).z;
% stat_AP(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).z;
% stat_AP(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).z;
% 
% stat_AP(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).p;
% stat_AP(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).p;
% stat_AP(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).p;
% 
% stat_AP(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).h0reject;
% stat_AP(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).h0reject;
% stat_AP(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).h0reject;
% 
% %V
% stat_V(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).z;
% stat_V(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).z;
% stat_V(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).z;
% 
% stat_V(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).p;
% stat_V(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).p;
% stat_V(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).p;
% 
% stat_V(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).h0reject;
% stat_V(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).h0reject;
% stat_V(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).h0reject;
% 
% %ML
% stat_ML(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).z;
% stat_ML(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).z;
% stat_ML(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).z;
% 
% stat_ML(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).p;
% stat_ML(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).p;
% stat_ML(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).p;
% 
% stat_ML(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).h0reject;
% stat_ML(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).h0reject;
% stat_ML(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).h0reject;
% 
% STATS_AP =struct2table(stat_AP);
% STATS_V =struct2table(stat_V);
% STATS_ML =struct2table(stat_ML);
% 
% writetable(STATS_AP,'AP_impulse.csv','Delimiter','comma');
% type 'AP_impulse.csv';
% 
% writetable(STATS_V,'V_impulse.csv','Delimiter','comma');
% type 'V_impulse.csv';
% 
% writetable(STATS_ML,'ML_impulse.csv','Delimiter','comma');
% type 'ML_impulse.csv';
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

% 
%AP
stat_AP(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).z;
stat_AP(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).z;
stat_AP(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).z;

stat_AP(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).p;
stat_AP(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).p;
stat_AP(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).p;

stat_AP(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 1).h0reject;
stat_AP(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 1).h0reject;
stat_AP(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 1).h0reject;

%V
stat_V(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).z;
stat_V(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).z;
stat_V(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).z;

stat_V(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).p;
stat_V(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).p;
stat_V(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).p;

stat_V(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 2).h0reject;
stat_V(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 2).h0reject;
stat_V(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 2).h0reject;

%ML
stat_ML(1).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).z;
stat_ML(1).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).z;
stat_ML(1).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).z;

stat_ML(2).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).p;
stat_ML(2).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).p;
stat_ML(2).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).p;

stat_ML(3).LAPAFI_young=results.impulse.LAPAFI.spmi_sidak.young_olderAdult(1, 3).h0reject;
stat_ML(3).LAPAFI_adult=results.impulse.LAPAFI.spmi_sidak.adult_olderAdult(1, 3).h0reject;
stat_ML(3).LAPAFI_olderadult=results.impulse.LAPAFI.spmi_sidak.olderAdult_olderAdult(1, 3).h0reject;

STATS_AP =struct2table(stat_AP);
STATS_V =struct2table(stat_V);
STATS_ML =struct2table(stat_ML);

writetable(STATS_AP,'AP_impulse.csv','Delimiter','comma');
type 'AP_impulse.csv';

writetable(STATS_V,'V_impulse.csv','Delimiter','comma');
type 'V_impulse.csv';

writetable(STATS_ML,'ML_impulse.csv','Delimiter','comma');
type 'ML_impulse.csv';


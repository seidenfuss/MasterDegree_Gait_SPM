
close all; clear; clc;

load('elderly_subj_final.mat');
load('GAITREC_women12.mat');

[discrete_GRF_LAPAFI] = peaks_impulsesFun(elderly_subj_final,'LAPAFI');
[discrete_GRF_GAITREC.young] = peaks_impulsesFun(GAITREC_women12.young,'GAITREC young');
[discrete_GRF_GAITREC.adult] = peaks_impulsesFun(GAITREC_women12.adult,'GAITREC adult');
[discrete_GRF_GAITREC.olderAdult] = peaks_impulsesFun(GAITREC_women12.olderAdult,'GAITREC olderAdult');
 
%save discrete_GRF as an external file
save(('discrete_GRF_LAPAFI.mat'),'discrete_GRF_LAPAFI')
save(('discrete_GRF_GAITREC.mat'),'discrete_GRF_GAITREC')

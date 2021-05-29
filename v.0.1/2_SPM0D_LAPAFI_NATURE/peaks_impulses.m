
close all; clear; clc;

load('elderly_subj_final.mat');
load('NATURE_women12.mat');

[discrete_GRF_LAPAFI] = peaks_impulsesFun(elderly_subj_final,'LAPAFI','LAPAFI');
[discrete_GRF_NATURE.young] = peaks_impulsesFun(NATURE_women12.young,'NATURE young','NATURE_young');
[discrete_GRF_NATURE.adult] = peaks_impulsesFun(NATURE_women12.adult,'NATURE adult','NATURE_adult');
[discrete_GRF_NATURE.olderAdult] = peaks_impulsesFun(NATURE_women12.olderAdult,'NATURE olderAdult','NATURE_olderAdult');
 
%save discrete_GRF as an external file
save(('discrete_GRF_LAPAFI.mat'),'discrete_GRF_LAPAFI')
save(('discrete_GRF_NATURE.mat'),'discrete_GRF_NATURE')

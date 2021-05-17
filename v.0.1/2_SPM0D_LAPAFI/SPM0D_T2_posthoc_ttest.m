%DO SPM 0D
%compare impulses and peaks using traditional statistical models
%load file containing the 0D data: peaks and impulses

%(1) second peak anterior posterior  force (discrete_GRF.max_AP_R)
%(2) first peak vertical force (discrete_GRF.peak1_V_R)
%(3) first peak lateral force (discrete_GRF.peak1_ML_R)

clear;  clc


%(0) Load dataset:

load('discrete_GRF.mat')
dim=size(discrete_GRF,2);

for i=1:dim
yA(i,1)=discrete_GRF(i).max_AP_R;
yA(i,2)=discrete_GRF(i).peak1_V_R;
yA(i,3)=discrete_GRF(i).peak1_ML_R;

yB(i,1)=discrete_GRF(i).max_AP_L;
yB(i,2)=discrete_GRF(i).peak1_V_L;
yB(i,3)=discrete_GRF(i).peak1_ML_L;
end


%(1) Conduct test using spm1d:

spm  = spm1d.stats.hotellings_paired(yA, yB);
spmi = spm.inference(0.05);
disp(spmi)


%sidak correction ttest - paired

% Conduct post hoc test using spm1d:
spm_AP  = spm1d.stats.ttest_paired(yA(:,1), yB(:,1));
spm_V  = spm1d.stats.ttest_paired(yA(:,2), yB(:,2));
spm_ML  = spm1d.stats.ttest_paired(yA(:,3), yB(:,3));
p_sidak=0.0170;

spmi_AP = spm_AP.inference(p_sidak, 'two_tailed', true);
spmi_V = spm_V.inference(p_sidak, 'two_tailed', true);
spmi_ML = spm_ML.inference(p_sidak, 'two_tailed', true);

disp(spmi_AP)
disp(spmi_V)
disp(spmi_ML)

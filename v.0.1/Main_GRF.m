%Loading, filtering, and datinterp algorithms wrotten by Marcus Fraga Vieira: co-advisor. 
%Translated and modified by Ana Maria Bender Seidenfuss das Neves.
%Introducing batch (many folders and multiple files) importing and
%Pre-Processing (Ana Maria, Rafael and Marcus) and Statistical Parametric Mapping (Todd Pataky, Friston, et al.)
%Correlation_filter to keep good quality curves for further analysis;

close all; clear; clc;
disp('Starting GRF...')

%% Loading GRF Data % give the name you think better describes your group of repetitions
Diretory_GRF_elderly = './idosos_GRF/';
[Data_GRF_Elderly, Fs]=importSubfolderFiles(Diretory_GRF_elderly);

%% Loading Metadata - date of birth, date of examination, age, weight, mass
load('elderly_metadata.mat')

%% Calculating Weight (N) using one static test
Dim=size(Data_GRF_Elderly);
Weight = zeros(Dim(1,1),1);
Mass_kg = zeros(Dim(1,1),1);

for i=1:Dim(1,1)
    Weight(i,1)=mean(Data_GRF_Elderly{i,1}(1:end-2,3) + Data_GRF_Elderly{i,1}(1:end-2,6)); 
    Mass_kg(i,1)=Weight(i,1)/9.81;  
end
  
%adding into metadata structure: weight and mass estimated from static test;
for i=1:Dim(1,1)
elderly_metadata(i).WEIGHT_N=Weight(i,1);
elderly_metadata(i).MASS_measured_kg=Mass_kg(i,1);
end

%% Get stance EVENTS for each foot.
isnan_R={[]}; events_R={[]}; n_steps_R={[]}; %right
isnan_L={[]}; events_L={[]}; n_steps_L={[]}; %left
for i=1:Dim(1,1)
    [isnan_R{i,1}, events_R{i,1}, events_R{i,2}, n_steps_R{i,1}] = getEvents(Data_GRF_Elderly{i,2}(:,3));
    [isnan_L{i,1}, events_L{i,1}, events_L{i,2}, n_steps_L{i,1}] = getEvents(Data_GRF_Elderly{i,2}(:,6));
end
plotTrials(Dim,3,3,'b',Data_GRF_Elderly,'GRF Vertical ','Time samples (ms)','GRF_V (N)',' - Trials: ',' - Right foot');
plotTrials(Dim,6,3,'r',Data_GRF_Elderly,'GRF Vertical ','Time samples (ms)','GRF_V (N)',' - Trials: ',' - Left foot');

%% Segment: using stance events;
elderly_grf_R = segmentCurves(Data_GRF_Elderly,n_steps_R,events_R,2,3,4);
elderly_grf_L = segmentCurves(Data_GRF_Elderly,n_steps_L,events_L,5,6,7);

%% Prepare data: divide by bodyweight, delete (too short curves), downsample, filter and interpolate;
Fc=20;
prepared_curves_R=prepDataCurves(Dim(1,1),n_steps_R,elderly_grf_R,Weight,Fs,Fc);
prepared_curves_L=prepDataCurves(Dim(1,1),n_steps_L,elderly_grf_L,Weight,Fs,Fc);

%% assigning data for correlation calculations
[grf_R_w,grf_L_w]=prepDataCorr(Dim,prepared_curves_R,prepared_curves_L);

%% plot before correlation calculations:
plotStance(Dim,2,'b',grf_R_w,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot", " - Before CorrFilter");
plotStance(Dim,2,'r',grf_L_w,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot", " - Before CorrFilter");

%% correlation Filter
[output_subj_R,rep_n_R] = repeatCorrFilter(Dim(1,1),grf_R_w,0.97);
[output_subj_L,rep_n_L] = repeatCorrFilter(Dim(1,1),grf_L_w,0.97);
plotStance(Dim,3,'b',output_subj_R,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot"," - After CorrFilter");
plotStance(Dim,3,'r',output_subj_L,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot", " - After CorrFilter");

%% Export Data for SPM
    % Metadata + Force Peaks etc...
% and will add more info as it goes, such:  number of steps, force peaks, speed(calculate using formula from keller v=(peak_F_Vert - 0.159)/0.634), time to force peak (% stance-phase), GRF_3D_processed,GRF_3D_segmented ,raw.
    % Curves: Original && corrFilter

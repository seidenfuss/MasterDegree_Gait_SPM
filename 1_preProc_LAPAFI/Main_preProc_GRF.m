%Pre processing GRF data from walking repetitions with self-selected unmonitored speed
%Loading, filtering (noise reduction BW 4th order zero lag), interpolation, weight normalization,
%Cross-correlation filter (within and between participants curve quality control)

close all; clear; clc;
disp('Starting GRF...')

%% Load Metadata - date of birth, date of examination, age, weight and mass
load('elderly_metadata.mat')

%% Load GRF Data: from folder containing all participants
data_path = './elderly_GRF/';
[Data_GRF, Fs]=importSubfolder(data_path);
Dim=size(Data_GRF);

for i=1:Dim(1,1)
    % Change the signal to show anterior and medial forces as positive values
    Data_GRF{i, 2}(:,2)=-Data_GRF{i, 2}(:,2); %AP R
    Data_GRF{i, 2}(:,5)=-Data_GRF{i, 2}(:,5); %AP L
    Data_GRF{i, 2}(:,7)=-Data_GRF{i, 2}(:,7); %ML L
end
    
    plotTrials(3,Data_GRF,'b',' - Right foot');
    plotTrials(6,Data_GRF,'r',' - Left foot');

%weight and mass    
for i=1:Dim(1,1)    
    % Calculate Weight (N) using a static test (Vertical GRF force component)
    Weight(i,1)=mean(Data_GRF{i,1}(1:end-2,3) + Data_GRF{i,1}(1:end-2,6));
    Mass_kg(i,1)=Weight(i,1)/9.807;
    
    % Add into metadata structure: weight and mass estimated from static test;
    elderly_metadata(i).WEIGHT_N=Weight(i,1);
    elderly_metadata(i).MASS_measured_kg=Mass_kg(i,1);
    
    % Get stance EVENTS for each foot: events_side{1,event}, where:
    % event = 1: first data point and event = 2 is last data point
    [preProc.events_R{i,1}, preProc.events_R{i,2}, preProc.n_steps_R{i,1}] = getEvents(Data_GRF{i,2}(:,3));
    [preProc.events_L{i,1}, preProc.events_L{i,2}, preProc.n_steps_L{i,1}] = getEvents(Data_GRF{i,2}(:,6));
end

%% Segment: using stance events;

preProc.seg_grf_R = segmentCurves(Data_GRF,preProc.n_steps_R,preProc.events_R,2,3,4);
preProc.seg_grf_L = segmentCurves(Data_GRF,preProc.n_steps_L,preProc.events_L,5,6,7);


%% Prepare data: divide by bodyweight, delete (too short curves), downsample, filter and interpolate;
Fc=20;
[preProc.prep_curves_R]=prepDataCurves(preProc.seg_grf_R,preProc.n_steps_R,Weight,Fs,Fc);
[preProc.prep_curves_L]=prepDataCurves(preProc.seg_grf_L,preProc.n_steps_L,Weight,Fs,Fc);

%% assigning data for correlation calculations
[preProc.grf_corr_R,preProc.grf_corr_L]=prepDataCorr(preProc.prep_curves_R,preProc.prep_curves_L);

%% plot before correlation calculations:
plotStance(preProc.grf_corr_R,2,'b',"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot ", " - Before CorrFilter");
plotStance(preProc.grf_corr_L,2,'r',"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot ", " - Before CorrFilter");

%% corr_limiar on corrFilter: testing different correlation coeficients as the limiar for corrFilter function:

corr_coef=[0.85,0.90,0.95];
for n_coef = 1:numel(corr_coef)
    preProc.corr_text{n_coef}=strcat('CorrFilter ',num2str(corr_coef(n_coef)*100),'%');
    [preProc.opt_GRF_R{n_coef},preProc.rep_n{n_coef}] = repeatCorrFilter(preProc.grf_corr_R,corr_coef(n_coef));
    [preProc.opt_GRF_L{n_coef},preProc.rep_n{n_coef}] = repeatCorrFilter(preProc.grf_corr_L,corr_coef(n_coef));
end

% plot after correlation filter
plotStance(preProc.opt_GRF_R{end},3,'b',"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot ",preProc.corr_text(end));
plotStance(preProc.opt_GRF_L{end},3,'r',"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot ",preProc.corr_text(end));


%% Export Data

for i=1:Dim(1,1)
    % GRF_3D_concatenated;
    elderly_metadata(i).GRF_R_concat=Data_GRF{i,2}(:,2:4);% Right
    elderly_metadata(i).GRF_L_concat=Data_GRF{i,2}(:,5:7);% Left
    
    % GRF_3D_segmented;
    %segmented,removed too short series, filtered (BW, 4th order, no lag, Fc=20Hz,Fs=1000Hz),
    %Downsampled and interpolated to 100 points %101? (nature has 101)
    elderly_metadata(i).GRF_R_segmented=preProc.grf_corr_R{i,1};
    elderly_metadata(i).GRF_L_segmented=preProc.grf_corr_L{i,1};
        
    % GRF_3D_corrFilter(0.85, 0.90, 0.95);
    elderly_metadata(i).GRF_R_corrFilter85=preProc.opt_GRF_R{1}(i,:);
    elderly_metadata(i).GRF_L_corrFilter85=preProc.opt_GRF_L{1}(i,:);
    elderly_metadata(i).GRF_R_corrFilter90=preProc.opt_GRF_R{2}(i,:);
    elderly_metadata(i).GRF_L_corrFilter90=preProc.opt_GRF_L{2}(i,:);
    elderly_metadata(i).GRF_R_corrFilter95=preProc.opt_GRF_R{3}(i,:);
    elderly_metadata(i).GRF_L_corrFilter95=preProc.opt_GRF_L{3}(i,:);
end


%% number of curves vs limiar_corr
[preProc.n_steps_R]=plotCurveNcorrCoef(preProc.grf_corr_R,corr_coef,preProc.opt_GRF_R,'Right','b');
[preProc.n_steps_L]=plotCurveNcorrCoef(preProc.grf_corr_L,corr_coef,preProc.opt_GRF_L,'Left','r');

%% keep only those participants that have n_steps >= 4 curves for both feet on the last correlation filter (95%);
keeper=([]);
count=1;
for i =1:Dim(1,1)
    if preProc.n_steps_R{i, end}(1,1)>=4  && preProc.n_steps_L{i, end}(1,1) >=4
        keeper(count)=i;
        count=count+1;
    end
    GRF_proc=elderly_metadata(keeper);
end

%% do filtering between subjects to remove paticipants with discrepant curves;
[elderly_subj_final] = interSubjFilter(GRF_proc);

% export final data - save file:
save('elderly_subj_final.mat','elderly_subj_final')
disp('GRF processing: finished.')

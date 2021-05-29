%Loading, filtering, and datinterp algorithms wrotten by Marcus Fraga Vieira: co-advisor. 
%Translated and modified by Ana Maria Bender Seidenfuss das Neves.
%Introducing batch (many folders and multiple files) importing and
%Pre-Processing (Ana Maria, Rafael and Marcus) and Statistical Parametric Mapping (Todd Pataky, Friston, et al.)
%Correlation_filter to keep good quality curves for further analysis;

close all; clear; clc;
disp('Starting GRF...')

%% Load Metadata - date of birth, date of examination, age, weight and mass
load('elderly_metadata.mat')

%% Load GRF Data: from folder containing all participants
Diretory_GRF_elderly = './idosos_GRF/';
[Data_GRF_Elderly, Fs]=importSubfolderFiles(Diretory_GRF_elderly);
Dim=size(Data_GRF_Elderly);

%% Initialize variables for speed improvement
%weight and mass
Weight = zeros(Dim(1,1),1);
Mass_kg = zeros(Dim(1,1),1);

for i=1:Dim(1,1)
    % Change the signal due to system origin in the oposite side
    Data_GRF_Elderly{i, 2}(:,2)=-Data_GRF_Elderly{i, 2}(:,2); %AP R
    Data_GRF_Elderly{i, 2}(:,5)=-Data_GRF_Elderly{i, 2}(:,5); %AP L
    Data_GRF_Elderly{i, 2}(:,7)=-Data_GRF_Elderly{i, 2}(:,7); %ML L
    
    % Calculate Weight (N) using a static test (Vertical GRF force component)
    Weight(i,1)=mean(Data_GRF_Elderly{i,1}(1:end-2,3) + Data_GRF_Elderly{i,1}(1:end-2,6)); 
    Mass_kg(i,1)=Weight(i,1)/9.81;  
  
    % Add into metadata structure: weight and mass estimated from static test;
    elderly_metadata(i).WEIGHT_N=Weight(i,1);
    elderly_metadata(i).MASS_measured_kg=Mass_kg(i,1);

    % Get stance EVENTS for each foot: events_side{1,event}, where:
    % event = 1: first data point and event = 2 is last data point
    [preProc.isnan_R{i,1}, preProc.events_R{i,1}, preProc.events_R{i,2}, preProc.n_steps_R{i,1}] = getEvents(Data_GRF_Elderly{i,2}(:,3));
    [preProc.isnan_L{i,1}, preProc.events_L{i,1}, preProc.events_L{i,2}, preProc.n_steps_L{i,1}] = getEvents(Data_GRF_Elderly{i,2}(:,6));
end

plotTrials(Dim,3,3,'b',Data_GRF_Elderly,'GRF Vertical ','Time samples (ms)','GRF_V (N)',' - Trials: ',' - Right foot');
plotTrials(Dim,6,3,'r',Data_GRF_Elderly,'GRF Vertical ','Time samples (ms)','GRF_V (N)',' - Trials: ',' - Left foot');

%% Segment: using stance events;

preProc.elderly_grf_R = segmentCurves(Data_GRF_Elderly,preProc.n_steps_R,preProc.events_R,2,3,4);
preProc.elderly_grf_L = segmentCurves(Data_GRF_Elderly,preProc.n_steps_L,preProc.events_L,5,6,7);


%% Prepare data: divide by bodyweight, delete (too short curves), downsample, filter and interpolate;
Fc=24;
[preProc.prepared_curves_R,preProc.filtered_R]=prepDataCurves(Dim(1,1),preProc.n_steps_R,preProc.elderly_grf_R,Weight,Fs,Fc);
[preProc.prepared_curves_L,preProc.filtered_L]=prepDataCurves(Dim(1,1),preProc.n_steps_L,preProc.elderly_grf_L,Weight,Fs,Fc);


%% assigning data for correlation calculations
[preProc.grf_R_w,preProc.grf_L_w]=prepDataCorr(Dim,preProc.prepared_curves_R,preProc.prepared_curves_L);

%% plot before correlation calculations:
plotStance(Dim,2,'b',preProc.grf_R_w,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot ", " - Before CorrFilter");
plotStance(Dim,2,'r',preProc.grf_L_w,"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot ", " - Before CorrFilter");

%% corr_limiar on corrFilter: testing different correlation coeficients as the limiar for corrFilter function:

corr_limiar=[0.85,0.90,0.95];
for rpt = 1:numel(corr_limiar)
    preProc.corr_text{rpt}=strcat('CorrFilter ',num2str(corr_limiar(rpt)*100),'%');
    [preProc.output_subj_R{rpt},preProc.rep_n{rpt}] = repeatCorrFilter(Dim(1,1),preProc.grf_R_w,corr_limiar(rpt));
    [preProc.output_subj_L{rpt},preProc.rep_n{rpt}] = repeatCorrFilter(Dim(1,1),preProc.grf_L_w,corr_limiar(rpt));
end

% plot after correlation filter
plotStance(Dim,3,'b',preProc.output_subj_R{end},"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot ",preProc.corr_text(end));
plotStance(Dim,3,'r',preProc.output_subj_L{end},"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot ",preProc.corr_text(end));


%% Export Data

 for i=1:Dim(1,1)
    % GRF_3D_concatenated;
    elderly_metadata(i).GRF_R_concat=Data_GRF_Elderly{i,2}(:,2:4);% Right
    elderly_metadata(i).GRF_L_concat=Data_GRF_Elderly{i,2}(:,5:7);% Left
    
    % GRF_3D_segmented;
    %segmented,removed too short series, filtered (BW, 4th order, no lag, Fc=20Hz,Fs=1000Hz),
    %Downsampled and interpolated to 100 points %101? (nature has 101)
    elderly_metadata(i).GRF_R_segmented=preProc.grf_R_w{i,1};
    elderly_metadata(i).GRF_L_segmented=preProc.grf_L_w{i,1};
    
    %sampled GRF (filtered before downsample and interpolation)
    elderly_metadata(i).GRF_R_filtered=preProc.filtered_R(i,:);
    elderly_metadata(i).GRF_L_filtered=preProc.filtered_L(i,:);
    
    % GRF_3D_corrFilter(0.85, 0.90, 0.95); 
    elderly_metadata(i).GRF_R_corrFilter85=preProc.output_subj_R{1}(i,:);
    elderly_metadata(i).GRF_L_corrFilter85=preProc.output_subj_L{1}(i,:);
    elderly_metadata(i).GRF_R_corrFilter90=preProc.output_subj_R{2}(i,:);
    elderly_metadata(i).GRF_L_corrFilter90=preProc.output_subj_L{2}(i,:); 
    elderly_metadata(i).GRF_R_corrFilter95=preProc.output_subj_R{3}(i,:);
    elderly_metadata(i).GRF_L_corrFilter95=preProc.output_subj_L{3}(i,:); 
 end
 
 
%% number of curves vs limiar_corr
[preProc.n_steps_R]=plotCurveNcorrCoef(preProc.grf_R_w,corr_limiar,preProc.output_subj_R,Dim,'Right','b');
[preProc.n_steps_L]=plotCurveNcorrCoef(preProc.grf_L_w,corr_limiar,preProc.output_subj_L,Dim,'Left','r');

%% keep only those participants that have n_steps >= 4 curves for both feet on the last correlation filter (95%);
count=1;
for i =1:Dim(1,1)
    if preProc.n_steps_R{i, end}(1,1)>=4  && preProc.n_steps_L{i, end}(1,1) >=4
        keeper(count)=i;
        count=count+1;
    end
    elderly_GRF_proc=elderly_metadata(keeper);
end


%% colocar aqui a parte do final subjects, create a function? daí fica tudo aqui fechadinho;
%% ver se é necessário adicionar certos dados na preProc ou se já vale a pena por no elderly_metadata; há_braços.


save('elderly_GRF_proc.mat','elderly_GRF_proc');
disp('GRF processing: finished.')
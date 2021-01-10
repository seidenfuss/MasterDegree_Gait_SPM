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

%% corr_limiar on corrFilter: 
%testing different correlation coeficients as the limiar for corrFilter function;

corr_limiar=[0.80,0.85,0.90,0.95,0.97];
for rpt = 1:numel(corr_limiar)
    corr_text{rpt}=strcat('CorrFilter ',num2str(corr_limiar(rpt)*100),'%');
    [output_subj_R{rpt},rep_n{rpt}] = repeatCorrFilter(Dim(1,1),grf_R_w,corr_limiar(rpt));
    [output_subj_L{rpt},rep_n{rpt}] = repeatCorrFilter(Dim(1,1),grf_L_w,corr_limiar(rpt));
end
plotStance(Dim,3,'b',output_subj_R{end},"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Right Foot",corr_text(end));
plotStance(Dim,3,'r',output_subj_L{end},"Stance Phase (%)","$\bf\frac{GRF(N)}{Weight(N)}$"," - Nº Curves: "," Left Foot",corr_text(end));
 

%% Export Data for SPM
% Curves: Original && corrFilter 
% GRF_3D_concatenated; %OK############
% GRF_3D_segmented; %OK original##############
% GRF_3D_corrFilter(.80,.85,.90,.95,.97); %OK##############

% export data using structure

 for i=1:Dim(1,1)
     %concatenated trials
 elderly_metadata(i).GRF_R_concat=Data_GRF_Elderly{i,2}(:,2:4);% Right
 elderly_metadata(i).GRF_L_concat=Data_GRF_Elderly{i,2}(:,5:7);% Left
     %segmented,removed too short series, filtered (BW, 4th order, no lag, Fc=20Hz,Fs=1000Hz),
     %Downsampled and interpolated to 100 points %101? (nature has 101)
 elderly_metadata(i).GRF_R_segmented=grf_R_w{i,1};
 elderly_metadata(i).GRF_L_segmented=grf_L_w{i,1};
 
 elderly_metadata(i).GRF_R_corrFilter80=output_subj_R{1}(i,:);
 elderly_metadata(i).GRF_L_corrFilter80=output_subj_L{1}(i,:);
 
 elderly_metadata(i).GRF_R_corrFilter85=output_subj_R{2}(i,:);
 elderly_metadata(i).GRF_L_corrFilter85=output_subj_L{2}(i,:);
 
 elderly_metadata(i).GRF_R_corrFilter90=output_subj_R{3}(i,:);
 elderly_metadata(i).GRF_L_corrFilter90=output_subj_L{3}(i,:); 
 
 elderly_metadata(i).GRF_R_corrFilter95=output_subj_R{4}(i,:);
 elderly_metadata(i).GRF_L_corrFilter95=output_subj_L{4}(i,:); 
 
 elderly_metadata(i).GRF_R_corrFilter97=output_subj_R{5}(i,:);
 elderly_metadata(i).GRF_L_corrFilter97=output_subj_L{5}(i,:);

 end
 
 
%% number of curves vs limiar_corr
 
 for i=1:Dim(1,1)
 curves_R{i,1}=grf_R_w{i,2};%original_curves_Right
 curves_L{i,1}=grf_L_w{i,2};%Original_curves_Left
 for rpt = 1:length(corr_limiar)
     curves_R{i,rpt+1}=output_subj_R{1,rpt}{i,3};%corr_limiar_curves_Right  
     curves_L{i,rpt+1}=output_subj_L{1,rpt}{i,3};%corr_limiar_curves_Left
 end

 end
 
 for i=1:Dim(1,1)
     for j=1:6
     elderly_metadata(i).n_steps_R{1,j}=curves_R{i,j};
     elderly_metadata(i).n_steps_L{1,j}=curves_L{i,j};
     end
 end
 
 figure()
  for i = 1:Dim(1,1)
    for j=1:6
      subplot(5,3,i)
         bar(j,curves_R{i,j},"stacked",'b')
         hold on
         ylim([0 25])
         sgtitle('Number of curves corrFilter - Right Foot')
         set(gca,'XTick',1:1:6)
         set(gca,'XTickLabel',{'Origin','\rho=0.80','\rho=0.85','\rho=0.90','\rho=0.95','\rho=0.97'})
    end
  end
  
  figure()
  for i = 1:Dim(1,1)
    for j=1:6
      subplot(5,3,i)
         bar(j,curves_L{i,j},"stacked",'r')
         hold on
         ylim([0 25])
         sgtitle('Number of curves corrFilter - Left Foot')
         set(gca,'XTick',1:1:6)
         set(gca,'XTickLabel',{'Origin','\rho=0.80','\rho=0.85','\rho=0.90','\rho=0.95','\rho=0.97'})

    end
  end


save('elderly_metadata_GRF.mat','elderly_metadata');

%% Database_Nature % DOING SOMEWHERE ELSE...

disp('GRF processing: finished.')
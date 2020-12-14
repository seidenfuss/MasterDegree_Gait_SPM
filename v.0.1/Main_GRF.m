%Loading, filtering, and datinterp algorithms wrotten by Marcus Fraga Vieira: co-advisor. 
%Translated and modified by Ana Maria Bender Seidenfuss das Neves.
%introducing batch (many folders and multiple files) importing and
%Pre-Processing (Ana Maria, Rafael and Marcus) and Statistical Parametric Mapping (Todd Pataky, Friston, et al.)

close all; clear; clc;
disp('Starting GRF...')

%% Loading GRF Data % give the name you think better describes your group of repetitions
Diretory_GRF_elderly = './idosos_GRF/';
[Data_GRF_Elderly, Fs]=import_subfolder_files(Diretory_GRF_elderly);

%% calculating weight using one static test

Dim=size(Data_GRF_Elderly);
Weight = zeros(Dim(1,1),1);
Mass_kg = zeros(Dim(1,1),1);

for i=1:Dim(1,1)
    Weight(i,1)=mean(Data_GRF_Elderly{i,1}(1:end-2,3) + Data_GRF_Elderly{i,1}(1:end-2,6)); 
    Mass_kg(i,1)=Weight(i,1)/9.81;  
end
  
%% SEPARATE RIGHT FOOT EVENTS
%get were in time (which row of the matrix) each stance phase
% starts and ends (b_R) and also the number of steps:
isnan_R={[]}; events_R={[]}; n_steps_R={[]};
for i=1:Dim(1,1)
    [isnan_R{i,1}, events_R{i,1}, events_R{i,2}, n_steps_R{i,1}] = get_Events(Data_GRF_Elderly{i,2}(:,3));
end

%plot1 [para ver] all data
figure() 
for i=1:Dim(1,1)
    subplot(5,3,i); plot(Data_GRF_Elderly{i,2}(:,3));hold on;
end

%% Segment: using stance events: [(events_R{i_1} = start) and (events_R{i_2} = end)]  and the number of steps[n_steps_R]; 
elderly_grf_r = Segment(Data_GRF_Elderly,n_steps_R,events_R,2,3,4);

%% Prepare data: divide by bodyweight, delete (too short curves), downsample, filter and interpolate;
%define cut frequency: learn how; or just cite the dissertation using
%20Hz as proposed by: 
    Fc=20;
prepared_curves_R=prepare_curves(Dim(1,1),n_steps_R,elderly_grf_r,Weight,Fs,Fc);

%% assigning data for correlation calculations
%cell of cells, with i rows (participants) with l from 1 to 3 columns for each grf component (x,y,z)
grf_r_w={[]};
for i=1:Dim(1,1)
    k=length(prepared_curves_R{i,1});
    for j=1:k
        for l=1:3
            grf_r_w{i,1}{1,l}(j,:)= horzcat(transp(prepared_curves_R{i,l}{j,1}(:,1)));
        end
    end
end
%plot before correlation calculations:
figure()
for l=1:3
    subplot(1,3,l)
    for i=1:Dim(1,1) 
        subplot(5,3,i); plot(grf_r_w{i,1}{1,l}(:,:)'); hold on;
    end
end

%% correlation Filter

[output_teste,rep_n] = repeat_corrFilter(Dim(1,1),grf_r_w,0.95);
% plot results from  
  for l=1:3
      figure()
      for i=1:Dim(1,1)
         subplot(5,3,i)
         plot(output_teste{i,1}{1,l}(:,:)')
         hold on
      end
  end

 

%% try putting all steps without informing the participant neither the 
%step number... %corr filter and plots also;
AQUI=0;
grf_r_all={[]}; 
cm_r_all{1,l}={[]};
figure()
for i=1:Dim(1,1)
    k=length(prepared_curves_R{i,1});
    for j=1:k
           AQUI=AQUI+1
        for l=1:3
           all_GRF{1,1}{1,l}(AQUI,:)=horzcat(grf_r_w{i,1}{1,l}(j,:));
           subplot(2,3,l); plot(all_GRF{1,1}{1,l}(AQUI,:)); hold on;
           
           grf_r_all{1,1}{1,l} = all_GRF{1,1}{1,l}(:,:)'; 
           cm_r_all{1,l} = corr(grf_r_all{1,1}{1,l});
           subplot(2,3,l+3);colormap(cool); imagesc(cm_r_all{1,l}); hold on;
        end     
    end    
end
[output_teste_all,rep_n_all] = repeat_corrFilter(1,all_GRF,0.95);
 

% plot results from  
figure()  
for l=1:3
    cm_r_all_out{1,l} = corr(output_teste_all{1,1}{1,l}(:,:)');
    subplot(2,3,l);plot(output_teste_all{1,1}{1,l}(:,:)');hold on;
    subplot(2,3,l+3); colormap(cool); imagesc(cm_r_all_out{1,l}); hold on;
end

%% FIX ITTTT
%Import - concatenate
%Get events
%Segment/Cut-Curves
%Clean Stance Duration: too short; too long; average;
%Downsample (1000 H0z--0>100 Hz)
%Filter: butterworth zero lag - 4th order, Fc: 24 HZ (initially)
%Interpolate (100 nodes)
%Classify using ICC: 
    %comple0te vs incomplete 
    %if R > 0.90 (CROSS-CORRELATION)
%Make abs values (all positive values)
%save complete curves 
    %a) original (no curve fit)
% output - create: 
    %within subject file (multiple curves for each subj) 
        %1 file for subject foot... SUB1_group_R and SUB1_group_L 
        %n curves
        %3 vector GRF components
    %between subject file (mean curve for each subj)
    %1 file for group foot - 
        %ex.:   ELDERLY_R (N subjects of older adults groups - mean curves of right foot) 
        %       ELDERLY_L         
% Curve Fit: 
    %a) Fourier; 
    %b) Polynomial; 
    %c) Gaussian;
    %d) Smoothing spline;
    
% SPM: 
    % Within SUBJ RxL
        % find example: paired hotelings t-test t2...
            % for all stance for each participant
    % Between SUBJ RxL
        % find example: paired hotelings t-test t2...
            % mean of each participant
    % Between groups RXL
        % find example: (hotellins T2 - multiple variables, 2 conditions (groups)) 
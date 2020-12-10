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
%plotDim= find minimos multiplos comuns para o numero de participantes e se for primo:
%triste fim- arredonda pro proximo maior e deixa vazio ou expande? nao sei;
Weight = zeros(Dim(1,1),1);
Mass_kg = zeros(Dim(1,1),1);

for i=1:Dim(1,1)
    Weight(i,1)=mean(Data_GRF_Elderly{i,1}(1:end-2,3) + Data_GRF_Elderly{i,1}(1:end-2,6)); 
    Mass_kg(i,1)=Weight(i,1)/9.81;  
end
  
%% SEPARATE RIGHT FOOT EVENTS
%get were in time (which row of the matrix) each stance phase
%(possible_step?) starts and ends (b_R)
%and also the number of steps:
isnan_R={[]};
events_R={[]};
n_steps_R={[]};

for i=1:Dim(1,1)
    [isnan_R{i,1}, events_R{i,1}, events_R{i,2}, n_steps_R{i,1}] = get_Events(Data_GRF_Elderly{i,2}(:,3));
end

%plot1 [para ver] all data
figure() 
for i=1:Dim(1,1)
    subplot(5,3,i)
    plot(Data_GRF_Elderly{i,2}(:,3));
    hold on;
end

%% Segment: using stance [(events_R{i_1} = start) and (events_R{i_2} = end)] events and the number of steps; 
[elderly_grf_r] = Segment(Data_GRF_Elderly,n_steps_R,events_R,2,3,4);

%% Prepare data: downsample, divide by bodyweight, filter, 
    %delete (too short/too long), and interpolate;
    %%!!!! correct the function using logical indexing... if possible;

    %define cut frequency: learn how; or just cite the dissertation using
    %20Hz
    Fc=20;
prepared_curves_R=prepare_curves(Dim(1,1),n_steps_R,elderly_grf_r,Weight,Fs,Fc);

%% montando a matrix de saida - correlação 
%(existe esse nome? só encontro para imagem)

Output_GRF={[]};
grf_r_w={[]};
for i=1:Dim(1,1)
    k=length(prepared_curves_R{i,1});
    for j=1:k
        for l=1:3
            grf_r_w{i,l}(j,:)= horzcat(transp(prepared_curves_R{i,l}{j,1}(:,1)));
        end
    end
end

for l=1:3
    figure()
    for i=1:Dim(1,1) 
        subplot(5,3,i);
        plot(grf_r_w{i,l}(:,:)'); 
        hold on;
    end
end

%% correlation_matrix within participant
% for i = 1:Dim(1,1)
%     [iteration(it),min_corr(it)] = corrFilter(grf_r_w);
%     min(i,it)=min_corr{it}{i,1};
%     if min>= 0.96
%         [iteration(it),min_corr(it)] = corrFilter(iteration(it));
%         it=it+1
%         min(i,it)=min_corr{it}{i,1};
%     else
%         it=it+1;
%         [iteration(it),min_corr(it)] = corrFilter(iteration(it-1));
%         min(i,it)=min_corr{it}{i,1};
%     end
%     
% end
 %if min<0.96
 %       it=it+1;
 %      iteration{it}=corrFilter(iteration {it-1});
 %   end

 %% trying to make it recursive :) 
corr_limiar=0.97;
  [iteration_1,min_corr_1] = corrFilter(grf_r_w,corr_limiar);
  [iteration_2,min_corr_2] = corrFilter(iteration_1,corr_limiar);
  [iteration_3,min_corr_3] = corrFilter(iteration_2,corr_limiar);
  [iteration_4,min_corr_4] = corrFilter(iteration_3,corr_limiar);
  [iteration_5,min_corr_5] = corrFilter(iteration_4,corr_limiar);
  [iteration_6,min_corr_6] = corrFilter(iteration_5,corr_limiar);
  [iteration_7,min_corr_7] = corrFilter(iteration_6,corr_limiar);
  [iteration_8,min_corr_8] = corrFilter(iteration_7,corr_limiar);
  [iteration_9,min_corr_9] = corrFilter(iteration_8,corr_limiar);
  
 
 for l=1:3
     figure()
     for i=1:Dim(1,1)
        subplot(5,3,i)
        plot(iteration_8{i,l}(:,:)')
        hold on
     end
 end

 

%% put all curves together without separating by subject %plot also
%FIX ITTT

% AQUI=0;
% grf_r_all{1,l}={[]}; 
% cm_r_all{1,l}={[]};
% figure()
% for i=1:Dim(1,1)
%     k=length(prepared_curves_R{i,1});
%     for j=1:k
%            AQUI=AQUI+1
%         for l=1:3
%            all_GRF{l,1}(AQUI,:)=horzcat(grf_r_w{i,2}(j,:));
%            subplot(1,3,l); plot(all_GRF{l,1}(AQUI,:)); hold on;
%            
%            grf_r_all{1,l} = all_GRF{1,1}(:,:)'; 
%            cm_r_all{1,l} = corr(grf_r_all{1,l});
%            subplot(1,3,l);
%            colormap(cool); imagesc(cm_r_all{1,l}); hold on;
%         end     
%     end    
% end

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
    %1 file for 0group foot - 
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
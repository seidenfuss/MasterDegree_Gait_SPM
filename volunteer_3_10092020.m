%Loading, filtering, and datinterp algorithms wrotten by Marcus Fraga Vieira: co-advisor. 
%Translated and modified by Ana Maria Bender Seidenfuss das Neves.

close all; clear; clc;

disp('Starting GRF...')

%% Loading GRF Data
Diretory_Data_GRF = './Data_GRF/';
[ Data_GRF, list_GRF ] = loadFiles( Diretory_Data_GRF );
Fs=200;
%% Concatenating GRF - put together trials
% to count, separate and classify gait events
concat_GRF = (cell2mat(Data_GRF(2:list_GRF)));

% each cell is a coordinate - 3 coordinates of GRF for all repetitions of each foot - at the end 6x1 cell (row vector) is 1:AP_R 2:V_R 3:ML_R 4:AP_L 5:V_L 6:ML_R

A_GRF = {concat_GRF(:,3); concat_GRF(:,4); concat_GRF(:,5); concat_GRF(:,6); concat_GRF(:,7); concat_GRF(:,8)};

%% SAMPLE FREQUENCY - how to calculate? how to figure out from data automatically? 
%Fs; % calculating and transforming time using the sample frequency (Fs), 
%so time is given in seconds after concatenating.
total_time=(1:length(concat_GRF))/Fs; 

%% calculating weight using one static test
w = mean(Data_GRF{1,1}(:,4)+Data_GRF{1,1}(:,7)); % Calculating bodyweight
mass_kg = w/9.81;
 
%% SEPARATE RIGHT FOOT EVENTS
%get were in time (which row of the matrix) each stance phase (possible_step?) starts and ends
%and also the number of steps:
[a_R, b_R, c_R, n_steps_R] = get_Events(A_GRF{1,1}(:,1));

%Segment: using stance [b = start and c = end] events and the number of steps; 
[x_R] = Segment_GRF_R(A_GRF, b_R, c_R, n_steps_R);

%Prepara: divide by bodyweight, filter and interpolate; função prepara_GRF;
[Out_GRF_R] = prepara_GRF( x_R, n_steps_R, w, Fs,200,100);

%Save: output matrix RIGHT FOOT
save('Out_GRF_R.mat','Out_GRF_R');
load('Out_GRF_R.mat');

%Classify: using correlation coeficient between events(only after interpolation?);
%testando matriz de correlação;
YR=Out_GRF_R(1:10,:,2);
yR=Out_GRF_R(1:n_steps_R,:,2);
cmR = corr(yR');
cmRRR=corr(YR');
cmRR = corr(yR);

figure(1)
colormap(cool);
imagesc(cmR);

figure(2)
colormap(cool);
imagesc(cmRRR);


%% SEPARATE LEFT FOOT
%get were in time each of the stance phase starts and ends and also the number of steps:
[a_L, b_L, c_L, n_steps_L]= get_Events(A_GRF{4,1}(:,1));

%Segment: using stance start and end events and the number of steps; 
[x_L]=Segment_GRF_L(A_GRF, b_L, c_L, n_steps_L);

%Prepara: divide by bodyweight, filter, interpolate and create output matrix;

[Out_GRF_L]=prepara_GRF( x_L, n_steps_L, w, Fs,200,100);
%Save: output matrix RIGHT FOOT
save('Out_GRF_L.mat','Out_GRF_L');
load('Out_GRF_L.mat');

%Classify: using correlation coeficient between events;
%testando correlação cruzada; 
yL=Out_GRF_L(1:n_steps_L,:,2);
figure(3)
colormap(cool);
cmL = corr(yL');
imagesc(cmL);


%% PLOT
% Plot to check if curves were registrated properly
figure (4)
 for NR=1:n_steps_R
subplot (3,2,1); plot(Out_GRF_R(NR,:,1),'b'); title('Anterior-posterior'); legend({'Right'},'Location', 'Best'); hold on; %AP_R
subplot (3,2,3); plot(Out_GRF_R(NR,:,2),'b'); ylabel('Force/Bodyweight'); title('Vertical'); hold on; % V_R
subplot (3,2,5); plot(Out_GRF_R(NR,:,3),'b'); xlabel('% Stance Phase'); title('Medio-lateral'); hold on;% ML_R
 end
 for NL=1:n_steps_L
subplot (3,2,2); plot(Out_GRF_L(NL,:,1),'r');title('Anterior-posterior'); legend({'Left'},'Location', 'Best'); hold on; % AP_L
subplot (3,2,4); plot(Out_GRF_L(NL,:,2),'r'); ylabel('Force/Bodyweight'); title('Vertical'); hold on; % V_L
subplot (3,2,6); plot(Out_GRF_L(NL,:,3),'r'); xlabel('% Stance Phase'); title('Medio-lateral'); hold on; % ML_L
 end
hold off

%% load datasets before spm

yR=Out_GRF_R(1:n_steps_R,:,2);
yL=Out_GRF_L(1:n_steps_L,:,2);

 

%% SPM
YR=Out_GRF_R(1:10,:,2);
YL=Out_GRF_L(1:10,:,2);

%% two sample paired t-test


%%intra-subject - right vs left --- ttest paired
%(1) Conduct SPM analysis:
spm       = spm1d.stats.ttest_paired(YL, YR);
spmi      = spm.inference(0.05, 'two_tailed', false, 'interp',true);
disp(spmi)
%(2) Plot:
figure('position', [0 0 1000 300])
%%% plot mean and SD:
subplot(121)
spm1d.plot.plot_meanSD(YL, 'color','r');
hold on
spm1d.plot.plot_meanSD(YR, 'color','b');
title('Mean and SD: GRF_V Right and Left (10 cycles)'); ylabel('Force/Bodyweight'); xlabel('% Stance Phase');
%%% plot SPM results:
subplot(122)
spmi.plot();
spmi.plot_threshold_label();
spmi.plot_p_values();
title('Hypothesis test: paired two-sample t-test')

%t test 1 sample
%(1) Conduct normality test: R
alpha     = 0.05;
spm       = spm1d.stats.normality.ttest(yR);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot:
%subplot(2,1,1)
figure('position', [0 0  1200 300])
subplot(131);  plot(yR', 'b');  title('GRF_V Right (14 cycles)'); ylabel('Force/Bodyweight'); xlabel('% Stance Phase');
subplot(132);  plot(spm.residuals', 'k');  title('Residuals')
subplot(133);  spmi.plot();  title('Normality test: one sample t-test')

%t test 1 sample
%(1) Conduct normality test: R
alpha     = 0.05;
spm       = spm1d.stats.normality.ttest(YR);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot:
%subplot(2,1,1)
figure('position', [0 0  1200 300])
subplot(131);  plot(YR', 'b');  title('GRF_V Right (10 cycles)'); ylabel('Force/Bodyweight'); xlabel('% Stance Phase');
subplot(132);  plot(spm.residuals', 'k');  title('Residuals')
subplot(133);  spmi.plot();  title('Normality test: one-sample t-test')


%t test 1 sample
%(1) Conduct normality test: Left foot 
alpha     = 0.05;
spm       = spm1d.stats.normality.ttest(yL);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot:
%subplot(2,1,2)
figure('position', [0 0  1200 300])
subplot(131);  plot(yL', 'r');  title('GRF_V Left (10 cycles)')
subplot(132);  plot(spm.residuals', 'k');  title('Residuals')
subplot(133);  spmi.plot();  title('Normality test: one-sample t-test')

%(1) Conduct normality test:
alpha     = 0.05;
spm       = spm1d.stats.normality.ttest_paired(YL, YR);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot:
figure('position', [0 0  1200 300])
subplot(131);  plot(YL', 'r');  hold on;  plot(YR', 'b');  title('Right and Left GRF_V (10 cycles)'); ylabel('Force/Weight'); xlabel('% Stance Phase');
subplot(132);  plot(spm.residuals', 'k');  title('Residuals')
subplot(133);  spmi.plot();  title('Normality test: paired two-sample t-test')


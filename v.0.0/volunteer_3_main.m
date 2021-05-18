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

%Classify: using correlation coeficient between events:
%testando matriz de correlação;

YR=Out_GRF_R(1:10,:,2);
yR=Out_GRF_R(1:n_steps_R,:,2);
cmR = corr(yR');

%% Identify which curves have correlation < 90%
j=1;
for NR = 1:n_steps_R
    if cmR(NR) < 0.90  %correlation less than 90%
       incomp_R(j) = NR;
       j = j+1;
    end
end
aaa=size(incomp_R);
%% Delete curves that do not have correlation
if size(incomp_R)~=0
    
end
figure(1)
colormap(cool);
imagesc(cmR);


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

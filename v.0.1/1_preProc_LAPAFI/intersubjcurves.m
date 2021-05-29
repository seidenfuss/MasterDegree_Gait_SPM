close all; clear; clc;
%% make it a function ???
%(0) Load dataset:

load('elderly_GRF_proc.mat'); %data in here - just loading...

dim=size(elderly_GRF_proc);
for i=1:dim(1,2)
  for d=1:3
        elderly_GRF_proc(i).mean_GRF_R{1,d}=mean((elderly_GRF_proc(i).GRF_R_corrFilter95{1, 1}{1, d})); 
        elderly_GRF_proc(i).std_GRF_R{1,d}=std((elderly_GRF_proc(i).GRF_R_corrFilter95{1, 1}{1, d}));
        elderly_GRF_proc(i).mean_GRF_L{1,d}=mean((elderly_GRF_proc(i).GRF_L_corrFilter95{1, 1}{1, d})); 
        elderly_GRF_proc(i).std_GRF_L{1,d}=std((elderly_GRF_proc(i).GRF_L_corrFilter95{1, 1}{1, d}));
    end
end


yR={[]}; yL={[]}; 

 for i = 1:dim(1,2)
     yR{i,4}=elderly_GRF_proc(i).ID;
     yL{i,4}=elderly_GRF_proc(i).ID;
     for d=1:3
   yR{i,d} = elderly_GRF_proc(i).mean_GRF_R{1, d}(1,:);
   yL{i,d} = elderly_GRF_proc(i).mean_GRF_L{1, d}(1,:);
     end
 end

 
%% Plot before filter2(removing participants with discrepant curves)

plotStance2(size(elderly_GRF_proc,2),elderly_GRF_proc,2,7,"Mean and SD (GRF Right) - ",'Mean and SD (GRF Left) - ')
 
%% Remove curves that differ between participants 

[matrix_opt_R] = corrFilter2(yR, 0.85);
[matrix_opt_L] = corrFilter2(yL, 0.85);
[matrix_opt_R1] = corrFilter2(matrix_opt_R, 0.90);
[matrix_opt_L1] = corrFilter2(matrix_opt_L, 0.90);
 
GRF_R=matrix_opt_R1;
GRF_L=matrix_opt_L1;

x=0;
for i = 1:size(elderly_GRF_proc,2)
    check_subj=elderly_GRF_proc(i).ID;
    for j = 1: size(matrix_opt_R1)
        keep_subj=matrix_opt_R1{j,4};
        if check_subj==keep_subj
            x=x+1;
            elderly_subj_final(j)=elderly_GRF_proc(i);
            indices(x)=i;
        end   
    end
end

 for i = 1:size(GRF_R,1)
    elderly_subj_final(i).mean_GRF_R=GRF_R(i,1:3);
    elderly_subj_final(i).mean_GRF_L=GRF_L(i,1:3);
    
    elderly_subj_final(i).std_GRF_R=elderly_GRF_proc(indices(i)).std_GRF_R;
    elderly_subj_final(i).std_GRF_L=elderly_GRF_proc(indices(i)).std_GRF_L;
    for d=1:3
    elderly_subj_final(i).mean_GRF_RL{1,d}=mean(vertcat(GRF_R{i,d},GRF_L{i,d}));
    end
 end
 
%% plot the remaining participants
plotStance2(size(elderly_subj_final,2),elderly_subj_final,2,6,"Mean and SD (GRF Right) - After filter2",'Mean and SD (GRF Left) - After filter2')

%% export data: save file
save('elderly_subj_final.mat','elderly_subj_final')

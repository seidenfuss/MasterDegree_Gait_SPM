clear; 
load('GAITREC_Women_HealthyControls.mat');


%% shod == 1 (normal shoe) && speed == 2 (selfselected speed)
j=1;
for k=1:height(GAITREC_data_W.annotation)
 if GAITREC_data_W.annotation{k,12}==1 && GAITREC_data_W.annotation{k,14}==2
     keep(j,1)=k; 
     j=j+1;
 end
end
meta_GAITREC_W=table2struct(GAITREC_data_W.annotation);

for k=1:length(keep)
meta_GAITREC_W2(k)=meta_GAITREC_W(keep(k,1));
end

oldField = 'SUBJECT_ID';
newField = 'ID';
[meta_GAITREC_W2.(newField)] = meta_GAITREC_W2.(oldField);
meta_GAITREC_W2 = rmfield(meta_GAITREC_W2,oldField);

%% get GRF_R and GRF_L for three components o the force vector;

for k=1:length(meta_GAITREC_W2)
m=1;
    for j=1:height(GAITREC_data_W.GRF_F_PRO_AP_R_women)
        if GAITREC_data_W.GRF_F_PRO_AP_R_women{j,2}==meta_GAITREC_W2(k).SESSION_ID
            meta_GAITREC_W2(k).GRF_AP_R(m,:)=GAITREC_data_W.GRF_F_PRO_AP_R_women(j,:);
            meta_GAITREC_W2(k).GRF_V_R(m,:)=GAITREC_data_W.GRF_F_PRO_V_R_women(j,:);
            meta_GAITREC_W2(k).GRF_ML_R(m,:)=GAITREC_data_W.GRF_F_PRO_ML_R_women(j,:);
            meta_GAITREC_W2(k).GRF_AP_L(m,:)=GAITREC_data_W.GRF_F_PRO_AP_L_women(j,:);
            meta_GAITREC_W2(k).GRF_V_L(m,:)=GAITREC_data_W.GRF_F_PRO_V_L_women(j,:);
            meta_GAITREC_W2(k).GRF_ML_L(m,:)=GAITREC_data_W.GRF_F_PRO_ML_L_women(j,:);
            m=m+1;
        end
    end
end

% sort data by AGE   
[x,idx]=sort([meta_GAITREC_W2.AGE]);
meta_GAITREC_W2=meta_GAITREC_W2(idx);
   
%% separate by age groups

%young(15-29)
GAITREC_women.young=meta_GAITREC_W2(1:50);
%adults(30-49)
GAITREC_women.adult=meta_GAITREC_W2(51:86);
%older_adults(50-)
GAITREC_women.olderAdult=meta_GAITREC_W2(87:105);

%%  Mean curves women health control self selected speed and normal shoes shod condition
%young
[GAITREC_women.young] = mean_sd(GAITREC_women.young);
%adult
[GAITREC_women.adult] = mean_sd(GAITREC_women.adult);
%olderAdult
[GAITREC_women.olderAdult] = mean_sd(GAITREC_women.olderAdult);

%% mean of Right and left
%young
for i=1:size(GAITREC_women.young,2)    
        GAITREC_women.young(i).mean_GRF_RL{1,1}=mean(vertcat(GAITREC_women.young(i).mean_GRF_R{1,1},GAITREC_women.young(i).mean_GRF_L{1,1}));
        GAITREC_women.young(i).mean_GRF_RL{1,2}=mean(vertcat(GAITREC_women.young(i).mean_GRF_R{1,2},GAITREC_women.young(i).mean_GRF_L{1,2}));
        GAITREC_women.young(i).mean_GRF_RL{1,3}=mean(vertcat(GAITREC_women.young(i).mean_GRF_R{1,3},GAITREC_women.young(i).mean_GRF_L{1,3}));
end
%adults
for i=1:size(GAITREC_women.adult,2)    
        GAITREC_women.adult(i).mean_GRF_RL{1,1}=mean(vertcat(GAITREC_women.adult(i).mean_GRF_R{1,1},GAITREC_women.adult(i).mean_GRF_L{1,1}));
        GAITREC_women.adult(i).mean_GRF_RL{1,2}=mean(vertcat(GAITREC_women.adult(i).mean_GRF_R{1,2},GAITREC_women.adult(i).mean_GRF_L{1,2}));
        GAITREC_women.adult(i).mean_GRF_RL{1,3}=mean(vertcat(GAITREC_women.adult(i).mean_GRF_R{1,3},GAITREC_women.adult(i).mean_GRF_L{1,3}));
end
%older adults
for i=1:size(GAITREC_women.olderAdult,2)    
        GAITREC_women.olderAdult(i).mean_GRF_RL{1,1}=mean(vertcat(GAITREC_women.olderAdult(i).mean_GRF_R{1,1},GAITREC_women.olderAdult(i).mean_GRF_L{1,1}));
        GAITREC_women.olderAdult(i).mean_GRF_RL{1,2}=mean(vertcat(GAITREC_women.olderAdult(i).mean_GRF_R{1,2},GAITREC_women.olderAdult(i).mean_GRF_L{1,2}));
        GAITREC_women.olderAdult(i).mean_GRF_RL{1,3}=mean(vertcat(GAITREC_women.olderAdult(i).mean_GRF_R{1,3},GAITREC_women.olderAdult(i).mean_GRF_L{1,3}));
end

%% do random selection of 12 participants of each group
s= RandStream('mlfg6331_64'); %Multiplicative lagged Fibonacci generator

GAITREC_women12.young=datasample(s,GAITREC_women.young ,12);
GAITREC_women12.adult=datasample(s,GAITREC_women.adult ,12);
GAITREC_women12.olderAdult=datasample(s,GAITREC_women.olderAdult ,12);

save('GAITREC_women12.mat','GAITREC_women12')
save('GAITREC_women.mat','GAITREC_women')
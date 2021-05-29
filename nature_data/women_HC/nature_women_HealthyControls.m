clear; 
load('NATURE_Women_HealthyControls.mat');


%% shod == 1 (normal shoe) && speed == 2 (selfselected speed)
j=1;
for k=1:height(nature_data_W.annotation)
 if nature_data_W.annotation{k,12}==1 && nature_data_W.annotation{k,14}==2
     keep(j,1)=k; 
     j=j+1;
 end
end
meta_nature_W=table2struct(nature_data_W.annotation);

for k=1:length(keep)
meta_nature_W2(k)=meta_nature_W(keep(k,1));
end

oldField = 'SUBJECT_ID';
newField = 'ID';
[meta_nature_W2.(newField)] = meta_nature_W2.(oldField);
meta_nature_W2 = rmfield(meta_nature_W2,oldField);

%% get GRF_R and GRF_L for three components o the force vector;

for k=1:length(meta_nature_W2)
m=1;
    for j=1:height(nature_data_W.GRF_F_PRO_AP_R_women)
        if nature_data_W.GRF_F_PRO_AP_R_women{j,2}==meta_nature_W2(k).SESSION_ID
            meta_nature_W2(k).GRF_AP_R(m,:)=nature_data_W.GRF_F_PRO_AP_R_women(j,:);
            meta_nature_W2(k).GRF_V_R(m,:)=nature_data_W.GRF_F_PRO_V_R_women(j,:);
            meta_nature_W2(k).GRF_ML_R(m,:)=nature_data_W.GRF_F_PRO_ML_R_women(j,:);
            meta_nature_W2(k).GRF_AP_L(m,:)=nature_data_W.GRF_F_PRO_AP_L_women(j,:);
            meta_nature_W2(k).GRF_V_L(m,:)=nature_data_W.GRF_F_PRO_V_L_women(j,:);
            meta_nature_W2(k).GRF_ML_L(m,:)=nature_data_W.GRF_F_PRO_ML_L_women(j,:);
            m=m+1;
        end
    end
end

% sort data by AGE   
[x,idx]=sort([meta_nature_W2.AGE]);
meta_nature_W2=meta_nature_W2(idx);
   
%% separate by age groups

%young(15-25)
NATURE_women.young=meta_nature_W2(1:29);
%adults(26-45)
NATURE_women.adult=meta_nature_W2(30:76);
%older_adults(46-)
NATURE_women.olderAdult=meta_nature_W2(77:105);

%%  Mean curves women health control self selected speed and normal shoes shod condition
%young
[NATURE_women.young] = mean_sd(NATURE_women.young);
% for i=1:size(NATURE_women.young,2)    
%         NATURE_women.young(i).mean_GRF_R{1,1}=mean(NATURE_women.young(i).GRF_AP_R{:,4:end});
%         NATURE_women.young(i).mean_GRF_R{1,2}=mean(NATURE_women.young(i).GRF_V_R{:,4:end});
%         NATURE_women.young(i).mean_GRF_R{1,3}=mean(NATURE_women.young(i).GRF_ML_R{:,4:end});
%         NATURE_women.young(i).mean_GRF_L{1,1}=mean(NATURE_women.young(i).GRF_AP_L{:,4:end});
%         NATURE_women.young(i).mean_GRF_L{1,2}=mean(NATURE_women.young(i).GRF_V_L{:,4:end});
%         NATURE_women.young(i).mean_GRF_L{1,3}=mean(NATURE_women.young(i).GRF_ML_L{:,4:end});
% end
%adult
[NATURE_women.adult] = mean_sd(NATURE_women.adult);
% for i=1:size(NATURE_women.adult,2)    
%         NATURE_women.adult(i).mean_GRF_R{1,1}=mean(NATURE_women.adult(i).GRF_AP_R{:,4:end});
%         NATURE_women.adult(i).mean_GRF_R{1,2}=mean(NATURE_women.adult(i).GRF_V_R{:,4:end});
%         NATURE_women.adult(i).mean_GRF_R{1,3}=mean(NATURE_women.adult(i).GRF_ML_R{:,4:end});
%         NATURE_women.adult(i).mean_GRF_L{1,1}=mean(NATURE_women.adult(i).GRF_AP_L{:,4:end});
%         NATURE_women.adult(i).mean_GRF_L{1,2}=mean(NATURE_women.adult(i).GRF_V_L{:,4:end});
%         NATURE_women.adult(i).mean_GRF_L{1,3}=mean(NATURE_women.adult(i).GRF_ML_L{:,4:end});
% end
%olderAdult
[NATURE_women.olderAdult] = mean_sd(NATURE_women.olderAdult);
% for i=1:size(NATURE_women.olderAdult,2)    
%         NATURE_women.olderAdult(i).mean_GRF_R{1,1}=mean(NATURE_women.olderAdult(i).GRF_AP_R{:,4:end});
%         NATURE_women.olderAdult(i).mean_GRF_R{1,2}=mean(NATURE_women.olderAdult(i).GRF_V_R{:,4:end});
%         NATURE_women.olderAdult(i).mean_GRF_R{1,3}=mean(NATURE_women.olderAdult(i).GRF_ML_R{:,4:end});
%         NATURE_women.olderAdult(i).mean_GRF_L{1,1}=mean(NATURE_women.olderAdult(i).GRF_AP_L{:,4:end});
%         NATURE_women.olderAdult(i).mean_GRF_L{1,2}=mean(NATURE_women.olderAdult(i).GRF_V_L{:,4:end});
%         NATURE_women.olderAdult(i).mean_GRF_L{1,3}=mean(NATURE_women.olderAdult(i).GRF_ML_L{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_R{1,1}=sd(NATURE_women.olderAdult(i).GRF_AP_R{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_R{1,2}=sd(NATURE_women.olderAdult(i).GRF_V_R{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_R{1,3}=sd(NATURE_women.olderAdult(i).GRF_ML_R{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_L{1,1}=sd(NATURE_women.olderAdult(i).GRF_AP_L{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_L{1,2}=sd(NATURE_women.olderAdult(i).GRF_V_L{:,4:end});
%         NATURE_women.olderAdult(i).std_GRF_L{1,3}=sd(NATURE_women.olderAdult(i).GRF_ML_L{:,4:end});
% end

%% mean of Right and left
%young
for i=1:size(NATURE_women.young,2)    
        NATURE_women.young(i).mean_GRF_RL{1,1}=mean(vertcat(NATURE_women.young(i).mean_GRF_R{1,1},NATURE_women.young(i).mean_GRF_L{1,1}));
        NATURE_women.young(i).mean_GRF_RL{1,2}=mean(vertcat(NATURE_women.young(i).mean_GRF_R{1,2},NATURE_women.young(i).mean_GRF_L{1,2}));
        NATURE_women.young(i).mean_GRF_RL{1,3}=mean(vertcat(NATURE_women.young(i).mean_GRF_R{1,3},NATURE_women.young(i).mean_GRF_L{1,3}));
end
%adults
for i=1:size(NATURE_women.adult,2)    
        NATURE_women.adult(i).mean_GRF_RL{1,1}=mean(vertcat(NATURE_women.adult(i).mean_GRF_R{1,1},NATURE_women.adult(i).mean_GRF_L{1,1}));
        NATURE_women.adult(i).mean_GRF_RL{1,2}=mean(vertcat(NATURE_women.adult(i).mean_GRF_R{1,2},NATURE_women.adult(i).mean_GRF_L{1,2}));
        NATURE_women.adult(i).mean_GRF_RL{1,3}=mean(vertcat(NATURE_women.adult(i).mean_GRF_R{1,3},NATURE_women.adult(i).mean_GRF_L{1,3}));
end
%older adults
for i=1:size(NATURE_women.olderAdult,2)    
        NATURE_women.olderAdult(i).mean_GRF_RL{1,1}=mean(vertcat(NATURE_women.olderAdult(i).mean_GRF_R{1,1},NATURE_women.olderAdult(i).mean_GRF_L{1,1}));
        NATURE_women.olderAdult(i).mean_GRF_RL{1,2}=mean(vertcat(NATURE_women.olderAdult(i).mean_GRF_R{1,2},NATURE_women.olderAdult(i).mean_GRF_L{1,2}));
        NATURE_women.olderAdult(i).mean_GRF_RL{1,3}=mean(vertcat(NATURE_women.olderAdult(i).mean_GRF_R{1,3},NATURE_women.olderAdult(i).mean_GRF_L{1,3}));
end

%% do random selection of 12 participants of each group

NATURE_women12.young=datasample(NATURE_women.young ,12);
NATURE_women12.adult=datasample(NATURE_women.adult ,12);
NATURE_women12.olderAdult=datasample(NATURE_women.olderAdult ,12);

save('NATURE_women12.mat','NATURE_women12')
save('NATURE_women.mat','NATURE_women')



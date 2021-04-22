clear;close all;clc;
nature_data=load('CONTROLS_nature.mat');
%filter by sex, ascending (0:female --> 1:male)
nature_data.Controls.Annotation = sortrows(nature_data.Controls.Annotation,'SEX','ascend');
%initialize empty cells for speed; %true?
id_females_repeated={[]}; index_annotation={[]}; is_equal_ID={[]}; index_women={[]}; 
% GRF_F_PRO_AP_R_women={[]}; GRF_F_PRO_V_R_women={[]}; GRF_F_PRO_ML_R_women={[]}; 
% GRF_F_PRO_AP_L_women={[]}; GRF_F_PRO_V_L_women={[]}; GRF_F_PRO_ML_L_women={[]};
 
c=0; %initialize counter for saving indeces of specified sex;
DIM=size(nature_data.Controls.Annotation);
for k=1:DIM(1,1) % 1 to the last row of control data;
    
     if nature_data.Controls.Annotation.SEX(k)==0% 0:female 1:male;
         c=c+1;
         id_females_repeated{c}=nature_data.Controls.Annotation.SUBJECT_ID(k);
         nature_data_W.annotation(c,:)=nature_data.Controls.Annotation(k,:);
     end
      
end
  aux=vertcat(id_females_repeated{1,:});
  ID_FEMME=unique(aux);

d=0;
  for j= 1: height(nature_data.Controls.GRF_F_AP_PRO_R_HC)
     for k = 1:length(ID_FEMME)
         is_equal_ID{j,k}=isequal(nature_data.Controls.GRF_F_AP_PRO_R_HC{j,'SUBJECT_ID'},ID_FEMME(k,1)); 
         if is_equal_ID{j,k}==1
             d=d+1;
             index_women{d}=j;
         end
     end
  end
%  
 for d=1:length(index_women)
 nature_data_W.GRF_F_PRO_AP_R_women(d,:)=nature_data.Controls.GRF_F_AP_PRO_R_HC(index_women{d},:);
 nature_data_W.GRF_F_PRO_V_R_women(d,:)=nature_data.Controls.GRF_F_V_PRO_R_HC(index_women{d},:);
 nature_data_W.GRF_F_PRO_ML_R_women(d,:)=nature_data.Controls.GRF_F_ML_PRO_R_HC(index_women{d},:);
 nature_data_W.GRF_F_PRO_AP_L_women(d,:)=nature_data.Controls.GRF_F_AP_PRO_L_HC(index_women{d},:);
 nature_data_W.GRF_F_PRO_V_L_women(d,:)=nature_data.Controls.GRF_F_V_PRO_L_HC(index_women{d},:);
 nature_data_W.GRF_F_PRO_ML_L_women(d,:)=nature_data.Controls.GRF_F_ML_PRO_L_HC(index_women{d},:);
 end
% 
% nature_data_women.GRF_F_AP_PRO_R=GRF_F_PRO_AP_R_women};
% nature_data_women.GRF_F_V_PRO_R=GRF_F_PRO_V_R_women;
% nature_data_women.GRF_F_ML_PRO_R=GRF_F_PRO_ML_R_women;
% nature_data_women.GRF_F_AP_PRO_L=GRF_F_PRO_AP_L_women;
% nature_data_women.GRF_F_V_PRO_L=GRF_F_PRO_V_L_women;
% nature_data_women.GRF_F_ML_PRO_L=GRF_F_PRO_ML_L_women;
%  
save('NATURE_Women_HealthyControls.mat','nature_data_W');
women=load('NATURE_Women_HealthyControls.mat');
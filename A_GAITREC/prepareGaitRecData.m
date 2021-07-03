clear;close all;clc;
GAITREC_data=load('CONTROLS_GAITREC.mat');
%filter by sex, ascending (0:female --> 1:male)
GAITREC_data.Controls.Annotation = sortrows(GAITREC_data.Controls.Annotation,'SEX','ascend');
%initialize empty cells for speed; %true?
id_females_repeated={[]}; index_annotation={[]}; is_equal_ID={[]}; index_women={[]};

c=0; %initialize counter for saving indeces of specified sex;
DIM=size(GAITREC_data.Controls.Annotation);
for k=1:DIM(1,1) % 1 to the last row of control data;
    
    if GAITREC_data.Controls.Annotation.SEX(k)==0% 0:female 1:male;
        c=c+1;
        id_females_repeated{c}=GAITREC_data.Controls.Annotation.SUBJECT_ID(k);
        GAITREC_data_W.annotation(c,:)=GAITREC_data.Controls.Annotation(k,:);
    end
    
end
aux=vertcat(id_females_repeated{1,:});
ID_FEMME=unique(aux);

d=0;
for j= 1: height(GAITREC_data.Controls.GRF_F_AP_PRO_R_HC)
    for k = 1:length(ID_FEMME)
        is_equal_ID{j,k}=isequal(GAITREC_data.Controls.GRF_F_AP_PRO_R_HC{j,'SUBJECT_ID'},ID_FEMME(k,1));
        if is_equal_ID{j,k}==1
            d=d+1;
            index_women{d}=j;
        end
    end
end

for d=1:length(index_women)
    GAITREC_data_W.GRF_F_PRO_AP_R_women(d,:)=GAITREC_data.Controls.GRF_F_AP_PRO_R_HC(index_women{d},:);
    GAITREC_data_W.GRF_F_PRO_V_R_women(d,:)=GAITREC_data.Controls.GRF_F_V_PRO_R_HC(index_women{d},:);
    GAITREC_data_W.GRF_F_PRO_ML_R_women(d,:)=GAITREC_data.Controls.GRF_F_ML_PRO_R_HC(index_women{d},:);
    GAITREC_data_W.GRF_F_PRO_AP_L_women(d,:)=GAITREC_data.Controls.GRF_F_AP_PRO_L_HC(index_women{d},:);
    GAITREC_data_W.GRF_F_PRO_V_L_women(d,:)=GAITREC_data.Controls.GRF_F_V_PRO_L_HC(index_women{d},:);
    GAITREC_data_W.GRF_F_PRO_ML_L_women(d,:)=GAITREC_data.Controls.GRF_F_ML_PRO_L_HC(index_women{d},:);
end


save('GAITREC_Women_HealthyControls.mat','GAITREC_data_W');
%% THE END

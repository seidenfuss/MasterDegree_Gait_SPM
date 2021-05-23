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

%meta_nature_W2=orderfields(meta_nature_W2.AGE);

% suppose 's' is the struct array and you want to sort it by the values in field 'f_sortby'
[x,idx]=sort([meta_nature_W2.AGE]);
meta_nature_W2=meta_nature_W2(idx);
   
%% separate by age groups

%young(15-25)
NATURE_women.young=meta_nature_W2(1:29);
%adults(26-45)
NATURE_women.adult=meta_nature_W2(30:77);
%older_adults(46-)
NATURE_women.olderAdult=meta_nature_W2(78:105);

save('NATURE_women.mat','NATURE_women')
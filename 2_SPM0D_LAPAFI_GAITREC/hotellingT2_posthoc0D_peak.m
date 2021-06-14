function [spm,spmi, spm_sidak,spmi_sidak]=hotellingT2_posthoc0D_peak(data1,data2)
dim=size(data1,2);

%(1) first peak anterior posterior  force (discrete_GRF.min_AP_R)
%(2) first peak vertical force (discrete_GRF.peak1_V_R)
%(3) first peak lateral force (discrete_GRF.peak1_ML_R)



for i=1:dim
    yA(i,1)=data1(i).min_AP_RL;
    yA(i,2)=data1(i).peak1_V_RL;
    yA(i,3)=data1(i).peak1_ML_RL;
    
    yB(i,1)=data2(i).min_AP_RL;
    yB(i,2)=data2(i).peak1_V_RL;
    yB(i,3)=data2(i).peak1_ML_RL;
end

%(1) Conduct test using spm1d:

spm  = spm1d.stats.hotellings2(yA, yB);
spmi = spm.inference(0.05);
disp(spmi)

%sidak correction ttest - paired

% Conduct post hoc test using spm1d:
if spmi.h0reject==1
    for d = 1:3
        spm_sidak(1,d)  = spm1d.stats.ttest2(yA(:,d), yB(:,d));
        p_sidak=0.0170;
        spmi_sidak(1,d) =spm_sidak(1,d).inference(p_sidak, 'two_tailed', true);
        
        disp(spmi_sidak(1,d))
    end
else
    spm_sidak="not necessary";
    spmi_sidak="not necessary";
end
end

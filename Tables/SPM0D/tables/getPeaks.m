 function [yA_peak, yA_impulse] = getPeaks(data)
 dim=size(data,2);
  
for i=1:dim
    yA_impulse(i,1)=data(i).total_imp_AP_RL;
    yA_impulse(i,2)=data(i).total_imp_V_RL;
    yA_impulse(i,3)=data(i).total_imp_ML_RL;    
end

for i=1:dim
    yA_peak(i,1)=data(i).min_AP_RL;
    yA_peak(i,2)=data(i).peak1_V_RL;
    yA_peak(i,3)=data(i).valley1_ML_RL;
    
end
 end
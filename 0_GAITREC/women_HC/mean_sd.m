function [data] = mean_sd(data)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(data,2)    
        data(i).mean_GRF_R{1,1}=mean(data(i).GRF_AP_R{:,4:end});
        data(i).mean_GRF_R{1,2}=mean(data(i).GRF_V_R{:,4:end});
        data(i).mean_GRF_R{1,3}=mean(data(i).GRF_ML_R{:,4:end});
        data(i).mean_GRF_L{1,1}=mean(data(i).GRF_AP_L{:,4:end});
        data(i).mean_GRF_L{1,2}=mean(data(i).GRF_V_L{:,4:end});
        data(i).mean_GRF_L{1,3}=mean(data(i).GRF_ML_L{:,4:end});
        data(i).std_GRF_R{1,1}=std(data(i).GRF_AP_R{:,4:end});
        data(i).std_GRF_R{1,2}=std(data(i).GRF_V_R{:,4:end});
        data(i).std_GRF_R{1,3}=std(data(i).GRF_ML_R{:,4:end});
        data(i).std_GRF_L{1,1}=std(data(i).GRF_AP_L{:,4:end});
        data(i).std_GRF_L{1,2}=std(data(i).GRF_V_L{:,4:end});
        data(i).std_GRF_L{1,3}=std(data(i).GRF_ML_L{:,4:end});
end
end


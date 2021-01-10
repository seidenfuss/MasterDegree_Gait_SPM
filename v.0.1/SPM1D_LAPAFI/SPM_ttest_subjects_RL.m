clear; clc; close all;
load('elderly_metadata_GRF.mat');
mu=0;
yR={[]}; yL={[]}; spm_R={[]}; spm_L={[]}; spmi_R={[]};spmi_L={[]};
%for i =1: length(elderly_metadata)

for i =8
    figure()
            for d=1:3
                    yR{i,d}=abs(elderly_metadata(i).GRF_R_corrFilter97{1, 1}{1, d});
            yL{i,d}=abs(elderly_metadata(i).GRF_L_corrFilter97{1, 1}{1, d});
            spm_R{i,d}       = spm1d.stats.ttest(yR{i,d} - mu);
            spmi_R{i,d}      = spm_R{i,d}.inference(0.05, 'two_tailed',false);
            subplot(2,3,d) 
            spmi_R{i,d}.plot();
            spmi_R{i,d}.plot_threshold_label();
            spmi_R{i,d}.plot_p_values();
            
            subplot(2,3,d+3)
            spm_L{i,d}       = spm1d.stats.ttest(yL{i,d} - mu);
            spmi_L{i,d}      = spm_L{i,d}.inference(0.05, 'two_tailed',false);
            spmi_L{i,d}.plot();
            spmi_L{i,d}.plot_threshold_label();
            spmi_L{i,d}.plot_p_values();    
        end
   
end

%(2) Plot:
%close all

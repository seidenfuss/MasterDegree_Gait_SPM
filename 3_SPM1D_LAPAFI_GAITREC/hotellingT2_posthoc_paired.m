function [spm,spmi,spm_sidak,spmi_sidak] = hotellingT2_posthoc_paired(data,label_part,legend1,legend2,legend3,legend4)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:size(data,2)
    YR(i,:,1)=mean(data(i).GRF_AP_R{:,4:end});
    YR(i,:,2)=mean(data(i).GRF_V_R{:,4:end});
    YR(i,:,3)=mean(data(i).GRF_ML_R{:,4:end});
    YL(i,:,1)=mean(data(i).GRF_AP_L{:,4:end});
    YL(i,:,2)=mean(data(i).GRF_V_L{:,4:end});
    YL(i,:,3)=mean(data(i).GRF_ML_L{:,4:end});
end

%(1) Conduct SPM analysis:
spm       = spm1d.stats.hotellings_paired(YR, YL);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot: Mean_SD and T2

figure('position', [0 0 2000 600])
for d=1:3
    my_string=[" Anterior(+) Posterior(-)"," Vertical(+)","Medial(+) Lateral(-)"];
    
    subplot(2,3,d)
    spm1d.plot.plot_meanSD(YR(:,:,d), 'color','b');
    hold on
    spm1d.plot.plot_meanSD(YL(:,:,d), 'color','r');
    
    title(strcat('Mean and SD: ',my_string(d)));
    xlabel("Stance Phase (%)");
    ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
    legend({legend1,legend2,legend3,legend4},'Location','Best')
    
end

subplot(2, 3, 4:6)
spmi.plot();
spmi.plot_threshold_label();
spmi.plot_p_values();
title('Hotelling T2 Paired')
xlabel("Stance Phase (%)");
sgtitle(strcat(label_part, '- GRF Walking - GAITREC Database'))

spm_sidak={[]};
spmi_sidak={[]};

if spmi.h0reject == 1
    %% Sidak correction ----- t-test paired
    alpha=0.05;
    p_value=1-((1-alpha)^(1/3));
    
    figure('position', [0 0 2000 600])
    
    %(0) assign dataset:
    Y_R={[]};
    Y_L={[]};
    
    for d=1:3
        my_string=[" Anterior-Posterior"," Vertical"," Medio-Lateral"];
        
        for i=1:size(data,2)
            YY_R{i,d}=abs(YR(i,:,d));
            YY_L{i,d}=abs(YL(i,:,d));
        end
        
        Y_R{1,d}=vertcat(YY_R{:,d});
        Y_L{1,d}=vertcat(YY_L{:,d});
        
        spm_sidak{1,d}       = spm1d.stats.ttest_paired(Y_R{1,d},Y_L{1,d});
        spmi_sidak{1,d}      = spm_sidak{1,d}.inference(p_value, 'two_tailed', true, 'interp',true);
        disp(spmi_sidak{1,d})
        
        %(2) Plot:
        % plot mean and SD:
        subplot(2,3,d)
        spm1d.plot.plot_meanSD(Y_R{1,d}, 'color','b');
        hold on
        spm1d.plot.plot_meanSD(Y_L{1,d}, 'color','r');
        title(strcat(' GRF -',my_string(d)));
        xlabel("Stance Phase (%)");
        ylabel("$|\bf\frac{GRF(N)}{Weight(N)}|$",'interpreter','latex');
        legend({legend1,legend2,legend3,legend4},'Location','Best')
        
        %%% plot SPM results:
        subplot(2,3,d+3)
        spmi_sidak{1,d}.plot();
        spmi_sidak{1,d}.plot_threshold_label();
        spmi_sidak{1,d}.plot_p_values();
        title(strcat('Paired t-test:' ,my_string(d)));
        xlabel("Stance Phase (%)");
        
        sgtitle(strcat(label_part,'- GAITREC Database: Post-hoc - Šidák p-value: 0.0170'))
        
    end
end
end


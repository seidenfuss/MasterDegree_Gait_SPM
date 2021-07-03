function [spm,spmi,spm_sidak,spmi_sidak] = hotellingT2_posthoc(dataA,dataB,label_part,legend1,legend2,legend3,legend4)

for i=1:size(dataA,2)
    YA(i,:,1)=dataA(i).mean_GRF_RL{1, 1};
    YA(i,:,2)=dataA(i).mean_GRF_RL{1, 2};
    YA(i,:,3)=dataA(i).mean_GRF_RL{1, 3};
    
    YB(i,:,1)=dataB(i).mean_GRF_RL{1, 1};
    YB(i,:,2)=dataB(i).mean_GRF_RL{1, 2};
    YB(i,:,3)=dataB(i).mean_GRF_RL{1, 3};
end

%(1) Conduct SPM analysis:

spm       = spm1d.stats.hotellings2(YA, YB);
spmi      = spm.inference(0.05);
disp(spmi)

%(2) Plot - Mean_SD and T2

figure('position', [0 0 2000 600])
for d=1:3
    my_string=[" Anterior(+) Posterior(-)"," Vertical(+)","Medial(+) Lateral(-)"];
    
    subplot(2,3,d)
    spm1d.plot.plot_meanSD(YA(:,:,d), 'color','k');
    hold on
    
    spm1d.plot.plot_meanSD(YB(:,:,d), 'color','r');
    title(strcat('Mean and SD: ',my_string(d)));
    xlabel("Stance Phase (%)");
    ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
    legend({legend1,legend2,legend3,legend4},'Location','Best');
end

subplot(2, 3, 4:6)

spmi.plot();
spmi.plot_threshold_label();
spmi.plot_p_values();

title('Hotelling T2')
xlabel("Stance Phase (%)");
sgtitle(strcat(label_part, ' - GRF Walking'))

spm_sidak={[]};
spmi_sidak={[]};
if spmi.h0reject == 1
    %% Sidak correction t-test paired
    alpha=0.05;
    p_value=1-((1-alpha)^(1/3));
    
    figure('position', [0 0 2000 600])
    
    %(0) assign dataset:
    
    for d=1:3
        my_string=[" Anterior-Posterior"," Vertical"," Medio-Lateral"];
        
        for i=1:size(dataA,2)
            YY_A{i,d}=abs(YA(i,:,d));
            YY_B{i,d}=abs(YB(i,:,d));
        end
        
        Y_A{1,d}=vertcat(YY_A{:,d});
        Y_B{1,d}=vertcat(YY_B{:,d});
    end
    for d=1:3
        
        
        spm_sidak{1,d}       = spm1d.stats.ttest2(Y_A{1,d},Y_B{1,d});
        spmi_sidak{1,d}      = spm_sidak{1,d}.inference(p_value, 'two_tailed', true, 'interp',true);
        disp(spmi_sidak{1,d})
        
        %(2) Plot:
        % plot mean and SD:
        
        subplot(2,3,d)
        
        spm1d.plot.plot_meanSD(Y_A{1,d}, 'color','k');
        hold on
        spm1d.plot.plot_meanSD(Y_B{1,d}, 'color','r');
        
        title(strcat(' GRF -',my_string(d)));
        xlabel("Stance Phase (%)");
        ylabel("$|\bf\frac{GRF(N)}{Weight(N)}|$",'interpreter','latex');
        legend({legend1,legend2,legend3,legend4},'Location','Best');
        %%% plot SPM results:
        subplot(2,3,d+3)
        
        spmi_sidak{1,d}.plot();
        spmi_sidak{1,d}.plot_threshold_label();
        spmi_sidak{1,d}.plot_p_values();
        
        title(strcat('t-test:' ,my_string(d)));
        xlabel("Stance Phase (%)");
        sgtitle(strcat(label_part,' - Post-hoc - Šidák p-value: 0.0170'))
    end
end
end
%% THE END

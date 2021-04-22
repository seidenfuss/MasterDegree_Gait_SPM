clear;
close all;
clc;
%Hotellings T2
%(0) Load data:
load('meanSD_elderly_LAPAFI.mat');
for i=1:size(meanSD_elderly_LAPAFI,2)    
    for d=1:3
        YR(i,:,d)=meanSD_elderly_LAPAFI(i).mean_GRF_R{1, d}(1,:);
        YL(i,:,d)=meanSD_elderly_LAPAFI(i).mean_GRF_L{1, d}(1,:);
    end
end

%(1) Conduct SPM analysis:
spm       = spm1d.stats.hotellings_paired(YR, YL);
spmi      = spm.inference("two tailed", 'true' ,0.05);
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
end

subplot(2, 3, 4:6)
spmi.plot();
spmi.plot_threshold_label();
spmi.plot_p_values();
title('Hotelling T2')
xlabel("Stance Phase (%)");
sgtitle('Elderly Women - GRF Walking - 14 participants')

%% Sidak correction ----- t-test paired 
alpha=0.05;
p_value=1-((1-alpha)^(1/3));

figure('position', [0 0 2000 600])

%(0) assign dataset:
Y_R={[]};
Y_L={[]};

for d=1:3
    my_string=[" Anterior-Posterior"," Vertical"," Medio-Lateral"];
    %if d<=2
    for i=1:size(meanSD_elderly_LAPAFI,2)
        YY_R{i,d}=abs(meanSD_elderly_LAPAFI(i).mean_GRF_R{1, d}(1,:));
        YY_L{i,d}=abs(meanSD_elderly_LAPAFI(i).mean_GRF_L{1, d}(1,:));
    end
    
    Y_R{1,d}=vertcat(YY_R{:,d});
    Y_L{1,d}=vertcat(YY_L{:,d});
    
    spm_sidak{1,d}       = spm1d.stats.ttest_paired(Y_R{1,d},Y_L{1,d});
    spmi_sidak{1,d}      = spm_sidak{1,d}.inference(p_value, 'two_tailed', false, 'interp',true);
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

    %%% plot SPM results:
    subplot(2,3,d+3)
    spmi_sidak{1,d}.plot();
    spmi_sidak{1,d}.plot_threshold_label();
    spmi_sidak{1,d}.plot_p_values();
    title(strcat('Paired t-test:' ,my_string(d)));
    xlabel("Stance Phase (%)");
    
    sgtitle('Post-hoc - Šidák p-value: 0.0170')
end




function plotStance2(data,d1,d2,stringR,stringL)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dim=size(data,2);
mytitle_R={[]};
mytitle_L={[]};
my_string=[" Anterior Posterior"," Vertical"," Medio Lateral"];
limite=[0.3,1.5,0.3];

for d = 1:3
    figure()
    for i =1:dim
        subplot(d1,d2,i)
        spm1d.plot.plot_meanSD(data(i).GRF_R_corrFilter95{1, 1}{1, d}, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');
        
        if data(i).ID<=9
            title(strcat("ID: 0",num2str(data(i).ID)));
        else
            title(strcat("ID: ",num2str(data(i).ID)));
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
    end
    mytitle_R{d,1}=strcat(stringR,my_string(1,d));
    sgtitle(mytitle_R(d,1));
end

for d = 1:3
    figure()
    for i =1:dim
        subplot(d1,d2,i)
        spm1d.plot.plot_meanSD(data(i).GRF_L_corrFilter95{1, 1}{1, d}, 'color', 'r');hold on;  plot([0 100], [0 0], 'k:');
        
        if data(i).ID<=9
            title(strcat("ID: 0",num2str(data(i).ID)));
        else
            title(strcat("ID: ",num2str(data(i).ID)));
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
    end
    mytitle_L{d,1}=strcat(stringL,my_string(1,d));
    sgtitle(mytitle_L(d,1));
end

end
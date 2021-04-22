close all; clear; clc;
load('meanSD_elderly_LAPAFI.mat'); %data in here - just loading...
dim=size(meanSD_elderly_LAPAFI);

 yR={[]}; yL={[]}; 
 
 for i = 1:dim(1,2)
     for d=1:3
   yR{i,d}      = meanSD_elderly_LAPAFI(1).mean_GRF_R{1, d}(1,:);
   yL{i,d}      = meanSD_elderly_LAPAFI(1).mean_GRF_R{1, d}(1,:);
     end
 end
 
 
%Plotar
 
mytitle_R={[]};
mytitle_L={[]};
my_string=["Anterior Posterior","Vertical","Medio Lateral"];
limite=[0.3,1.5,0.2];
 
 for d = 1:3
 figure()
     for i =1:dim(1,2)
     subplot(2,7,i)
     spm1d.plot.plot_meanSD(yR{i,d}, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');  
    
     if meanSD_elderly_LAPAFI(i).ID<=9
         title(strcat("ID: 0",num2str(meanSD_elderly_LAPAFI(i).ID)));
        else
        title(strcat("ID: ",num2str(meanSD_elderly_LAPAFI(i).ID)));    
    end
         ylim([-0.3 limite(d)])
         xlabel("Stance Phase (%)");
         ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');        
    end
    mytitle_R{d,1}=strcat("Mean and SD (GRF Right) - ",my_string(1,d));
    sgtitle(mytitle_R(d,1));
end
 
 for d = 1:3
 figure()
     for i =1:dim(1,2)
     subplot(2,7,i)
     spm1d.plot.plot_meanSD(yL{i,d}, 'color', 'r'); hold on;  plot([0 100], [0 0], 'k:');  
    
     if meanSD_elderly_LAPAFI(i).ID<=9
         title(strcat("ID: 0",num2str(meanSD_elderly_LAPAFI(i).ID)));
        else
        title(strcat("ID: ",num2str(meanSD_elderly_LAPAFI(i).ID)));    
    end
         ylim([-0.3 limite(d)])
         xlabel("Stance Phase (%)");
         ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');        
    end
    mytitle_L{d,1}=strcat("Mean and SD (GRF Left) ",my_string(1,d));
    sgtitle(mytitle_L(d,1));
end

%Following Vaverka's study 2015

%% find peaks, valleys, zeros, and its timestamps...

%Anterior-Posterior
    %max,min
    %zeros

%Vertical
    %min
    %max between begin and min
    %max between min and end
    %zeros

%Medio Lateral
    %find a logic... 
    %zeros
    %

%% impulses

%AP
    %total
    %breaking
    %propulsive

%V
    %total
    %first half
    %second half
    %early stance
    %mid stance
    %late stance

%ML
    %total
    %divide into 4 spaces if possible:

%trapz
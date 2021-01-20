%
%% mean and SD LAPAFI curves
close all;
clear;  
clc;

% (-1) Initialize variables for speed improvement
yR={[]}; yL={[]}; 

%(0) Load dataset:
load('elderly_metadata_GRF.mat'); %data in here - just loading...
dim=size(elderly_metadata1);

for i = 1:dim(1,2)
    for d=1:3
  yR{i,1}{1,d}      = (elderly_metadata1(i).GRF_R_corrFilter95{1, 1}{1, d});
  yL{i,1}{1,d}      = (elderly_metadata1(i).GRF_L_corrFilter95{1, 1}{1, d});
 mu0     = 0;    %null criterion
   end
end


for i=1:dim(1,2)
    for d=1:3
    mean_GRF_R{i,d} = mean(yR{i,1}{1,d},1); 
    std_GRF_R{i,d}=std(yR{i,1}{1,d},1);
    mean_GRF_L{i,d} = mean(yL{i,1}{1,d},1); 
    std_GRF_L{i,d}=std(yL{i,1}{1,d},1);
    
    meanSD_elderly_LAPAFI(i).mean_GRF_R{1,d}= mean_GRF_R{i,d}; 
    meanSD_elderly_LAPAFI(i).std_GRF_R{1,d}=std_GRF_R{i,d};
    meanSD_elderly_LAPAFI(i).mean_GRF_L{1,d}=mean_GRF_L{i,d}; 
    meanSD_elderly_LAPAFI(i).std_GRF_L{1,d}=std_GRF_L{i,d};
    end
end

save('meanSD_elderly_LAPAFI.mat','meanSD_elderly_LAPAFI')

mytitle_R={[]};
mytitle_L={[]};
my_string=["Anterior Posterior","Vertical","Medio Lateral"];
limite=[0.3,1.5,0.3];
for d = 1:3
figure()
    for i =1:dim(1,2)
    subplot(2,7,i)
    spm1d.plot.plot_meanSD(yR{i,1}{1,d} - mu0, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');  
            if elderly_metadata1(i).ID<=9
            title(strcat("ID: 0",num2str(elderly_metadata1(i).ID)));
        else
            title(strcat("ID: ",num2str(elderly_metadata1(i).ID)));    
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
         
    end
    
    
    
    
    
    
    mytitle_R{d,1}=strcat("Mean and SD (|GRF Right| - mu0) - ",my_string(1,d));
    sgtitle(mytitle_R(d,1));
end

for d = 1:3
figure()
    for i =1:dim(1,2)
    subplot(2,7,i)
    spm1d.plot.plot_meanSD(yL{i,1}{1,d} - mu0, 'color', 'r'); hold on;  plot([0 100], [0 0], 'k:');  
   
    if elderly_metadata1(i).ID<=9
        title(strcat("ID: 0",num2str(elderly_metadata1(i).ID)));
        else
        title(strcat("ID: ",num2str(elderly_metadata1(i).ID)));    
    end
         ylim([-0.3 limite(d)])
         xlabel("Stance Phase (%)");
         ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
         
         
    end
    mytitle_L{d,1}=strcat("Mean and SD (|GRF Left| - mu0) - ",my_string(1,d));
    sgtitle(mytitle_L(d,1));
end
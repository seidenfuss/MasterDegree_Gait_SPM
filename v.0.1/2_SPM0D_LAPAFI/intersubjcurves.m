close all; clear; clc;
load('elderly_GRF_proc.mat'); %All curves data here: combine it after removing uncorrelated mean curves
%load('meanSD_elderly_LAPAFI.mat'); %GRF mean data in here: loading...

dim=size(elderly_GRF_proc);

yR={[]}; yL={[]}; 

 for i = 1:dim(1,2)
 yR{i,4}= elderly_GRF_proc(i).ID;
 yL{i,4}= elderly_GRF_proc(i).ID;
     for d=1:3
   yR{i,d} = elderly_GRF_proc(i).mean_GRF_R{1, d}(1,:);
   yL{i,d} = elderly_GRF_proc(i).mean_GRF_L{1, d}(1,:);
     end
 end
 
% %Plot
mytitle_R={[]};
mytitle_L={[]};
my_string=["Anterior Posterior","Vertical","Medio Lateral"];
limite=[0.3,1.5,0.3];
 
 for d = 1:3
 figure()
     for i =1:dim(1,2)
        subplot(2,7,i)
        spm1d.plot.plot_meanSD(elderly_GRF_proc(i).GRF_R_corrFilter95{1, 1}{1, d}, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');  
    
        if elderly_GRF_proc(i).ID<=9
            title(strcat("ID: 0",num2str(elderly_GRF_proc(i).ID)));
        else
            title(strcat("ID: ",num2str(elderly_GRF_proc(i).ID)));    
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
        spm1d.plot.plot_meanSD(elderly_GRF_proc(i).GRF_L_corrFilter95{1, 1}{1, d}, 'color', 'r');hold on;  plot([0 100], [0 0], 'k:');  
    
     if elderly_GRF_proc(i).ID<=9
         title(strcat("ID: 0",num2str(elderly_GRF_proc(i).ID)));
     else
         title(strcat("ID: ",num2str(elderly_GRF_proc(i).ID)));    
     end
         ylim([-0.3 limite(d)])
         xlabel("Stance Phase (%)");
         ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');        
    end
    mytitle_L{d,1}=strcat("Mean and SD (GRF Left) ",my_string(1,d));
    sgtitle(mytitle_L(d,1));
 end
 
 
%% Remove curves that differ between participants 
% (because we don't know why it is so different, for example participant 10 does not show peaks
% we don't know if it was because of speed for example, because we have not measured speed directly)

[matrix_opt_R] = corrFilter2(yR, 0.85);
[matrix_opt_L] = corrFilter2(yL, 0.85);
[matrix_opt_R1] = corrFilter2(matrix_opt_R, 0.90);
[matrix_opt_L1] = corrFilter2(matrix_opt_L, 0.90);
 
GRF_R=matrix_opt_R1;
GRF_L=matrix_opt_L1;
x=0;
for i = 1:size(elderly_GRF_proc,2)
    check_subj=elderly_GRF_proc(i).ID;
    for j = 1: size(matrix_opt_R1)
        keep_subj=matrix_opt_R1{j,4};
        if check_subj==keep_subj
            x=x+1;
            elderly_subj_final(j)=elderly_GRF_proc(i);
            indices(x)=i;
        end   
    end
end

 for i = 1:size(GRF_R,1)
    elderly_subj_final(i).mean_GRF_R=GRF_R(i,1:3);
    elderly_subj_final(i).mean_GRF_L=GRF_L(i,1:3);
    elderly_subj_final(i).sd_GRF_R=elderly_GRF_proc(indices(i)).std_GRF_R;
    elderly_subj_final(i).sd_GRF_L=elderly_GRF_proc(indices(i)).std_GRF_L;   
 end

 save('elderly_subj_final.mat','elderly_subj_final')
 
%plot the remaining participants
 for d = 1:3
 figure()
     for i =1:size(matrix_opt_R1,1)
        subplot(2,6,i)
        spm1d.plot.plot_meanSD(elderly_subj_final(i).GRF_R_corrFilter95{1, 1}{1, d}, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');  
        id=elderly_subj_final(i).ID;
        if id<=9
            title(strcat("ID: 0",num2str(id)));
        else
            title(strcat("ID: ",num2str(id)));    
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');        
     end
     mytitle_R{d,1}=strcat("Mean and SD (GRF Right) - after corrFilter2 ",my_string(1,d));
     sgtitle(mytitle_R(d,1));
 end
 
  for d = 1:3
 figure()
     for i =1:size(matrix_opt_L1,1)
        subplot(2,6,i)
        spm1d.plot.plot_meanSD(elderly_subj_final(i).GRF_L_corrFilter95{1, 1}{1, d}, 'color', 'r'); hold on;  plot([0 100], [0 0], 'k:');  
        id=elderly_subj_final(i).ID;
        if id<=9
            title(strcat("ID: 0",num2str(id)));
        else
            title(strcat("ID: ",num2str(id)));    
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');        
     end
     mytitle_L{d,1}=strcat("Mean and SD (GRF Left) - after corrFilter2 ",my_string(1,d));
     sgtitle(mytitle_L(d,1));
 end

 
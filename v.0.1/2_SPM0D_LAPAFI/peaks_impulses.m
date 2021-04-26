%% Found Anterior posterior valley and peak by using max and min functions, thats all, piece of cake.
%% Found vertical peaks by using the function max between 1 and 50 for first peak,
%and between 50 and 100 for second peak 
%(summing to 50, because it gets the index of new vector of only 50 elements 
%and we want the position from 100)
%For valley we searched between the position of peak 1 and peak two, 
%summing to the position of peak one to get the relative position for the 
%100 elements vector.
%% Medio Lateral is going to be a little tought: 

close all; clear; clc;
load('meanSD_elderly_LAPAFI.mat'); %data in here - just loading...
dim=size(meanSD_elderly_LAPAFI);

 yR={[]}; yL={[]}; 

 for i = 1:dim(1,2)
 yR{i,4}= meanSD_elderly_LAPAFI(i).ID;
 yL{i,4}= meanSD_elderly_LAPAFI(i).ID;
     for d=1:3
   yR{i,d} = meanSD_elderly_LAPAFI(i).mean_GRF_R{1, d}(1,:);
   yL{i,d} = meanSD_elderly_LAPAFI(i).mean_GRF_L{1, d}(1,:);
     end
 end
 
%Plot
mytitle_R={[]};
mytitle_L={[]};
my_string=["Anterior Posterior","Vertical","Medio Lateral"];
limite=[0.3,1.5,0.3];
 
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
 
 
%% Remove curves that differ between participants 
% (because we don't know why it is so different, for example participant 10 does not show peaks
% we don't know if it was because of speed for example)

[matrix_opt_R] = corrFilter2(yR, 0.85);
[matrix_opt_L] = corrFilter2(yL, 0.85);
[matrix_opt_R1] = corrFilter2(matrix_opt_R, 0.90);
[matrix_opt_L1] = corrFilter2(matrix_opt_R, 0.90);

%plot the remaining participants
 for d = 1:3
 figure()
     for i =1:size(matrix_opt_R1,1)
        subplot(2,6,i)
        spm1d.plot.plot_meanSD(matrix_opt_R1{i,d}, 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');  
        id=matrix_opt_R1{i,4};
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
        spm1d.plot.plot_meanSD(matrix_opt_L1{i,d}, 'color', 'r'); hold on;  plot([0 100], [0 0], 'k:');  
        id=matrix_opt_L1{i,4};
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

%Following Vaverka's study 2015

%% find peaks, valleys, zeros, and its timestamps...

GRF_R=matrix_opt_R1;
GRF_L=matrix_opt_L1;


%Anterior-Posterior
    %max,min
    for i =1: size(GRF_R,1)
        elderly(i).ID=GRF_L{i,4};
        [elderly(i).min_AP_R,elderly(i).locmin_AP_R]=min(GRF_R{i,1});
        [elderly(i).max_AP_R,elderly(i).locmax_AP_R]=max(GRF_R{i,1});
    end
    for i =1: size(GRF_L,1)
        [elderly(i).min_AP_L,elderly(i).locmin_AP_L]=min(GRF_L{i,1});
        [elderly(i).max_AP_L,elderly(i).locmax_AP_L]=max(GRF_L{i,1});
    end
    %zeros

    
%Vertical 
    %peaks
    for i =1: size(GRF_R,1)
        [elderly(i).peak1_V_R,elderly(i).locpeak1_V_R]=max(GRF_R{i,2}(1,1:50));
        [elderly(i).peak2_V_R,elderly(i).locpeak2_V_R]=max(GRF_R{i,2}(1,50:100));
        elderly(i).locpeak2_V_R=elderly(i).locpeak2_V_R+50;
    end
    
    %valley (mid stance)
     for i =1: size(GRF_R,1)
        [elderly(i).valley_V_R,elderly(i).locvalley_V_R]=min(GRF_R{i,2}(1,elderly(i).locpeak1_V_R:elderly(i).locpeak2_V_R));
        elderly(i).locvalley_V_R=elderly(i).locvalley_V_R+elderly(i).locpeak1_V_R;
    end
    
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
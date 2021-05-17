%% Found Anterior posterior valley and peak by using max and min functions, thats all, piece of cake.
%% Found vertical peaks by using the function max between 1 and 50 for first peak,
%and between 50 and 100 for second peak 
%(summing to 50, because it gets the index of new vector of only 50 elements 
%and we want the position from 100)
%For valley we searched between the position of peak 1 and peak two, 
%summing to the position of peak one to get the relative position for the 
%100 elements vector.
%% Medio Lateral 

close all; clear; clc;
load('elderly_subj_final.mat');
dim=size(elderly_subj_final);

%% find peaks, valleys, zeros, and its timestamps...
GRF_R={[]}; GRF_L={[]};
for l=1:3
    for i=1:dim(1,2)
GRF_R{i,l}=elderly_subj_final(i).mean_GRF_R{1, l};  
GRF_L{i,l}=elderly_subj_final(i).mean_GRF_L{1, l}; 
    end
end

%Anterior-Posterior
    %max,min
    for i =1: size(GRF_R,1)
        discrete_GRF(i).ID=elderly_subj_final(i).ID;
        [discrete_GRF(i).min_AP_R,discrete_GRF(i).locmin_AP_R]=min(GRF_R{i,1});
        [discrete_GRF(i).max_AP_R,discrete_GRF(i).locmax_AP_R]=max(GRF_R{i,1});
    end
    for i =1: size(GRF_L,1)
        [discrete_GRF(i).min_AP_L,discrete_GRF(i).locmin_AP_L]=min(GRF_L{i,1});
        [discrete_GRF(i).max_AP_L,discrete_GRF(i).locmax_AP_L]=max(GRF_L{i,1});
    end
    
    %zeros AP_R

     for i = 1:size(GRF_R,1)
        for k = 2:99
            if GRF_R{i,1}(1,k-1)<0 && GRF_R{i,1}(1,k+1)>0      
               discrete_GRF(i).mid_AP_R=k; 
            end
        end
        for k = 2:discrete_GRF(i).mid_AP_R
               if GRF_R{i,1}(1,k-1)>0 && GRF_R{i,1}(1,k+1)<0      
               discrete_GRF(i).inter1_AP_R=k; 
               end
        end
        for k = discrete_GRF(i).mid_AP_R:99
               if GRF_R{i,1}(1,k-1)>0 && GRF_R{i,1}(1,k+1)<0      
               discrete_GRF(i).inter2_AP_R=k;
               else
                   discrete_GRF(i).inter2_AP_R=100;
               end
        end
        
        
     end

        %zeros AP_L

     for i = 1:size(GRF_L,1)
        for k = 2:99
            if GRF_L{i,1}(1,k-1)<0 && GRF_L{i,1}(1,k+1)>0      
               discrete_GRF(i).mid_AP_L=k; 
            end
        end
        for k = 2:discrete_GRF(i).mid_AP_L
               if GRF_L{i,1}(1,k-1)>0 && GRF_L{i,1}(1,k+1)<0      
               discrete_GRF(i).inter1_AP_L=k; 
               end
        end
        
        for k = discrete_GRF(i).mid_AP_L:99
               if GRF_L{i,1}(1,k-1)>0 && GRF_L{i,1}(1,k+1)<0      
               discrete_GRF(i).inter2_AP_L=k;
               else
                   discrete_GRF(i).inter2_AP_L=100;
               end
        end       
     end

     
%Vertical 
    %peaks and valley right
    for i =1: size(GRF_R,1)
        [discrete_GRF(i).peak1_V_R,discrete_GRF(i).locpeak1_V_R]=max(GRF_R{i,2}(1,1:50));
        [discrete_GRF(i).peak2_V_R,discrete_GRF(i).locpeak2_V_R]=max(GRF_R{i,2}(1,50:100));
        discrete_GRF(i).locpeak2_V_R=discrete_GRF(i).locpeak2_V_R+49; %com dúvida nesse +50 [pq matlab começa em 1]
        [discrete_GRF(i).valley_V_R,discrete_GRF(i).locvalley_V_R]=min(GRF_R{i,2}(1,discrete_GRF(i).locpeak1_V_R:discrete_GRF(i).locpeak2_V_R));
        discrete_GRF(i).locvalley_V_R=discrete_GRF(i).locvalley_V_R+discrete_GRF(i).locpeak1_V_R;
    end
    
    %%peaks and valley left
    for i =1: size(GRF_L,1)
        [discrete_GRF(i).peak1_V_L,discrete_GRF(i).locpeak1_V_L]=max(GRF_L{i,2}(1,1:50));
        [discrete_GRF(i).peak2_V_L,discrete_GRF(i).locpeak2_V_L]=max(GRF_L{i,2}(1,50:100));
        discrete_GRF(i).locpeak2_V_L=discrete_GRF(i).locpeak2_V_L+49; %com dúvida nesse +50 [pq matlab começa indexação em 1]
        [discrete_GRF(i).valley_V_L,discrete_GRF(i).locvalley_V_L]=min(GRF_L{i,2}(1,discrete_GRF(i).locpeak1_V_L:discrete_GRF(i).locpeak2_V_L));
        discrete_GRF(i).locvalley_V_L=discrete_GRF(i).locvalley_V_L+discrete_GRF(i).locpeak1_V_L;
    end
   
    
  
%Medio Lateral
    %find a logic:
    %peak1_ML: max value between 1:50
    %valley1_ML: min value between 1:50
    %valley2_ML: min value between 50:100 (loc +50)  é 50?

    %peaks and valleys ML
    %right
    for i =1: size(GRF_R,1)
        [discrete_GRF(i).peak1_ML_R,discrete_GRF(i).locpeak1_ML_R]=max(GRF_R{i,3}(1,1:50));
        [discrete_GRF(i).valley1_ML_R,discrete_GRF(i).locvalley1_ML_R]=min(GRF_R{i,3}(1,1:50));
        [discrete_GRF(i).valley2_ML_R,discrete_GRF(i).locvalley2_ML_R]=min(GRF_R{i,3}(1,50:100));
        discrete_GRF(i).locvalley2_ML_R=discrete_GRF(i).locvalley2_ML_R+49;
    end
    %left
    for i =1: size(GRF_L,1)
        [discrete_GRF(i).peak1_ML_L,discrete_GRF(i).locpeak1_ML_L]=max(GRF_L{i,3}(1,1:50));
        [discrete_GRF(i).valley1_ML_L,discrete_GRF(i).locvalley1_ML_L]=min(GRF_L{i,3}(1,1:50));
        [discrete_GRF(i).valley2_ML_L,discrete_GRF(i).locvalley2_ML_L]=min(GRF_L{i,3}(1,50:100));
        discrete_GRF(i).locvalley2_ML_L=discrete_GRF(i).locvalley2_ML_L+49;
    end

    %zeros Right
     for i = 1:size(GRF_R,1)
        for k = 2:50
            if GRF_R{i,3}(1,k-1)>0 && GRF_R{i,3}(1,k+1)<0      
               discrete_GRF(i).inter1_ML_R=k; 
            end
        end
        for k=50:99
            if GRF_R{i,3}(1,k-1)<0 && GRF_R{i,3}(1,k+1)>0
               discrete_GRF(i).inter2_ML_R=k;
            end
        end
        
        if isempty(discrete_GRF(i).inter1_ML_R) 
            discrete_GRF(i).inter1_ML_R=1;
        end
        if isempty(discrete_GRF(i).inter2_ML_R)
            discrete_GRF(i).inter2_ML_R=100;
        end
     end
    
     
     %zeros Left
     for i = 1:size(GRF_L,1)
        for k = 2:50
            if GRF_L{i,3}(1,k-1)>0 && GRF_L{i,3}(1,k+1)<0      
               discrete_GRF(i).inter1_ML_L=k; 
            end
        end
        for k=50:99
            if GRF_L{i,3}(1,k-1)<0 && GRF_L{i,3}(1,k+1)>0
               discrete_GRF(i).inter2_ML_L=k;
            end
        end
        
        if isempty(discrete_GRF(i).inter1_ML_L) 
            discrete_GRF(i).inter2_ML_L=1;
        end
        if isempty(discrete_GRF(i).inter2_ML_L)
            discrete_GRF(i).inter2_ML_L=100;
        end
     end
     

%% impulses

%Anterior Posterior
    
    for i = 1:dim(1,2)
    %total
    discrete_GRF(i).total_imp_AP_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 1}(1,discrete_GRF(i).inter1_AP_R:discrete_GRF(i).inter2_AP_R)));
    discrete_GRF(i).total_imp_AP_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 1}(1,discrete_GRF(i).inter1_AP_L:discrete_GRF(i).inter2_AP_L)));
    %breaking    
    discrete_GRF(i).breaking_imp_AP_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 1}(1,discrete_GRF(i).inter1_AP_R:discrete_GRF(i).mid_AP_R)));
    discrete_GRF(i).breaking_imp_AP_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 1}(1,discrete_GRF(i).inter1_AP_L:discrete_GRF(i).mid_AP_L)));
    %propulsive
    discrete_GRF(i).propulsion_imp_AP_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 1}(1,discrete_GRF(i).mid_AP_R:discrete_GRF(i).inter2_AP_R)));
    discrete_GRF(i).propulsion_imp_AP_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 1}(1,discrete_GRF(i).mid_AP_L:discrete_GRF(i).inter2_AP_L)));
    end
    
%Vertical
    
    for i = 1:dim(1,2)
    %total
    discrete_GRF(i).total_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,1:end)));
    discrete_GRF(i).total_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,1:100)));
    %first half    
    discrete_GRF(i).firsthalf_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,1:discrete_GRF(i).locvalley_V_R)));
    discrete_GRF(i).firsthalf_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,1:discrete_GRF(i).locvalley_V_L)));
    %second half
    discrete_GRF(i).secondhalf_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,discrete_GRF(i).locvalley_V_R:end)));
    discrete_GRF(i).secondhalf_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,discrete_GRF(i).locvalley_V_L:end)));
    %early stance
    discrete_GRF(i).earlystance_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,1:discrete_GRF(i).locpeak1_V_R)));
    discrete_GRF(i).earlystance_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,1:discrete_GRF(i).locpeak1_V_L)));
    %mid stance
    discrete_GRF(i).midstance_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,discrete_GRF(i).locpeak1_V_R:discrete_GRF(i).locpeak2_V_R)));
    discrete_GRF(i).midstance_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,discrete_GRF(i).locpeak1_V_L:discrete_GRF(i).locpeak2_V_L)));
    %late stance
    discrete_GRF(i).latestance_imp_V_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 2}(1,discrete_GRF(i).locpeak2_V_R:end)));
    discrete_GRF(i).latestance_imp_V_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 2}(1,discrete_GRF(i).locpeak2_V_L:end)));
    end
    
%ML
    for i = 1:dim(1,2)
    %total
    discrete_GRF(i).imp_ML_R=trapz(abs(elderly_subj_final(i).mean_GRF_R{1, 3}(1,discrete_GRF(i).inter1_ML_R:discrete_GRF(i).inter2_ML_R)));
    discrete_GRF(i).imp_ML_L=trapz(abs(elderly_subj_final(i).mean_GRF_L{1, 3}(1,discrete_GRF(i).inter1_ML_L:discrete_GRF(i).inter2_ML_L)));
    end
    
%plot peaks and valleys
mytitle_R={[]};
mytitle_L={[]};
my_string=["Anterior Posterior","Vertical","Medio Lateral"];
limite=[0.3,1.5,0.3];

 for d = 1:3
 figure()
     for i =1:dim(1,2)
        subplot(2,6,i)
        spm1d.plot.plot_meanSD(elderly_subj_final(i).GRF_R_corrFilter95{1, 1}{1, d}  , 'color', 'b'); hold on;  plot([0 100], [0 0], 'k:');
        if d==1
        hold on
        plot(discrete_GRF(i).locmin_AP_R,discrete_GRF(i).min_AP_R,'k*')
        hold on
        plot(discrete_GRF(i).locmax_AP_R,discrete_GRF(i).max_AP_R,'k*')
        end
        
       if d==2
          hold on
          plot(discrete_GRF(i).locpeak1_V_R,discrete_GRF(i).peak1_V_R,'k*')
          hold on
          plot(discrete_GRF(i).locpeak2_V_R,discrete_GRF(i).peak2_V_R,'k*')
          hold on
          plot(discrete_GRF(i).locvalley_V_R,discrete_GRF(i).valley_V_R,'k*')
       end 

       if d==3
          hold on
          plot(discrete_GRF(i).locpeak1_ML_R,discrete_GRF(i).peak1_ML_R,'k*')
          hold on
          plot(discrete_GRF(i).locvalley1_ML_R,discrete_GRF(i).valley1_ML_R,'k*')
          hold on
          plot(discrete_GRF(i).locvalley2_ML_R,discrete_GRF(i).valley2_ML_R,'k*')
       end
       
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
     for i =1:dim(1,2)
        subplot(2,6,i)
        spm1d.plot.plot_meanSD(elderly_subj_final(i).GRF_L_corrFilter95{1, 1}{1, d}, 'color', 'r'); hold on;  plot([0 100], [0 0], 'k:');
        if d==1
            hold on
            plot(discrete_GRF(i).locmin_AP_L,discrete_GRF(i).min_AP_L,'k*')
            hold on
            plot(discrete_GRF(i).locmax_AP_L,discrete_GRF(i).max_AP_L,'k*')
        end
        
       if d==2
          hold on
          plot(discrete_GRF(i).locpeak1_V_L,discrete_GRF(i).peak1_V_L,'k*')
          hold on
          plot(discrete_GRF(i).locpeak2_V_L,discrete_GRF(i).peak2_V_L,'k*')
          hold on
          plot(discrete_GRF(i).locvalley_V_L,discrete_GRF(i).valley_V_L,'k*')
       end 

       if d==3
          hold on
          plot(discrete_GRF(i).locpeak1_ML_L,discrete_GRF(i).peak1_ML_L,'k*')
          hold on
          plot(discrete_GRF(i).locvalley1_ML_L,discrete_GRF(i).valley1_ML_L,'k*')
          hold on
          plot(discrete_GRF(i).locvalley2_ML_L,discrete_GRF(i).valley2_ML_L,'k*')
       end
       
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

%plot integrals

%save discrete_GRF as an external file

 save('discrete_GRF.mat','discrete_GRF')
 
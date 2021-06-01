function [discrete_GRF] = peaks_impulsesFun(data,string1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%% Found Anterior posterior valley and peak by using max and min functions, thats all, piece of cake.
%% Found vertical peaks by using the function max between 1 and 50 for first peak,
%and between 50 and 100 for second peak
%(summing to 50, because it gets the index of new vector of only 50 elements
%and we want the position from 100)
%For valley we searched between the position of peak 1 and peak two,
%summing to the position of peak one to get the relative position for the
%100 elements vector.
%% Medio Lateral

dim=size(data);

%% find peaks, valleys, zeros, and its timestamps...
GRF={[]};
for d=1:3
    for i=1:dim(1,2)
        GRF{i,d}=data(i).mean_GRF_RL{1, d};
    end
end

%Anterior-Posterior
%max,min AP
for i =1: size(data,2)
    discrete_GRF(i).ID=data(i).ID;
    [discrete_GRF(i).min_AP_RL,discrete_GRF(i).locmin_AP_RL]=min(GRF{i,1});
    [discrete_GRF(i).max_AP_RL,discrete_GRF(i).locmax_AP_RL]=max(GRF{i,1});
end

%zeros AP


for i = 1:size(GRF,1)

    discrete_GRF(i).inter2_AP_RL=[];

    for k = 2:100
        if GRF{i,1}(1,k-1)<0 && GRF{i,1}(1,k+1)>0
           discrete_GRF(i).mid_AP_RL=k;
        end
    end
    
    for k = 2:discrete_GRF(i).mid_AP_RL
        if GRF{i,1}(1,k-1)>0 && GRF{i,1}(1,k+1)<0
           discrete_GRF(i).inter1_AP_RL=k;
        end
    end

    for k = discrete_GRF(i).mid_AP_RL : 100
        if GRF{i,1}(1,k-1)>0 && GRF{i,1}(1,k+1)<0
           discrete_GRF(i).inter2_AP_RL=k;
        end
    end    
end

for i = 1:size(GRF,1)
    if isempty(discrete_GRF(i).inter1_AP_RL)
        discrete_GRF(i).inter1_AP_RL=1;
    end
    if isempty(discrete_GRF(i).inter2_AP_RL)
        discrete_GRF(i).inter2_AP_RL=101;
    end
end

%zeros
%Vertical
%peaks and valley right
for i =1: size(GRF,1)
    [discrete_GRF(i).peak1_V_RL,discrete_GRF(i).locpeak1_V_RL]=max(GRF{i,2}(1,1:50));
    [discrete_GRF(i).peak2_V_RL,discrete_GRF(i).locpeak2_V_RL]=max(GRF{i,2}(1,51:101));
    discrete_GRF(i).locpeak2_V_RL=discrete_GRF(i).locpeak2_V_RL+50; %com dúvida nesse +50 [pq matlab começa em 1]
    [discrete_GRF(i).valley_V_RL,discrete_GRF(i).locvalley_V_RL]=min(GRF{i,2}(1,discrete_GRF(i).locpeak1_V_RL:discrete_GRF(i).locpeak2_V_RL));
    discrete_GRF(i).locvalley_V_RL=discrete_GRF(i).locvalley_V_RL+discrete_GRF(i).locpeak1_V_RL;
end

%Medio Lateral
%peaks and valleys ML

for i =1: size(GRF,1)
    [discrete_GRF(i).peak1_ML_RL,discrete_GRF(i).locpeak1_ML_RL]=min(GRF{i,3}(1,1:50));
    [discrete_GRF(i).valley1_ML_RL,discrete_GRF(i).locvalley1_ML_RL]=max(GRF{i,3}(1,1:50));
    [discrete_GRF(i).valley2_ML_RL,discrete_GRF(i).locvalley2_ML_RL]=max(GRF{i,3}(1,51:101));
    discrete_GRF(i).locvalley2_ML_RL=discrete_GRF(i).locvalley2_ML_RL+50;
end


%zeros
for i = 1:size(GRF,1)
    discrete_GRF(i).inter2_ML_RL=[];
    for k = 2:50
        if GRF{i,3}(1,k-1)<0 && GRF{i,3}(1,k+1)>0
            discrete_GRF(i).inter1_ML_RL=k;
        end
    end
    
    for k = 51:100
        if GRF{i,3}(1,k-1)>0 && GRF{i,3}(1,k+1)<0
            discrete_GRF(i).inter2_ML_RL=k;
        end
    end
    
    if isempty(discrete_GRF(i).inter1_ML_RL)
        discrete_GRF(i).inter1_ML_RL=1;
    end
    if isempty(discrete_GRF(i).inter2_ML_RL)
        discrete_GRF(i).inter2_ML_RL=101;
    end
end


%% impulses

%Anterior Posterior

for i = 1:dim(1,2)
    %total
    discrete_GRF(i).total_imp_AP_RL=trapz(abs(data(i).mean_GRF_RL{1, 1}(1,discrete_GRF(i).inter1_AP_RL:discrete_GRF(i).inter2_AP_RL)));
    %breaking
    discrete_GRF(i).breaking_imp_AP_RL=trapz(abs(data(i).mean_GRF_RL{1, 1}(1,discrete_GRF(i).inter1_AP_RL:discrete_GRF(i).mid_AP_RL)));
    %propulsive
    discrete_GRF(i).propulsion_imp_AP_RL=trapz(abs(data(i).mean_GRF_RL{1, 1}(1,discrete_GRF(i).mid_AP_RL:discrete_GRF(i).inter2_AP_RL)));
    
    %Vertical
    %total
    discrete_GRF(i).total_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,1:end)));
    %first half
    discrete_GRF(i).firsthalf_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,1:discrete_GRF(i).locvalley_V_RL)));
    %second half
    discrete_GRF(i).secondhalf_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,discrete_GRF(i).locvalley_V_RL:end)));
    %early stance
    discrete_GRF(i).earlystance_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,1:discrete_GRF(i).locpeak1_V_RL)));
    %mid stance
    discrete_GRF(i).midstance_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,discrete_GRF(i).locpeak1_V_RL:discrete_GRF(i).locpeak2_V_RL)));
    %late stance
    discrete_GRF(i).latestance_imp_V_RL=trapz(abs(data(i).mean_GRF_RL{1, 2}(1,discrete_GRF(i).locpeak2_V_RL:end)));
    %ML
    %total
    discrete_GRF(i).imp_ML_RL=trapz(abs(data(i).mean_GRF_RL{1, 3}(1,discrete_GRF(i).inter1_ML_RL:discrete_GRF(i).inter2_ML_RL)));
end

%plot peaks and valleys
mytitle={[]};
my_string=[" Anterior Posterior"," Vertical"," Medio Lateral"];
limite=[0.3,1.5,0.3];

for d = 1:3
    figure()
    for i =1:dim(1,2)
        subplot(2,6,i)
        plot(data(i).mean_GRF_RL{1, d}  , 'color', 'k'); hold on;  plot([0 101], [0 0], 'k:');
        if d==1
            hold on
            plot(discrete_GRF(i).locmin_AP_RL,discrete_GRF(i).min_AP_RL,'r*')
            hold on
            plot(discrete_GRF(i).locmax_AP_RL,discrete_GRF(i).max_AP_RL,'r*')
        end
        
        if d==2
            hold on
            plot(discrete_GRF(i).locpeak1_V_RL,discrete_GRF(i).peak1_V_RL,'r*')
            hold on
            plot(discrete_GRF(i).locpeak2_V_RL,discrete_GRF(i).peak2_V_RL,'r*')
            hold on
            plot(discrete_GRF(i).locvalley_V_RL,discrete_GRF(i).valley_V_RL,'r*')
        end
        
        if d==3
            hold on
            plot(discrete_GRF(i).locpeak1_ML_RL,discrete_GRF(i).peak1_ML_RL,'r*')
            hold on
            plot(discrete_GRF(i).locvalley1_ML_RL,discrete_GRF(i).valley1_ML_RL,'r*')
            hold on
            plot(discrete_GRF(i).locvalley2_ML_RL,discrete_GRF(i).valley2_ML_RL,'r*')
        end
        
        id=data(i).ID;
        if id<=9
            title(strcat("ID: 0",num2str(id)));
        else
            title(strcat("ID: ",num2str(id)));
        end
        ylim([-0.3 limite(d)])
        xlabel("Stance Phase (%)");
        ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex');
    end
    mytitle{d,1}=strcat("Mean and SD (GRF Right and Left) - ",string1,my_string(1,d));
    sgtitle(mytitle(d,1));
end

%plot integrals?

end
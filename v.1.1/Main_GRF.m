%Loading, filtering, and datinterp algorithms wrotten by Marcus Fraga Vieira: co-advisor. 
%Translated and modified by Ana Maria Bender Seidenfuss das Neves.
%introducing batch (many folders and multiple files) importing and
%Pre-Processing (Ana Maria, Rafael and Marcus) and Statistical Parametric Mapping (Todd Pataky, Friston, et al.)

close all; clear; clc;
disp('Starting GRF...')

%% Loading GRF Data % give the name you think better describes your group of repetitions

Diretory_GRF_elderly = './idosos_GRF/';
[Data_GRF_Elderly, Fs]=import_subfolder_files(Diretory_GRF_elderly);

%% calculating weight using one static test

Dim=size(Data_GRF_Elderly);
%plotDim=
Weight = zeros(Dim(1,1),1);
Mass_kg = zeros(Dim(1,1),1);

for i=1:Dim(1,1)
    Weight(i,1)=mean(Data_GRF_Elderly{i,1}(1:end-2,3) + Data_GRF_Elderly{i,1}(1:end-2,6)); 
    Mass_kg(i,1)=Weight(i,1)/9.81;  
end
  
%% SEPARATE RIGHT FOOT EVENTS
%get were in time (which row of the matrix) each stance phase
%(possible_step?) starts and ends (b_R)
%and also the number of steps:
isnan_R={[]};
events_R={[]};
n_steps_R={[]};

for i=1:Dim(1,1)
    [isnan_R{i,1}, events_R{i,1}, events_R{i,2}, n_steps_R{i,1}] = get_Events(Data_GRF_Elderly{i,2}(:,3));
end

%plot1 [para ver] all data
figure() 
for i=1:Dim(1,1)
    subplot(3,5,i)
    plot(Data_GRF_Elderly{i,2}(:,3));
    hold on;
end

%% Segment: using stance [(events_R{i_1} = start) and (events_R{i_2} = end)] events and the number of steps; 
[elderly_grf_r] = Segment(Data_GRF_Elderly,n_steps_R,events_R,2,3,4);

%% Prepare data: downsample, divide by bodyweight, filter, 
    %delete (too short/too long), and interpolate;
    %%!!!! correct the function using logical indexing... if possible;

    %define cut frequency: learn how;
%Fc=24;
Fc=24;
%Function prepare_curves
prepared_curves_R=prepare_curves(Dim(1,1),n_steps_R,elderly_grf_r,Weight,Fs,Fc);
yR={[]};

Output_GRF={[]};
for i=1:Dim(1,1)
    k=length(prepared_curves_R{i,1});
    for j=1:k
        for l=1:3
            yR{i,j,l}=prepared_curves_R{i,l}{j,1}(:,1);
            Output_GRF{i,1}(j,:,l)=transp(yR{i,j,l}(1:100));
        end
    end
end

%% FIIIIIIIIIIXXXXXXXXXXXXX ITTTTTTTTTT!!!!!!!!!

%% correlation matrix within participant cm_
%total_steps_R=0;
%organize data so it is all in one matrix inside a cell for each
%participant
within_GRF={[]};
for i=1:Dim(1,1)
   %total_steps_R=total_steps_R + sum(length(prepared_curves_R{i,1}));
        k=length(prepared_curves_R{i,1});
    for j=1:k
        for l=1:3
            within_GRF{i,l}(j,:)=horzcat(Output_GRF{i,1}(j,:,l));          
        end     
    end
end

xr_w{i,1}={[]}; yr_w{i,1}={[]}; zr_w{i,1}={[]};
for i=1:Dim(1,1)
    xr_w{i,1}=within_GRF{i,1}(:,:);
    yr_w{i,1}=within_GRF{i,2}(:,:);
    zr_w{i,1}=within_GRF{i,3}(:,:);  
end

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(xr_w{i,1}(:,:)'); 
        hold on;
end

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(yr_w{i,1}(:,:)'); 
        hold on;
end

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(zr_w{i,1}(:,:)'); 
        hold on;
end

% mat_corr_1: antes de remover corr_coef muito fracos (<0.40);
%primeira matrix de correlação
cm_xR_w={[]}; cm_yR_w={[]}; cm_zR_w={[]};

for i =1:Dim(1,1)
    cm_xR_w{i,1} = corr(xr_w{i,1}');
    cm_yR_w{i,1} = corr(yr_w{i,1}');
    cm_zR_w{i,1} = corr(zr_w{i,1}');
end

figure();
    for i=1:Dim(1,1)
        subplot (3,5,i); 
        colormap(cool); 
        imagesc(cm_xR_w{i,1}'); 
    end

figure();
    for i=1:Dim(1,1)
        subplot (3,5,i); 
        colormap(cool); 
        imagesc(cm_yR_w{i,1}'); 
    end

figure();
    for i=1:Dim(1,1)
        subplot (3,5,i); 
        colormap(cool);
        imagesc(cm_zR_w{i,1}');
    end
%%   calcula a correlação media de cada evento (stance phase curve) compara com a corr media de todos os eventos e mantem apenas valores superiores à media total:
%   qual curva tem a menor correlação - primeiro faz a media de cada curva
%   e depois a média de todas as curvas;
corr_media={[]};
figure ()
for i = 1:Dim(1,1)
    corr_media{i,1} = sum(cm_yR_w{i,1}(:,:))/length(cm_yR_w{i,1});
    corr_media{i,2} = mean(corr_media{i,1}(1,:));
    % find curve indeces that have corr_media{i,1} greater or equal to corr_media{i,2} of subject
    %
    keep{i,1}=find(corr_media{i,1}(1,:) >= corr_media{i,2} );
    keepers1_GRF{i,1}=yr_w{i,1}(keep{i,1}(1,:),:);
    
    h = plot(i,corr_media{i,1}(1,:));
    set(h,'Marker','o');
    grid on
    grid minor
    hold on
    
end

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(keepers1_GRF{i,1}(:,:)'); 
        hold on;
end

%% agora mapear a correlação dos novos candidatos à análise com SPM
cm_yR_2_w={[]};
figure()
for i =1:Dim(1,1)
    cm_yR_2_w{i,1}=corr(keepers1_GRF{i,1}');
    subplot (3,5,i); 
        colormap(cool);
        imagesc(cm_yR_2_w{i,1}(:,:)');
    %%calcular corr media, e corr media total e verificar se é maior que
    %%85%
end

corr_media_1={[]};
figure ()
for i = 1:Dim(1,1)
    corr_media_1{i,1} = sum(cm_yR_2_w{i,1}(:,:))/length(cm_yR_2_w{i,1});
    corr_media_1{i,2} = mean(corr_media_1{i,1}(1,:));
    % find curve indeces that have corr_media{i,1} greater or equal to corr_media{i,2} of subject
    %
    keep1{i,1}=find(corr_media_1{i,1}(1,:) >= corr_media_1{i,2});
    keepers2_GRF{i,1}=keepers1_GRF{i,1}(keep1{i,1}(1,:),:);
    
    h = plot(i,corr_media_1{i,1}(1,:));
    set(h,'Marker','o');
    grid on
    grid minor
    hold on
    
end

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(keepers2_GRF{i,1}(:,:)'); 
        hold on;
end



% 
% corr3_w={[]};
% figure()
% for i =1:Dim(1,1)
%     corr3_w{i,1}=corr(corr2_GRF{i,1}');
%     subplot (3,5,i); 
%         colormap(cool);
%         imagesc(cm_yR_2_w{i,1}(:,:)');
%     %%calcular corr media, e corr media total e verificar se é maior que
%     %%85%
% end
% 
% %
% 
% %investigate=
% 
% %% correlação muito fracas (< 0.40) - remover curvas e reavaliar correlação entre curvas restantes
% 
% 
% %% FIIIIIIX IIIIITTTTTT = TUDO ERRADO 11/11/2020
% % for i=1:15
% %     k=length(corr_media_1{i,1});
% %     for j = 1:k
%         if corr_media_1{i,1}(1,j) >= 0.4
%             i_KEEP_Curve{i,j}=j;
%         elseif corr_media_1{i,1}(1,j) < 0.4    
%             i_DEL_Curve{i,j}=j;
%         end
%     end
% end




%% mat_corr_2 : agora vamos ficar apenas com curvas que sejam parecidas, e podemos verificar o quão parecidas são essas curvas restantes;  


    %% graph - see what means correlation?? e a diagonal principal?
    figure()
        plotmatrix(yr_w{10,1}')
            hold on
    %figure()
    %    feather(yr_w{10,1}');
        
%% leave only curves with correlation >= 90%    for each person (within subject)
% for i =1:dim(1,1)   
%     k=length(cm_yR_w{i,1});
%     for j=1:k
%         if cm_yR_w{i,1}(j,1) >= 0.80
%            aaaaa{i,j} = cm_yR_w{i,1}(j,1);
%         else
%            aaaaa{i,j} = [];
%         end  
%     end
% end
% 
% 
% for i= 1:dim(1,1)
%     if ~isempty(aaaaa{i,j})
%         p=p+1;
%         aaaaa{i,1}(p,1)=yr_w;
%         end
%     end
% end

%% put all curves together without separating by subject %plot also
%FIX ITTT

AQUI=0;
all_GRF={[]};
%total_steps_R=0;
figure()
for i=1:Dim(1,1)
    %total_steps_R=total_steps_R + sum(length(prepared_curves_R{i,1}));
        k=length(prepared_curves_R{i,1});
    for j=1:k
           AQUI=AQUI+1
        for l=1:3
           all_GRF{l,1}(AQUI,:)=horzcat(Output_GRF{i,1}(j,:,l));
           subplot(1,3,l); plot(all_GRF{l,1}(AQUI,:)); hold on;
        end     
    end    
end
%% arrumar tudo aqui pq ainda nao deu para tirar as correlações sem olhar quem tá mais diferente de quem...
xR=all_GRF{1,1}(:,:)'; 
yR=all_GRF{2,1}(:,:)';
zR=all_GRF{3,1}(:,:)';

cm_xR = corr(xR);
cm_yR = corr(yR);
cm_zR = corr(zR);

figure(); 

subplot(1,3,1);
colormap(cool); imagesc(cm_xR); hold on;
subplot(1,3,2); 
colormap(cool); imagesc(cm_yR); hold on;
subplot(1,3,3); 
colormap(cool); imagesc(cm_zR);       
   

%plotmatrix(all_GRF{1, 1}(:,:))
%subplot(1,3,l)
%plot(prepared_curves_R{i,l}{j,1}); 

%figure()
%plot(all_GRF{3, 1}(116,:))
%     hold on
%     plot(all_GRF{3,1}(117,:)) 
    
%% ICC: keep only curves that present ICC >= 90%
% for i=1:dim0(1,1)
%     for j=1:dim(1,1)
%         k=length(prepared_curves_R{i,1});
%         for j=1:k
%             ICC_coef{i,1}(j,j)=corrcoef(Output_GRF{i,1}(j,:,1));
%         end                                                                                                                             / 
%     end
% end
%
% yR=Out_GRF_R(1:n_steps_R,:,2);
% cmR = corr(yR');

% yR=Out_GRF_R(1:n_steps_R,:,2);
% cmR = corr(yR');
%
% %% Identify which curves have correlation < 90%
% j=1;
% for NR = 1:n_steps_R
%     if cmR(NR) < 0.90  %correlation less than 90%
%        incomp_R(j) = NR;
%        j = j+1;
%     end
% end

%% visualize for quality inspection
% prepare_curves_ R three ground reaction force components all participants before ICC

% figure()
% total_steps_R=0;
% 
% for i=1:dim(1,1)
% total_steps_R=total_steps_R + sum(length(prepared_curves_R{i,1}));
% for l=1:3
%         k=length(prepared_curves_R{i,1});
%         for j=1:k
%         subplot(1,3,l) 
%         plot(prepared_curves_R{i,l}{j,1});
%        
%         hold on
%         end
%     end
% end
% 
% figure()
% for i=1:dim(1,1)
%     for l=1:3
%         k=length(prepared_curves_R{i,1});
%         for j=1:k
%         subplot(3,5,i) 
%         plot(prepared_curves_R{i,2}{j,1});
%         hold on
%         end
%     end
% end


%% FIX ITTTT
%Import - concatenate
%Get events
%S0egm0en0t0/0Cut-Curves
%Clean Stance Duration: too short; too long; average;
%Downsample (1000 H0z--0>100 Hz)
%Filter: butterworth zero lag - 4th order, Fc: 24 HZ (initially)
%Interpolate (100 nodes)
%C0lassify using ICC: 
    %c0o0mple0te vs incomplete 
    %if R > 0.90 (CROSS-CORRELATION)
%Make abs values (all positive values)
%save complete curves 
    %a) original (no curve fit)
% output - create: 
    %within subject file (multiple curves for each subj) 
        %1 file for subject foot... SUB1_group_R and SUB1_group_L 
        %n curves
        %3 v0ector GRF components
    %between subject file (mean curve for each subj)
    %1 file for 0group foot - 
        %ex.:   ELDERLY_R (N subjects of older adults groups - mean curves of right foot) 
        %       ELDERLY_L         
% Curve Fit: 
    %a) Fourier; 
    %b) Polynomial; 
    %c) Gaussian;
    %d) Smoothing spline;
    
% SPM: 
    % Within SUBJ RxL
        % find example: paired hotelings t-test t2...
            % for all stance for each participant
    % Between SUBJ RxL
        % find example: paired hotelings t-test t2...
            % mean of each participant
    % Between groups RXL
        % find example: (hotellins T2 - multiple variables, 2 conditions (groups))

% f0or i=1:dim(1,1)
%     k=n_steps_R{i};  
%     p=0;
%     0for j=1:k     
%         for l=1:3
%          0   x{i,j,l}=elderly_grf_r{i,j,l}/W(i);
%             len{i,j,l}=length(x{i,j,l});
%             
%             %rules for lenght of stance phase based on sample frequency -
%             %before interpolation to 100 points
%             %remove data that are (too short = Fs/5 or too long lenght = FS)
%             
%             if len{i,j,l}>=(Fs{l,1})/4 && len{i,j,l}<=Fs{l,1}
%                0y0{0i,j,l}=downsample(x{i,j,l},(Fs{l,1}/100));
%                y{i,j,l}=filterData(y{i,j,l},24,Fs{l,1}/(Fs{l,1}/100));
%             else
%                % remove series that are too short or too long
%                y{i,j,l}=[];
%             end
%             
%             %interpolate data that have lenght different from 0;                    
%             if ~isempty(y{i,j,l})                
%                 y{i,j,l}=datinterp(y{i,j,l},100,'pchip');                
%             end
%         end
%         
%         if   ~isempty(y{i,j,1})
%                p=p+1;
%                for l=1:3
%                clean_curves{i,l}(p,1)=vertcat(y(i,j,l));
%                end
%         end000
%     end
% end


 
% save each subject data, ignoring the empty cells:
%get how many stance phases survived from the first cleaning
% n_steps_R_clean={[]};
% m=zeros();
% p=1;
% for i=1:dim(1,1)
% k=n_ste0ps_R{i};
% n_steps_R_clean{i,1}=0;
%     for j=1:k
%         if ~isempty(y{i,j,1})
%             m(i,p)=j;
%             p=p+1;
%             n_steps_R_clean{i,1}= n_steps_R_clean{i,1}+1;
%             %y{i,j,l}=datinterp(y{i,j,l},100,'pchip');
%         end
%     end
% end

%% get where each is located... for one subject (ok done)
% k=n_steps_R{1};
% n_steps_R_clean=0;
% P0=zeros(1,n_steps_R_clean);
% q=1;
% for m=1:k
%      0   if cellfun('isempty',y(1,m,1)) == 0 
%         0P(q)=m;
%         q=q+1;
%         n_steps_R_clean= n_steps_R_clean+1;
%         end
% end
%%  trying for all subjects
%structs
% for i=1:dim(1,1)
%     k=n_steps_R{i};
%     p=0;
%     for j=1:k
%         if   ~isempty(y{i,j,1})
%             p=p+1;
%             for l=1:3
%             clean_curves{i,l}(p,1)=vertcat(y(i,j,l));
%            4 end
%         end  
%     end
% end


%% mean curve for each subject
%  k=n_steps_R{1};
%  n_steps_R_clean=0;
%  P=zeros(1,n_steps_R_clean);
%  q=1;
%  for m=1:k
%          if cellfun('isempty',y(1,m,1)) == 0 
%          P(q)=m;
%          q=q+1;
%          n_steps_R_clean= n_steps_R_clean+1;
%          end
%  end
 
% m=1;
% i=1;
% k=1;
% 
% while cellfun('isempty',y(i,m,1))==1
%      i=i+1;
%      m=m+1;
% 
%     clean_steps_R(k)=y(i,m,1);    
%         k=k+1;
%         if cellfun('isempty',y(i,m,1))==0
%             continue
%         end
%     fprintf('i: %d \n',i);
%     fprintf('m: %d',m);
%     
%         end
%
% i=dim(1,1);
% m=0n_steps_R{i};
% k=1;
% while i>0 && m>0
%     if ~isempty(y{i,j,1})                
%         y{i,j,l}=datinterp(y{i,j,l},100,'pchip');
%         clean_steps_R(i,k)=y(i,m,1);
%         k=k+1;
%     end
%         m=m-1;
%         i=i-1;
% end
%     %i=i-1;
% 
% if ~isempty(y{i,j,l})                
%     y{i,j,l}=datinterp(y{i,j,l},100,'pchip');
% end

%FIIIIIIIIIIIIX ITTTTTTTTTT

%for j=1:dim(1,1)
%    y(j,:,:)
%end
%Output_GRF(i,j,l)=transp(y{i,j,l}(1:100));  
% to try: using structures...
%curren0tDate = datestr(now,'mmmdd');
%myStruct.(currentDate) = [1,2,3]

%     for n=1:ns
%         %divide by body weight
%         
%         
%         x{1,n}=x{1,n}/w;
%         x{2,n}=x{2,n}/w;
%         x{3,n}=x{3,n}/w;
% 
%         %filter data;
%0         x{1,n}=filterData(x{1,n},24,Fs); 
%         x{2,n}=filterData(x{2,n},24,Fs);
%         x{3,n}=filterData(x{3,n},24,Fs);
% 
%         %interpolate data - transform into 100 points
%         x{1,n}=datinterp(x{1,n},interp_points,'pchip');
%         x{2,n}=datinterp(x{2,n},interp_points,'pchip');
%         x{3,n}=datinterp(x{3,n},interp_points,'pchip');
% 
%         %Create output matrices    
%         Output_GRF(n,:,1)=transp(x{1,n}(1:2:interp_points));
%         Output_GRF(n,:,2)=transp(x{2,n}(1:2:interp_points));
%         Output_GRF(n,:,3)=transp(x{3,n}(1:2:interp_points));
%      end

%[Out_GRF_R] = prepara_GRF(all_grf_r,n_steps_R(i),W(i),Fs,1000,100);
% 
% %Save: output matrix RIGHT FOOT
% save('Out_GRF_R.mat','Out_GRF_R');
% load('Out_GRF_R.mat');
% 
% %Classify: using correlation coeficient between events:
% %testando matriz de correlação;
% 
% YR=Out_GRF_R(1:10,:,2);
% yR=Out_GRF_R(1:n_steps_R,:,2);
% cmR = corr(yR');
% 
% %% Identify which curves have correlation < 90%
% j=1;
% for NR = 1:n_steps_R
%     if cmR(NR) < 0.90  %correlation less than 90%
%        incomp_R(j) = NR;
%        j = j+1;
%     end
% end
% aaa=size(incomp_R);
% % Delete curves that do not have correlation
% if size(incomp_R)~=0
% end
% figure(1)
% 0colormap(cool);
% imagesc(cmR);
% 
% %% SEPARATE LEFT FOOT
% %get were in time each of the stance phase starts and ends and also the number of steps:
% [a_L, b_L, c_L, n_steps_L]= get_Events(A_GRF{4,1}(:,1));
% 
% %Segment: using stance start and end events and the number of steps; 
% [x_L]=Segment_GRF_L(A_GRF, b_L, c_L, n_steps_L);
% 
% %Prepara: divide by bodyweight, filter, interpolate and create output matrix;
% 
% [Out_GRF_L]=prepara_GRF( x_L, n_steps_L, w, Fs,200,100);
% %Save: output matrix RIGHT FOOT
%save('Out_GRF_L.mat','Out_GRF_L');
% load('Out_GRF_L.mat');
% 
%%Classify: using correlation coeficient between events;
%%testando correlação cruzada; 
% yL=Out_GRF_L(1:n_steps_L,:,2);
% figure(3)
% colormap(cool);
% cmL = corr(yL');
% imagesc(cmL);
% 
% 
% %% PLOT
% % Plot to check if curves were registrated properly
% figure (4)
% for NR=1:n_steps_R
% subplot(3,2,1); plot(Out_GRF_R(NR,:,1),'b'); title('Anterior-posterior'); legend({'Right'},'Location', 'Best'); hold on; %AP_R
% subplot(3,2,3); plot(Out_GRF_R(NR,:,2),'b'); ylabel('Force/Bodyweight'); title('Vertical'); hold on; % V_R
% subplot(3,2,5); plot(Out_GRF_R(NR,:,3),'b'); xlabel('% Stance Phase'); title('Medio-lateral'); hold on;% ML_R
%  end
%  for NL=1:n_steps_L
% subplot(3,2,2); plot(Out_GRF_L(NL,:,1),'r');title('Anterior-posterior'); legend({'Left'},'Location', 'Best'); hold on; % AP_L
% subplot(3,2,4); plot(Out_GRF_L(NL,:,2),'r'); ylabel('Force/Bodyweight'); title('Vertical'); hold on; % V_L
% subplot(3,2,6); plot(Out_GRF_L(NL,:,3),'r'); xlabel('% Stance Phase'); title('Medio-lateral'); hold on; % ML_L
%  end
%hold off
% 
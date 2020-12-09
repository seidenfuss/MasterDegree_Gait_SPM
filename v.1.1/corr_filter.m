function [output_matrix] = corr_filter(w_data_x,w_data_y,w_data_z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% mat_corr_1: antes de remover corr_coef muito fracos (<0.40);
%primeira matrix de correlação

cm_xR_w={[]}; cm_yR_w={[]}; cm_zR_w={[]};

    for i =1:Dim(1,1)
        cm_xR_w{i,1} = corr(w_data_x{i,1}');
        cm_yR_w{i,1} = corr(w_data_y{i,1}');
        cm_zR_w{i,1} = corr(w_data_z{i,1}');
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
    
%%calcula a correlação media de cada evento (stance phase curve) compara com a corr media de todos os eventos e mantem apenas valores superiores à media total:
%   qual curva tem a menor correlação - primeiro faz a media ou mediana? de cada curva
%   e depois a média de todas as curvas;

 corr_media={[]};
 corr_p_75={[]};

 figure ()
 
 for i = 1:Dim(1,1)
     corr_media{i,1} = sum(cm_yR_w{i,1}(:,:))/length(cm_yR_w{i,1});
     corr_media{i,2} = mean(corr_media{i,1}(1,:));
     
     corr_p_75{i,1}=prctile(cm_yR_w{i,1}(:,:),50);
     corr_p_75{i,2}=prctile(corr_p_75{i,1},75);
    
    % find curve indeces that have corr_media{i,1} greater or equal to corr_media{i,2} of subject
    %
    keep{i,1}=find(corr_media{i,1}(1,:) >= corr_media{i,2} );
    keepers1_GRF{i,1}=yr_w{i,1}(keep{i,1}(1,:),:);
    
    h = plot(i,corr_media{i,1}(1,:));
    set(h,'Marker','o');
    grid on
    grid minor
    hold on
    
   % find curve indeces that have corr_p{i,1} greater or equal to
        % corr_p{i,2} of subject i
 
    keep_p{i,1}=find(corr_p_75{i,1}(1,:) >= corr_p_75{i,2} );
    keepers1_GRF_p{i,1}=yr_w{i,1}(keep_p{i,1}(1,:),:);
    
    h = plot(i,corr_p_75{i,1}(1,:));
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

figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(keepers1_GRF_p{i,1}(:,:)'); 
        hold on;
end


%% agora mapear a correlação dos novos candidatos à análise com SPM
cm_yR_2_w={[]};
%%repete testando quartils
cm_yR_2_w_p={[]};
figure()
for i =1:Dim(1,1)
    cm_yR_2_w{i,1}=corr(keepers1_GRF{i,1}');
    subplot (3,5,i); 
        colormap(cool);
        imagesc(cm_yR_2_w{i,1}(:,:)');
    
end

for i =1:Dim(1,1)
    cm_yR_2_w_p{i,1}=corr(keepers1_GRF_p{i,1}');
    subplot (3,5,i); 
        colormap(cool);
        imagesc(cm_yR_2_w_p{i,1}(:,:)');   
end

corr_media_1={[]};
corr_p_1={[]};
%%repete
corr_media_1_p={[]};
corr_prctile_1_p={[]};


figure ()
for i = 1:Dim(1,1)
    corr_media_1{i,1} = sum(cm_yR_2_w{i,1}(:,:))/length(cm_yR_2_w{i,1});
    corr_media_1{i,2} = mean(corr_media_1{i,1}(1,:));
    %Y = prctile(x,42)  --- example
    corr_p_1{i,1} = prctile(corr_media_1{i,1}(1,:),10);

    
    corr_media_1_p{i,1} = sum(cm_yR_2_w_p{i,1}(:,:))/length(cm_yR_2_w_p{i,1});
    corr_media_1_p{i,2} = mean(corr_media_1_p{i,1}(1,:));
    %Y = prctile(x,42)  --- example
    corr_prctile_1_p{i,1} = prctile(corr_media_1_p{i,1}(1,:),10);

    
    % find curve indeces that have corr_media{i,1} greater or equal to corr_media{i,2} of subject
    %
    keep1{i,1}=find(corr_media_1{i,1}(1,:) >= corr_media_1{i,2});
    keepers2_GRF{i,1}=keepers1_GRF{i,1}(keep1{i,1}(1,:),:);
    
    h = plot(i,corr_media_1{i,1}(1,:));
    set(h,'Marker','o');
    grid on
    grid minor
    hold on
    
    %%repeat
        % find curve indeces that have corr_media_1_p{i,1} greater or equal to
        %corr_media_1_p{i,2} of subject i
        
        
    keep1_p{i,1}=find(corr_media_1_p{i,1}(1,:) >= corr_media_1_p{i,2});
    keepers2_GRF_p{i,1}=keepers1_GRF_p{i,1}(keep1_p{i,1}(1,:),:);
    
    h = plot(i,corr_media_1_p{i,1}(1,:));
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


figure()
for i=1:Dim(1,1)
    subplot(3,5,i);
        plot(keepers2_GRF_p{i,1}(:,:)'); 
        hold on;
end
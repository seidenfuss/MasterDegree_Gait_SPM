function plotTrials(D,data,color,side )
%PLOT_TRIALS plots all participants V_GRF trials concatenated;
%D=3: right; D=6: left --> vertical component
%COLOR: 'b' or 'r' DATAPLOT= data to plot put only name of the variable;
%SIDE: "Right" or "Left"
figure()

dim=size(data,1);
for i=1:dim(1,1)
    subplot(5,3,i);
    plot(data{i,2}(:,D),color);hold on;
    
    if i<=9
        title_sub=strcat('ID: 0', num2str(i), ' - Trials: ', num2str(data{i,3}));
    else
        title_sub=strcat('ID: ', num2str(i) , ' - Trials: ', num2str(data{i,3}));
    end
    
    title(title_sub);
    sgtitle(strcat('GRF Vertical ',side));
    xlabel('Time samples (ms)');
    ylabel('GRF_V (N)');
    
end
end
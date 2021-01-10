function n_plot = plotTrials(Dim,D,C,color,dataplot,title_gen,x_label,y_label,curve_counting,side )
%PLOT_TRIALS plots all participants V_GRF trials concatenated;
%D=3: right; D=6: left[TRIALS]
%C= 3 : trials; 
%COLOR: 'b' or 'r' DATAPLOT= data to plot put only name of the variable;
%TITLE_GEN= general title of subplots 
%X_LABEL: label of x axis - sample time units (miliseconds: (ms));
%Y_LABEL: label of y axis - Force Vertical  (Newtons: (N));
%CURVE_COUNTING: The identifier of curve nature ex.:(trials, steps, stance phases, jumps...)
%SIDE: "Right" or "Left"
figure()
for i=1:Dim(1,1)
    %dataplot{i, 1}{1, D}(:,:); C=2 : stance phases; %D=1,2,3: (AP,V,ML) [Stance]
    
    subplot(5,3,i); plot(dataplot{i,2}(:,D),color);hold on; 
    if i<=9
        title_sub=strcat('ID: 0', num2str(i), curve_counting, num2str(dataplot{i,C}));
    else
        title_sub=strcat('ID: ', num2str(i) , curve_counting, num2str(dataplot{i,C}));
    end
    title(title_sub);
    sgtitle(strcat(title_gen,side));
    xlabel(x_label);
    ylabel(y_label);
   
end
n_plot=Dim(1,1);
end

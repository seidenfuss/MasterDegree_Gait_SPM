function n_plot = plotStance(Dim,C,color,dataplot,x_label,y_label,curve_counting,side,extra)

for l=1:3
    figure()
    title_sg=["Anterior-Posterior","Vertical","Medio-Lateral"];
    for i=1:Dim(1,1) 
        subplot(5,3,i); plot(dataplot{i,1}{1,l}(:,:)',color); hold on;
          if i<=9
          title_sub=strcat('ID: 0', num2str(i),curve_counting, num2str(dataplot{i,C}));
          else
          title_sub=strcat('ID: ', num2str(i),curve_counting, num2str(dataplot{i,C}));
          end
        title(title_sub);
        xlabel(x_label);
        ylabel(y_label,'interpreter','latex');
        title_gen=strcat(title_sg(l),' GRF -',side,extra);
        sgtitle(title_gen);
    end
end
n_plot = Dim(1,1);
end
function plotStance(data,C,color,x_label,y_label,curve_counting,side,extra)
dim=size(data,1);
for d=1:3
    figure()
    title_sg=["Anterior-Posterior","Vertical","Medio-Lateral"];
    for i=1:dim(1,1)
        subplot(5,3,i); plot(data{i,1}{1,d}(:,:)',color); hold on;
        if i<=9
            title_sub=strcat('ID: 0', num2str(i),curve_counting, num2str(data{i,C}));
        else
            title_sub=strcat('ID: ', num2str(i),curve_counting, num2str(data{i,C}));
        end
        xlim([0 101])
        title(title_sub);
        xlabel(x_label);
        ylabel(y_label,'interpreter','latex');
        title_gen=strcat(title_sg(d),' GRF -',side,extra);
        sgtitle(title_gen);
    end
end
end
%% THE END
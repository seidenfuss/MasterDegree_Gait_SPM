
function [curves]=plotCurveNcorrCoef(data1,corr_limiar,data2,side,color)
dim=size(data1,1);
for i=1:dim(1,1)
    curves{i,1}=data1{i,2};%original_curves_Right
    for rpt = 1:length(corr_limiar)
        curves{i,rpt+1}=data2{1,rpt}{i,3};%corr_limiar_curves_Side
    end
end

figure()
for i = 1:dim(1,1)
    for j=1:4
        subplot(5,3,i)
        bar(j,curves{i,j},"stacked",color)
        hold on
        ylim([0 20])
        sgtitle (horzcat('Number of curves corrFilter - ',side))
        set(gca,'XTick',1:1:4)
        set(gca,'XTickLabel',{'Original','\rho=0.85','\rho=0.90','\rho=0.95'})
    end
end
%% THE END
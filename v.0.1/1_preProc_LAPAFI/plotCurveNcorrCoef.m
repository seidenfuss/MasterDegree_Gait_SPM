
function [curves]=plotCurveNcorrCoef(grf_w,corr_limiar,output_subj,Dim,side,color)
%explain here
for i=1:Dim(1,1)
     curves{i,1}=grf_w{i,2};%original_curves_Right
    for rpt = 1:length(corr_limiar)
        curves{i,rpt+1}=output_subj{1,rpt}{i,3};%corr_limiar_curves_Side  
    end
 end
  
 figure()
for i = 1:Dim(1,1)
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
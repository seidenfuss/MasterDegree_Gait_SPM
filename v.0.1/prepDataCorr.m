function [grf_R_w,grf_L_w] = prepDataCorr(Dim,prepared_curves_R,prepared_curves_L)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
grf_R_w={[]}; %right
grf_L_w={[]}; %left
for i=1:Dim(1,1)
    
    grf_R_w{i,2}=length(prepared_curves_R{i,1});
    grf_L_w{i,2}=length(prepared_curves_L{i,1});
    k_r=grf_R_w{i,2};
    k_l=grf_L_w{i,2};
    
    for l=1:3
        for j=1:k_r %right
            grf_R_w{i,1}{1,l}(j,:)= horzcat(transp(prepared_curves_R{i,l}{j,1}(:,1)));
        end
        for j=1:k_l %left
            grf_L_w{i,1}{1,l}(j,:)= horzcat(transp(prepared_curves_L{i,l}{j,1}(:,1)));
        end
    end
end


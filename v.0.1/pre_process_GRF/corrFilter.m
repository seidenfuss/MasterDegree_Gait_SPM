function [matrix_opt,repeat] = corrFilter(data, limiar)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cm_within = corr(data{1,2}(:,:)');
cm_mean=mean(cm_within);
min_corr=min(cm_mean);
for l= 1:3
    if min_corr>= limiar
        repeat=false;
        matrix_opt{1,l}=data{1,l};
    else
        repeat=true;
        ind2keep=find(cm_mean>min_corr);
        matrix_opt{1,l}=data{1,l}(ind2keep(1,:),:);
    end 
end
end


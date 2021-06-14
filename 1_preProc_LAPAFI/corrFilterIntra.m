function [matrix_opt,repeat] = corrFilterIntra(data, limiar)
%CORRFILTER this function receives a original matrix (data) containg all
%curves of each participant and a limiar (the correlation coeficient the user wants to achieve).
%It returns a optimized matrix containing all curves that have achieved the correlation coeficient limiar
%and also a repeat status (true or false), which will flag if the corrFilter method needs to repeated or not;

%First we calculate the cross-correlation matrix of all curves of a participant,
%then we calculate the mean correlation of each curve compared with its pairs,
%finally we find the minimum value, which corresponds to a curve that has, overall,
%smaller correlation than their neighbours.
%This value is compared with the correlation coeficient limiar set by the user.
%If the minimum value of mean cross-correlation is greater than the
%limiar set by the user the function returns false for the repeat status,
%and returns the same curves, because they already satisfy the limiar condition.

%Otherwise, if the minimum value of the mean cross-correlation is smaller
%than the limiar set by the user, the function returns true for the repeat status,
%and keeps only those curves that present a mean cross-correlation greater
%than the minimum mean cross-correlation value.

matrix_opt={[]};
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


function [matrix_opt] = corrFilter2(data, limiar)
matrix_opt={[]};
YR=vertcat(data{:,2});
cm_within = corr(YR');
cm_mean=mean(cm_within);
min_corr=min(cm_mean);

for l= 1:3
    ind2keep=find(cm_mean>limiar);
    for j= 1: size(ind2keep,2)
        matrix_opt{j,l}=data{ind2keep(j),l};
        matrix_opt{j,4}=data{ind2keep(j),4};
    end
end
end


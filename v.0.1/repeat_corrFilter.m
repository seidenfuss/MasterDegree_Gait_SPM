function [output,rep_n] = repeat_corrFilter(dim,data,corr_limiar)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
matrix_opt={[]};
rep_n=1;
repeat={[]};
output={[]};
for i=1:dim
    [matrix_opt{i,rep_n},repeat{i,rep_n}] = corrFilter(data{i,1}, corr_limiar);
        r=repeat{i,rep_n};
    while r == true
        rep_n= rep_n + 1;
        [matrix_opt{i,rep_n},repeat{i,rep_n}]=corrFilter(matrix_opt{i,rep_n-1},corr_limiar);
        r=repeat{i,rep_n};    
    end
    output{i,1}=matrix_opt{i,rep_n}(~isempty(matrix_opt{i,rep_n}),:);
    output{i,2}=size(output{i,1}{1,2}); 
end


end


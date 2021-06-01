function [output,rep_n] = repeatCorrFilter(data,corr_limiar)
%REPEATCORRFILTER receives the matrix (data) and the limiar correlation (corr_limiar)
%the user wants the data to achieve.
%It returns as output the optmized matrices for all participants (output) and the
%total number of repetitions (rep_n) of the correlation filter to achieve the desired correlation limiar.
%   This function calls other function called corrFilter, and has the
%   purpose of making the process recursive. So, while the repeat status
%   returned by corrFilter returns true, the number of repetition is
%   incremented and the repetition status is refreshed until all repeat
%   status of all participants are false and the while loop is finished.
%   Finally, the output matrix is mounted using the resultant optimized matrix
%   for the lastest repetion incremented (rep_n) when the while loop was
%   finished for each participant.
%   It also returns the dimensions of the resultant optimized matrices.

dim=size(data,1);
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
    output{i,3}=output{i,2}(1,1);
end
end


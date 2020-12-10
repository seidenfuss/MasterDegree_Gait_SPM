function [data_output,min_corr] = corrFilter(data_input,limiar_corr)
%% CORRFILTER  receives a matrix of curves with 3 dimensions each with n
%curves containing 100 nodes.
%calculates the correlation matrix (n_steps x n_steps)
%calculates the mean value of correlation(cm_R_mean) of each step and 
%save it into a vector for each participant i; 
%calculates the minimum value of cm_R_mean (min_corr), if it is smaller then
%0.97 (defined) remove and create an output cell containing the curves with cm_R_mean >
%min_corr

dim=size(data_input);
Dim=dim(1,1);

cm_within={[]};
cm_mean={[]};
min_corr={[]};
ind2keep={[]};
data_output={[]};
%figure()
  for i =1:Dim  
      cm_within{i,1} = corr(data_input{i,2}');   
      cm_mean{i,1} = mean(cm_within{i,1}(:,:));
      min_corr{i,1} = min(cm_mean{i,1});

      for l=1:3
      data_output{i,l}={[]};
        if min_corr{i,1} >= limiar_corr
            data_output{i,l}=data_input{i,l}(:,:);
        else
            ind2keep{i,1}=find(cm_mean{i,1}>min_corr{i,1});
            data_output{i,l}=data_input{i,l}(ind2keep{i,1}(1,:),:);
        end
      end

%     subplot (5,3,i); 
%     colormap(cool);
%     imagesc(cm_within{i,1}');

%     h = plot(i,cm_mean{i,1}(1,:));
%     set(h,'Marker','o');
%     grid on
%     grid minor
%     hold on
  end
end


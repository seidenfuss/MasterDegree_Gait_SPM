function [prep_data1,prep_data2] = prepDataCurves(dim_subj,n_steps,data,W,Fs,Fc)
%%
%

for i=1:dim_subj %i varies from 1 to the total number of participants
    k=n_steps{i}; % k is the number of steps of each participant (i)  
    p=0; % p assign a value for the new place of the step, starts at 0.
    for j=1:k  %j varies from 1 to k, which is called before because it changes for each (i) participant.   
        for l=1:3
            weightnorm{i,j,l}=data{i,j,l}/W(i);
            
            %rules for lenght of stance phase based on sample frequency -
            %before interpolation to 100 points
            %remove data that are too short = Fs/5)            
            len{i,j,l} = length(weightnorm{i,j,l});
            if len{i,j,l}>=(Fs{l,1}/5)
                filtered{i,j,l}=filterData(weightnorm{i,j,l},Fc,Fs{l,1}/(Fs{l,1}/100));
                downsampled{i,j,l}=downsample(filtered{i,j,l},(Fs{l,1}/100));
            else
                %remove series that are too short
                downsampled{i,j,l}=[];
            end
            
            %interpolate data that have lenght different from 0;
            if ~isempty(downsampled{i,j,l})
                interpolated{i,j,l}=datInterp(downsampled{i,j,l},100,'pchip');                
            end
        end
        if   ~isempty(downsampled{i,j,1})
            p=p+1;
            for l=1:3
                prep_data1{i,l}(p,1)=vertcat(interpolated(i,j,l));
                prep_data2{i,l}(p,1)=vertcat(downsampled(i,j,l));
            end
        end
    end
end
end



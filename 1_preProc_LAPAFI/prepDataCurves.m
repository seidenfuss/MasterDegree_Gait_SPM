function [prep_data1,prep_data2] = prepDataCurves(n_steps,data,Weight,Fs,Fc)
%%PREPDATACURVES
%
dim=size(data,1);
for i=1:dim %i varies from 1 to the total number of participants
    k=n_steps{i}; % k is the number of steps of each participant (i)
    p=0; % p assign a value for the new place of the step, starts at 0.
    weightnorm={[]};
    for j=1:k  %j varies from 1 to k, which is called before because it changes for each (i) participant.
        for d=1:3
            weightnorm{i,j,d}=data{i,j,d}/Weight(i);          
            %rules for lenght of stance phase based on sample frequency -
            %before interpolation to 100 points
            %remove data that are too short = Fs/5)
            len{i,j,d} = length(weightnorm{i,j,d});
            if len{i,j,d}>=(Fs{d,1}/5)
                filtered{i,j,d}=filterData(weightnorm{i,j,d},Fc,Fs{d,1}/(Fs{d,1}/100));
                downsampled{i,j,d}=downsample(filtered{i,j,d},(Fs{d,1}/100));
            else
                %remove series that are too short
                downsampled{i,j,d}=[];
            end
            
            %interpolate data that have lenght different from 0;
            if ~isempty(downsampled{i,j,d})
                interpolated{i,j,d}=datInterp(downsampled{i,j,d},101,'pchip');
            end
        end
        if   ~isempty(downsampled{i,j,1})
            p=p+1;
            for d=1:3
                prep_data1{i,d}(p,1)=vertcat(interpolated(i,j,d));
                prep_data2{i,d}(p,1)=vertcat(filtered(i,j,d));
            end
        end
    end
end
end

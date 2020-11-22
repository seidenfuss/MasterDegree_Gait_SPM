function prepared_data = prepare_curves(dim_subj,n_steps,data,W,Fs,Fc)
for i=1:dim_subj
    k=n_steps{i};  
    p=0;
    for j=1:k     
        for l=1:3
            x{i,j,l}=data{i,j,l}/W(i);
        
        %rules for lenght of stance phase based on sample frequency -
            %before interpolation to 100 points
            %remove data that are (too short = Fs/5 or too long lenght = FS)            
               len{i,j,l} = length(x{i,j,l});
            if len{i,j,l}>=(Fs{l,1}/4) && len{i,j,l}<=Fs{l,1}
               y{i,j,l}=downsample(x{i,j,l},(Fs{l,1}/100));
               y{i,j,l}=filter_data(y{i,j,l},Fc,Fs{l,1}/(Fs{l,1}/100));
            else
        %remove series that are too short or too long
               y{i,j,l}=[];
            end
                
               %interpolate data that have lenght different from 0;                    
            if ~isempty(y{i,j,l})                
                y{i,j,l}=dat_interp(y{i,j,l},100,'pchip');                
            end
        end
        
        if   ~isempty(y{i,j,1})
               p=p+1;
               for l=1:3
               prepared_data{i,l}(p,1)=vertcat(y(i,j,l));
               end
        end
    end
end
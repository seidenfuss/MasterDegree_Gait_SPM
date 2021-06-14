function [output_intersubj] = interSubj(data)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
dim=size(data);

for i=1:dim(1,2)
    for d=1:3
        data(i).mean_GRF_R{1,d}=mean((data(i).GRF_R_corrFilter95{1, 1}{1, d}));
        data(i).std_GRF_R{1,d}=std((data(i).GRF_R_corrFilter95{1, 1}{1, d}));
        data(i).mean_GRF_L{1,d}=mean((data(i).GRF_L_corrFilter95{1, 1}{1, d}));
        data(i).std_GRF_L{1,d}=std((data(i).GRF_L_corrFilter95{1, 1}{1, d}));
    end
end

yR={[]}; yL={[]};

for i = 1:dim(1,2)
    yR{i,4}=data(i).ID;
    yL{i,4}=data(i).ID;
    for d=1:3
        yR{i,d} = data(i).mean_GRF_R{1, d}(1,:);
        yL{i,d} = data(i).mean_GRF_L{1, d}(1,:);
    end
end


%% Plot before filter2(removing participants with discrepant curves)

plotStance2(data,2,7,"Mean and SD (GRF Right) - ",'Mean and SD (GRF Left) - ')

%% Remove curves that differ between participants

[matrix_opt_R] = corrFilterInter(yR, 0.85);
[matrix_opt_L] = corrFilterInter(yL, 0.85);
[matrix_opt_R1] = corrFilterInter(matrix_opt_R, 0.90);
[matrix_opt_L1] = corrFilterInter(matrix_opt_L, 0.90);

GRF_R=matrix_opt_R1;
GRF_L=matrix_opt_L1;

x=0;
for i = 1:size(data,2)
    check_subj=data(i).ID;
    for j = 1: size(matrix_opt_R1)
        keep_subj=matrix_opt_R1{j,4};
        if check_subj==keep_subj
            x=x+1;
            output_intersubj(j)=data(i);
            indices(x)=i;
        end
    end
end

for i = 1:size(GRF_R,1)
    output_intersubj(i).mean_GRF_R=GRF_R(i,1:3);
    output_intersubj(i).mean_GRF_L=GRF_L(i,1:3);
    
    output_intersubj(i).std_GRF_R=data(indices(i)).std_GRF_R;
    output_intersubj(i).std_GRF_L=data(indices(i)).std_GRF_L;
    for d=1:3
        output_intersubj(i).mean_GRF_RL{1,d}=mean(vertcat(GRF_R{i,d},GRF_L{i,d}));
    end
end

%% plot the remaining participants
plotStance2(output_intersubj,2,6,"Mean and SD (GRF Right) - After filter2",'Mean and SD (GRF Left) - After filter2')

end
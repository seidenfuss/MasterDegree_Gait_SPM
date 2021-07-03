function [segmented_data] = segmentCurves(data,n_steps,b_R,x,y,z)
%SEGMENTCURVES: It creates i sub-groups containing k (N_steps) for each participant (i).
%data: is the cell containing all data from all participants (rows) in two columns:
%data{:,1} files of static data experiments
%data{:,2} concatenated files of dynamic data experiments
%n_steps is the number of steps detected for each participant over all dynamic experiments
%x,y,z are the column indices for GRF vector components
%x:anterior-posterior; y:vertical; z:medio-lateral
%x=2 AP_R; y=3 V_R; z=4 ML_R; for RIGHT foot;
%x=5 AP_L ;y=6 V_L; z=7 ML_L; for LEFT foot;

dim=size(data);
for i=1:dim(1,1)
    k=n_steps{i};
    for j=1:k
        segmented_data{i,j,1} = data{i,2}(b_R{i,1}(1,j):b_R{i,2}(1,j),x);
        segmented_data{i,j,2} = data{i,2}(b_R{i,1}(1,j):b_R{i,2}(1,j),y);
        segmented_data{i,j,3} = data{i,2}(b_R{i,1}(1,j):b_R{i,2}(1,j),z);
    end
end
end
%% THE END
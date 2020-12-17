function [segmented_data] = segmentCurves(data,n_steps,b_R,x,y,z)

%%   Detailed explanation goes here
%SEGMENT: It creates i sub-groups containing k (N_steps) for each
%participant (i).
%DATA: is the cell containing all data from all participants (rows) in two columns:
    %column 1: files of static data experiments
    %column 2: concatenated files of dynamic data experiments
%N_STEPS is the number of steps detected for each participant over all dynamic experiments
%X,Y,Z are the column indices for GRF components --> x:anterior-posterior; y:vertical; z:medio-lateral
    %x=2;y=3;z=4; for RIGHT foot;
    %x=5;y=6;z=7; for LEFT foot;
    
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


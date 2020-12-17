
function [data_m, Fs] = importSubfolderFiles(main_pathway)
%% open a main_folder with multiple sub_folders and import all input_files within each sub_folder in an output_file;

% main_pathway="./your_folder_name"; % it is the format of the pathway of your
    %main folder - that contain (i) subfolders (participants) with the following
% files: 1 static test file (GRF components for each foot while standing with 
        % each foot placed on a single force plate)
        % multiple dynamic test files (listing data)
% access each subfolder (participant) and import the static file and the files for all repetitions of
% dynamic tests
    %%output
        % save static test as a row on first column
        % concatenate all repetitions of the same type of experiment and save it as a row of second column
            % same type of experiment:(all barefoot, or all with a certain type of shoe, or speed, or plane inclination conditions, depends on your experiment protocol) 
        % the number of rows correspond to the number of subjects;

%% open main_folder - show it's content - create a cell containing each subfolder path (dir command);
%getname of subfolders concatenate with main_pathway and save it to a cell
%where each 
%this way we can: access each subfolder

listing_folders = dir(main_pathway);
sub_folders=cell(length(listing_folders(:,1))-2,1);
    for i = 3:length(listing_folders(:,1))
        sub_folders{i-2} =strcat(main_pathway,'/',listing_folders(i).name);
    end

%% Create a structure containg other structures: each participant is a field called subject inside the 
%structure listing_data_s

listing_data_s = struct([]);
for k=1:length(sub_folders)
listing_data_s(k).subject = (dir(sub_folders{k,:}));
end

% extract fields within fields (file_folder and file_name for each subject):

for k=1:(length(listing_folders(:,1))-2)
    file_name=(extractfield(listing_data_s(k).subject,'name'));
    file_folder=(extractfield(listing_data_s(k).subject,'folder'));
    n_files=length(file_name);
    for j=3:n_files
       name_files(k,j-1)=file_name(j);
       name_files(k,1)=file_folder(j);
    end    
end

%import data = from all if cell is not empty
dim=size(name_files);
data_n=cell(dim(1,1),dim(1,2)-1);

for k=1:dim(1,1)
    for j=2:dim(1,2)
        if cellfun('isempty',name_files(k,j)) == 0
           data_n{k,j-1}=importFile(strcat(name_files(k,1),"\",name_files(k,j)));
        end
    end
end

% output: save static files and save in a row of the first column & concatenate all dynamic files and save in a row of the second column; 
data_m={[]};
Fs={[]};
dim_d=size(data_n);
for l=1:dim_d(1,1)
data_m{l,1}=data_n{l,1};
    for m=1:dim_d(1,2)
        if cellfun('isempty',data_n(l,m)) == 0
        data_m{l,2}=vertcat(data_n{l,2:m});%concatenate trials (m-1)
        data_m{l,3}=m-1; %get number of trials concatenated
        end
    end
% calculate the sample frequency as the inverse of the minimal time
% diference between two measurements:
    Fs{l,1} = 1/(data_m{l,2}(2,1) - data_m{l,2}(1,1));
end


end
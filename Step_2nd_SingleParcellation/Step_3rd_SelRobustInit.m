
%
% The second step of single brain parcellation, clustering of 50 group atlas to create the final group atlas
% For the toolbox of single brain parcellation, see: 
%

clear

ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
ReplicationFolder = [ProjectFolder '/Replication'];
ParcellationFolder = [ReplicationFolder '/results/SingleParcellation'];
ResultantFolder = [ParcellationFolder '/RobustInitialization2'];
mkdir(ResultantFolder);
inFile = [ResultantFolder '/ParcelInit_List.txt'];
system(['rm ' inFile]);
AllFiles = g_ls([ParcellationFolder '/Initialization2/*/*/*.mat']);
for i = 1:length(AllFiles)
  cmd = ['echo ' AllFiles{i} ' >> ' inFile];
  system(cmd);
end

% Parcellate into 17 networks
K = 17;
selRobustInit(inFile, K, ResultantFolder);


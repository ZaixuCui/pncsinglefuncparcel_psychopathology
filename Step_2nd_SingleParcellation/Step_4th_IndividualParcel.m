
%
% Based on the group atlas, creating each subject's individual specific atlas
% For the toolbox of single brain parcellation, see: 
%

clear

ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
ReplicationFolder = [ProjectFolder '/Replication'];
ParcellationFolder = [ReplicationFolder '/results/SingleParcellation'];
ResultantFolder = [ParcellationFolder '/SingleParcel_1by1'];
mkdir(ResultantFolder);

PrepDataFile = [ParcellationFolder '/CreatePrepData.mat'];
resId = 'IndividualParcel_Final';
initName = [ParcellationFolder '/RobustInitialization/init.mat'];
K = 17;
% Use parameter in Hongming's NeuroImage paper
alphaS21 = 1;
alphaL = 10;
vxI = 1;
spaR = 1;
ard = 0;
iterNum = 30;
eta = 0;
calcGrp = 0;
parforOn = 0;

surfML = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/lh.Mask_SNR.label'];
surfMR = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/rh.Mask_SNR.label'];

RawDataFolder = [ProjectFolder '/data/SurfaceData/CombinedData'];
LeftCell = g_ls([RawDataFolder '/*/lh.fs5.sm6.residualised.mgh']);
RightCell = g_ls([RawDataFolder '/*/rh.fs5.sm6.residualised.mgh']);

% Parcellate for each subject separately
for i = 1:length(LeftCell)
    i
    [Fold, ~, ~] = fileparts(LeftCell{i});
    [~, ID_Str, ~] = fileparts(Fold);
    ID = str2num(ID_Str);
    ResultantFolder_I = [ResultantFolder '/Sub_' ID_Str];
    ResultantFile = [ResultantFolder_I '/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL10_vxInfo1_ard0_eta0/final_UV.mat'];
    if ~exist(ResultantFile, 'file');
        mkdir(ResultantFolder_I);
        IDMatFile = [ResultantFolder_I '/ID.mat'];
        save(IDMatFile, 'ID');

        sbjListFile = [ResultantFolder_I '/sbjListAllFile_' num2str(i) '.txt'];
        system(['rm ' sbjListFile]);

        cmd = ['echo ' LeftCell{i} ' >> ' sbjListFile];
        system(cmd);
        cmd = ['echo ' RightCell{i} ' >> ' sbjListFile];
        system(cmd);

        save([ResultantFolder_I '/Configuration.mat'], 'sbjListFile', 'surfML', 'surfMR', 'PrepDataFile', 'ResultantFolder_I', 'resId', 'initName', 'K', 'alphaS21', 'alphaL', 'vxI', 'spaR', 'ard', 'eta', 'iterNum', 'calcGrp', 'parforOn');
        ScriptPath = [ResultantFolder_I '/tmp.sh'];
        cmd = ['/cbica/software/external/matlab/R2018A/bin/matlab -nosplash -nodesktop -r ' ...
          '"addpath(genpath(''' ProjectFolder '/scripts/Toolbox/Code_mvNMF_l21_ard_v3_release'')),' ...
          'load(''' ResultantFolder_I '/Configuration.mat''),' ...
          'deployFuncMvnmfL21p1_func_surf_fs(sbjListFile,surfML,surfMR,' ...
          'PrepDataFile,ResultantFolder_I,resId,initName,K,alphaS21,' ...
          'alphaL,vxI,spaR,ard,eta,iterNum,calcGrp,parforOn),exit(1)">"' ...
          ResultantFolder_I '/ParcelFinal.log" 2>&1'];
        fid = fopen(ScriptPath, 'w');
        fprintf(fid, cmd);
        system(['qsub -l h_vmem=10G ' ScriptPath]);
        pause(1);
    end
end


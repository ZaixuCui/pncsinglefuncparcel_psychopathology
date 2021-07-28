
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
ReplicationFolder = [ProjectFolder '/Replication'];
ParcellationFolder = [ReplicationFolder '/results/SingleParcellation'];
mkdir(ProjectFolder);

SubjectsFolder = [ProjectFolder '/freesurfer/6.0.0/subjects/fsaverage5'];
% for surface data
surfL = [SubjectsFolder '/surf/lh.pial'];
surfR = [SubjectsFolder '/surf/rh.pial'];
surfML = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/lh.Mask_SNR.label'];
surfMR = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/rh.Mask_SNR.label'];

[surfStru, surfMask] = getFsSurf(surfL, surfR, surfML, surfMR);

gNb = createPrepData('surface', surfStru, 1, surfMask);

% save gNb into file for later use
prepDataName = [ProjectFolder '/CreatePrepData.mat'];
save(prepDataName, 'gNb');


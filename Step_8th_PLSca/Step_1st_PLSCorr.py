
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/Replication/scripts/AnalysisScripts/Functions');
import PLSca_CZ_Random_RegressCovariates

Folder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/Replication/results';
psychopathology_Mat=sio.loadmat(Folder + '/Psychopathology_790.mat');
Loading_Mat=sio.loadmat(Folder + '/AtlasData/AtlasLoading/AtlasLoading_All_RemoveZero.mat');
psychopathology = psychopathology_Mat['Psychopathology_List'];
Atlas_Loading = Loading_Mat['AtlasLoading_All_RemoveZero'];
Covariates = np.zeros((790, 3));
Covariates[:,0] = psychopathology_Mat['Sex'];
Covariates[:,1] = psychopathology_Mat['AgeYears'];
Covariates[:,2] = psychopathology_Mat['Motion'];

ResultantFolder = Folder+'/PLSca/AtlasLoading/RandomCV_101Repeats_RegressCovariates_All_2Fold'
PLSca_CZ_Random_RegressCovariates.PLSca_KFold_RandomCV_MultiTimes(Atlas_Loading, psychopathology, Covariates, 112, 2, 101, ResultantFolder, 0)

ResultantFolder = Folder+'/PLSca/AtlasLoading/RandomCV_RegressCovariates_All_2Fold_Permutation'
PLSca_CZ_Random_RegressCovariates.PLSca_KFold_RandomCV_MultiTimes(Atlas_Loading, psychopathology, Covariates, 112, 2, 1000, ResultantFolder, 1)


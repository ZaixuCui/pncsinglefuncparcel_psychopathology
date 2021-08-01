
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/Replication/scripts/AnalysisScripts/Functions');
import PLSr1_CZ_Random_RegressCovariates

ResultsFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/Replication/results';
# Import data
AtlasLoading_Mat = sio.loadmat(ResultsFolder + '/AtlasData/AtlasLoading/AtlasLoading_All_RemoveZero.mat');
SubjectsData = AtlasLoading_Mat['AtlasLoading_All_RemoveZero'];

Psychopathology_Mat = sio.loadmat(ResultsFolder + '/Psychopathology_790.mat');
PhobiasFactor = Psychopathology_Mat['phobias_4factorv2'];
Covariates = np.zeros((790, 3));
Covariates[:,0] = Psychopathology_Mat['Sex'];
Covariates[:,1] = Psychopathology_Mat['AgeYears'];
Covariates[:,2] = Psychopathology_Mat['Motion'];

# Range of parameters
ComponentNumber_Range = np.arange(10) + 1;
FoldQuantity = 2;
Parallel_Quantity = 1;

# Predict
AtlasLoading_Folder = ResultsFolder + '/PLSr1/AtlasLoading';
ResultantFolder = AtlasLoading_Folder + '/PhobiasFactor_All_RegressCovariates_RandomCV';
PLSr1_CZ_Random_RegressCovariates.PLSr1_KFold_RandomCV_MultiTimes(SubjectsData, PhobiasFactor, Covariates, FoldQuantity, ComponentNumber_Range, 101, ResultantFolder, Parallel_Quantity, 0, 'all.q')

# Permutation
ResultantFolder = AtlasLoading_Folder + '/PhobiasFactor_All_RegressCovariates_RandomCV_Permutation';
PLSr1_CZ_Random_RegressCovariates.PLSr1_KFold_RandomCV_MultiTimes(SubjectsData, PhobiasFactor, Covariates, FoldQuantity, ComponentNumber_Range, 1000, ResultantFolder, Parallel_Quantity, 1, 'all.q')



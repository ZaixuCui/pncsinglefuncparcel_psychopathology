
% Significance
% Psychosis
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
PsychosisFolder = [PLSr1_Folder '/PsychosisFactor_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([PsychosisFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_PsychosisFactor_Actual(i) = tmp.Mean_Corr;
  MAE_PsychosisFactor_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/PsychosisFactor_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_PsychosisFactor_Perm(i) = tmp.Mean_Corr;
  MAE_PsychosisFactor_Perm(i) = tmp.Mean_MAE;
end
Corr_PsychosisFactor_P = length(find(Corr_PsychosisFactor_Perm > median(Corr_PsychosisFactor_Actual))) / length(Corr_PsychosisFactor_Perm)
MAE_PsychosisFactor_P = length(find(MAE_PsychosisFactor_Perm < median(MAE_PsychosisFactor_Actual))) / length(MAE_PsychosisFactor_Perm)
save([PLSr1_Folder '/PsychosisFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_PsychosisFactor.mat'], 'Corr_PsychosisFactor_Actual', 'MAE_PsychosisFactor_Actual', 'Corr_PsychosisFactor_Perm', 'MAE_PsychosisFactor_Perm', 'Corr_PsychosisFactor_P', 'MAE_PsychosisFactor_P')

% Significance
% Fear/Phobias
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
FearFolder = [PLSr1_Folder '/PhobiasFactor_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([FearFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_FearFactor_Actual(i) = tmp.Mean_Corr;
  MAE_FearFactor_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/PhobiasFactor_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_FearFactor_Perm(i) = tmp.Mean_Corr;
  MAE_FearFactor_Perm(i) = tmp.Mean_MAE;
end
Corr_FearFactor_P = length(find(Corr_FearFactor_Perm > median(Corr_FearFactor_Actual))) / length(Corr_FearFactor_Perm)
MAE_FearFactor_P = length(find(MAE_FearFactor_Perm < median(MAE_FearFactor_Actual))) / length(MAE_FearFactor_Perm)
save([PLSr1_Folder '/PhobiasFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_FearFactor.mat'], 'Corr_FearFactor_Actual', 'MAE_FearFactor_Actual', 'Corr_FearFactor_Perm', 'MAE_FearFactor_Perm', 'Corr_FearFactor_P', 'MAE_FearFactor_P')

% Externalizing
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
ExternalizingFolder = [PLSr1_Folder '/ExternalizingFactor_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([ExternalizingFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_ExternalizingFactor_Actual(i) = tmp.Mean_Corr;
  MAE_ExternalizingFactor_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/ExternalizingFactor_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_ExternalizingFactor_Perm(i) = tmp.Mean_Corr;
  MAE_ExternalizingFactor_Perm(i) = tmp.Mean_MAE;
end
Corr_ExternalizingFactor_P = length(find(Corr_ExternalizingFactor_Perm > median(Corr_ExternalizingFactor_Actual))) / length(Corr_ExternalizingFactor_Perm)
MAE_ExternalizingFactor_P = length(find(MAE_ExternalizingFactor_Perm < median(MAE_ExternalizingFactor_Actual))) / length(MAE_ExternalizingFactor_Perm)
save([PLSr1_Folder '/ExternalizingFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_ExternalizingFactor.mat'], 'Corr_ExternalizingFactor_Actual', 'MAE_ExternalizingFactor_Actual', 'Corr_ExternalizingFactor_Perm', 'MAE_ExternalizingFactor_Perm', 'Corr_ExternalizingFactor_P', 'MAE_ExternalizingFactor_P')

% Anxious-misery/Mood
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
MoodFolder = [PLSr1_Folder '/MoodFactor_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([MoodFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_MoodFactor_Actual(i) = tmp.Mean_Corr;
  MAE_MoodFactor_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/MoodFactor_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_MoodFactor_Perm(i) = tmp.Mean_Corr;
  MAE_MoodFactor_Perm(i) = tmp.Mean_MAE;
end
Corr_MoodFactor_P = length(find(Corr_MoodFactor_Perm > median(Corr_MoodFactor_Actual))) / length(Corr_MoodFactor_Perm)
MAE_MoodFactor_P = length(find(MAE_MoodFactor_Perm < median(MAE_MoodFactor_Actual))) / length(MAE_MoodFactor_Perm)
save([PLSr1_Folder '/MoodFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_MoodFactor.mat'], 'Corr_MoodFactor_Actual', 'MAE_MoodFactor_Actual', 'Corr_MoodFactor_Perm', 'MAE_MoodFactor_Perm', 'Corr_MoodFactor_P', 'MAE_MoodFactor_P')


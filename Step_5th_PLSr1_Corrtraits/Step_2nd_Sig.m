
% Significance
% Fear
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
FearFolder = [PLSr1_Folder '/FearCorrtraits_All_RegressCovariates_RandomCV'];
% we have 101 times for actual to facilitate to calculate the median value
% Using the loop from 0 to 100, so finally the Corr_Fear_Actual follows this order
for i = 1:101 
  tmp = load([FearFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_Fear_Actual(i) = tmp.Mean_Corr;
  MAE_Fear_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/FearCorrtraits_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell) % we have 1000 times for permutation
  tmp = load(PermCell{i});
  Corr_Fear_Perm(i) = tmp.Mean_Corr;
  MAE_Fear_Perm(i) = tmp.Mean_MAE;
end
Corr_Fear_P = length(find(Corr_Fear_Perm > median(Corr_Fear_Actual))) / length(Corr_Fear_Perm)
MAE_Fear_P = length(find(MAE_Fear_Perm < median(MAE_Fear_Actual))) / length(MAE_Fear_Perm)
save([PLSr1_Folder '/FearCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Fear.mat'], 'Corr_Fear_Actual', 'MAE_Fear_Actual', 'Corr_Fear_Perm', 'MAE_Fear_Perm', 'Corr_Fear_P', 'MAE_Fear_P')

% Psychosis
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
PsychosisFolder = [PLSr1_Folder '/PsychosisCorrtraits_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([PsychosisFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_Psychosis_Actual(i) = tmp.Mean_Corr;
  MAE_Psychosis_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/PsychosisCorrtraits_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_Psychosis_Perm(i) = tmp.Mean_Corr;
  MAE_Psychosis_Perm(i) = tmp.Mean_MAE;
end
Corr_Psychosis_P = length(find(Corr_Psychosis_Perm > median(Corr_Psychosis_Actual))) / length(Corr_Psychosis_Perm)
MAE_Psychosis_P = length(find(MAE_Psychosis_Perm < median(MAE_Psychosis_Actual))) / length(MAE_Psychosis_Perm)
save([PLSr1_Folder '/PsychosisCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Psychosis.mat'], 'Corr_Psychosis_Actual', 'MAE_Psychosis_Actual', 'Corr_Psychosis_Perm', 'MAE_Psychosis_Perm', 'Corr_Psychosis_P', 'MAE_Psychosis_P')

% Externalizing
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
ExternalizingFolder = [PLSr1_Folder '/ExternalizingCorrtraits_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([ExternalizingFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_Externalizing_Actual(i) = tmp.Mean_Corr;
  MAE_Externalizing_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/ExternalizingCorrtraits_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_Externalizing_Perm(i) = tmp.Mean_Corr;
  MAE_Externalizing_Perm(i) = tmp.Mean_MAE;
end
Corr_Externalizing_P = length(find(Corr_Externalizing_Perm > median(Corr_Externalizing_Actual))) / length(Corr_Externalizing_Perm)
MAE_Externalizing_P = length(find(MAE_Externalizing_Perm < median(MAE_Externalizing_Actual))) / length(MAE_Externalizing_Perm)
save([PLSr1_Folder '/ExternalizingCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Externalizing.mat'], 'Corr_Externalizing_Actual', 'MAE_Externalizing_Actual', 'Corr_Externalizing_Perm', 'MAE_Externalizing_Perm', 'Corr_Externalizing_P', 'MAE_Externalizing_P')

% Mood
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
MoodFolder = [PLSr1_Folder '/MoodCorrtraits_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([MoodFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_Mood_Actual(i) = tmp.Mean_Corr;
  MAE_Mood_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/MoodCorrtraits_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_Mood_Perm(i) = tmp.Mean_Corr;
  MAE_Mood_Perm(i) = tmp.Mean_MAE;
end
Corr_Mood_P = length(find(Corr_Mood_Perm > median(Corr_Mood_Actual))) / length(Corr_Mood_Perm)
MAE_Mood_P = length(find(MAE_Mood_Perm < median(MAE_Mood_Actual))) / length(MAE_Mood_Perm)
save([PLSr1_Folder '/MoodCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Mood.mat'], 'Corr_Mood_Actual', 'MAE_Mood_Actual', 'Corr_Mood_Perm', 'MAE_Mood_Perm', 'Corr_Mood_P', 'MAE_Mood_P')


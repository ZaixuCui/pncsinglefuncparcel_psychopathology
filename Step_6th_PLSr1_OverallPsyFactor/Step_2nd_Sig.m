
% Significance
% Overall psychopathology
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSr1_Folder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading'];
OverallPsyFolder = [PLSr1_Folder '/OverallPsyFactor_All_RegressCovariates_RandomCV'];
for i = 1:101
  tmp = load([OverallPsyFolder '/Time_' num2str(i - 1) '/Res_NFold.mat']);
  Corr_OverallPsyFactor_Actual(i) = tmp.Mean_Corr;
  MAE_OverallPsyFactor_Actual(i) = tmp.Mean_MAE;
end
PermCell = g_ls([PLSr1_Folder '/OverallPsyFactor_All_RegressCovariates_RandomCV_Permutation/*/Res_NFold.mat']);
for i = 1:length(PermCell)
  tmp = load(PermCell{i});
  Corr_OverallPsyFactor_Perm(i) = tmp.Mean_Corr;
  MAE_OverallPsyFactor_Perm(i) = tmp.Mean_MAE;
end
Corr_OverallPsyFactor_P = length(find(Corr_OverallPsyFactor_Perm > median(Corr_OverallPsyFactor_Actual))) / length(Corr_OverallPsyFactor_Perm)
MAE_OverallPsyFactor_P = length(find(MAE_OverallPsyFactor_Perm < median(MAE_OverallPsyFactor_Actual))) / length(MAE_OverallPsyFactor_Perm)
save([PLSr1_Folder '/OverallPsyFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_OverallPsyFactor.mat'], 'Corr_OverallPsyFactor_Actual', 'MAE_OverallPsyFactor_Actual', 'Corr_OverallPsyFactor_Perm', 'MAE_OverallPsyFactor_Perm', 'Corr_OverallPsyFactor_P', 'MAE_OverallPsyFactor_P')


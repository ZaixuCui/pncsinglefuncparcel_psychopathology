
clear

% Significance
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSca_Folder = [ProjectFolder '/Replication/results/PLSca/AtlasLoading'];
Res_Cell = g_ls([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/*/Res_NFold.mat']);
for i = 1:length(Res_Cell)
    tmp = load(Res_Cell{i});
    Corr_Actual(i) = tmp.Mean_Corr(1);
end

% Permutation
Permutation_Cell = g_ls([PLSca_Folder '/RandomCV_RegressCovariates_All_2Fold_Permutation/*/Res_NFold.mat']);
for i = 1:length(Permutation_Cell)
  tmp = load(Permutation_Cell{i});
  Corr_Permutation(i) = tmp.Mean_Corr(1);
end
Corr_Sig = length(find(Corr_Permutation > median(Corr_Actual))) / length(Permutation_Cell)

% Average covariance
Res_Cell = g_ls([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/*/Fold_*_Score.mat']);
for i = 1:length(Res_Cell)
  tmp = load(Res_Cell{i});
  CovarianceExplained(i, :) = tmp.Covariances;
end
CovarianceExplained_Median = median(CovarianceExplained);
save([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/2Fold_RandomCV_Corr_PLSca_Comp1.mat'], 'Corr_Actual', 'Corr_Permutation', 'Corr_Sig', 'CovarianceExplained_Median');


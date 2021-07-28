
library(R.matlab)

ProjectFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication';
OverallPsyFactor_Weight = readMat(paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/w_Brain_OverallPsyFactor_Abs_sum.mat'));
Weight_lh = OverallPsyFactor_Weight$w.Brain.OverallPsyFactor.Abs.sum.lh;
Weight_rh = OverallPsyFactor_Weight$w.Brain.OverallPsyFactor.Abs.sum.rh;

SNR_Mask_Mat = readMat(paste0(ProjectFolder, '/data/SNR_Mask_fsaverage5/SNR_Mask.mat'));
Weight_lh[which(SNR_Mask_Mat$SNR.Mask.lh == 0)] = 100;
Weight_rh[which(SNR_Mask_Mat$SNR.Mask.rh == 0)] = 100;

SpinTest_Folder = paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/PermuteData_SpinTest');
dir.create(SpinTest_Folder, recursive = TRUE);

Weight_lh_CSV = data.frame(Weight_lh = t(Weight_lh));
Weight_rh_CSV = data.frame(Weight_rh = t(Weight_rh));

write.table(Weight_lh_CSV, paste0(SpinTest_Folder, '/Weight_lh.csv'), row.names = FALSE, col.names = FALSE);
write.table(Weight_rh_CSV, paste0(SpinTest_Folder, '/Weight_rh.csv'), row.names = FALSE, col.names = FALSE);



library(R.matlab)

ProjectFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication';

# PLSr1
# Fear
PLSr1_Fear_Weight = readMat(paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Fear_RandomCV/w_Brain_Fear_Abs_sum.mat'));
PLSr1_Fear_Weight_lh = as.numeric(PLSr1_Fear_Weight$w.Brain.Fear.Abs.sum.lh);
PLSr1_Fear_Weight_rh = as.numeric(PLSr1_Fear_Weight$w.Brain.Fear.Abs.sum.rh);
# Psychosis
PLSr1_Psychosis_Weight = readMat(paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Psychosis_RandomCV/w_Brain_Psychosis_Abs_sum.mat'));
PLSr1_Psychosis_Weight_lh = as.numeric(PLSr1_Psychosis_Weight$w.Brain.Psychosis.Abs.sum.lh);
PLSr1_Psychosis_Weight_rh = as.numeric(PLSr1_Psychosis_Weight$w.Brain.Psychosis.Abs.sum.rh);
# Externalizing
PLSr1_Externalizing_Weight = readMat(paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Externalizing_RandomCV/w_Brain_Externalizing_Abs_sum.mat'));
PLSr1_Externalizing_Weight_lh = as.numeric(PLSr1_Externalizing_Weight$w.Brain.Externalizing.Abs.sum.lh);
PLSr1_Externalizing_Weight_rh = as.numeric(PLSr1_Externalizing_Weight$w.Brain.Externalizing.Abs.sum.rh);

SNR_Mask_Mat = readMat(paste0(ProjectFolder, '/data/SNR_Mask_fsaverage5/SNR_Mask.mat'));
PLSr1_Fear_Weight_lh[which(SNR_Mask_Mat$SNR.Mask.lh == 0)] = 100;
PLSr1_Fear_Weight_rh[which(SNR_Mask_Mat$SNR.Mask.rh == 0)] = 100;
PLSr1_Psychosis_Weight_lh[which(SNR_Mask_Mat$SNR.Mask.lh == 0)] = 100;
PLSr1_Psychosis_Weight_rh[which(SNR_Mask_Mat$SNR.Mask.rh == 0)] = 100;
PLSr1_Externalizing_Weight_lh[which(SNR_Mask_Mat$SNR.Mask.lh == 0)] = 100;
PLSr1_Externalizing_Weight_rh[which(SNR_Mask_Mat$SNR.Mask.rh == 0)] = 100;

SpinTest_Folder = paste0(ProjectFolder, '/results/PLSr1/AtlasLoading/PermuteData_SpinTest');
dir.create(SpinTest_Folder, recursive = TRUE);
# Fear
PLSr1_Fear_Weight_lh_CSV = data.frame(PLSr1_Fear_Weight_lh = PLSr1_Fear_Weight_lh);
PLSr1_Fear_Weight_rh_CSV = data.frame(PLSr1_Fear_Weight_rh = PLSr1_Fear_Weight_rh);
write.table(PLSr1_Fear_Weight_lh_CSV, paste0(SpinTest_Folder, '/PLSr1_Fear_Weight_lh.csv'), row.names = FALSE, col.names = FALSE);
write.table(PLSr1_Fear_Weight_rh_CSV, paste0(SpinTest_Folder, '/PLSr1_Fear_Weight_rh.csv'), row.names = FALSE, col.names = FALSE);
# Psychosis
PLSr1_Psychosis_Weight_lh_CSV = data.frame(PLSr1_Psychosis_Weight_lh = PLSr1_Psychosis_Weight_lh);
PLSr1_Psychosis_Weight_rh_CSV = data.frame(PLSr1_Psychosis_Weight_rh = PLSr1_Psychosis_Weight_rh);
write.table(PLSr1_Psychosis_Weight_lh_CSV, paste0(SpinTest_Folder, '/PLSr1_Psychosis_Weight_lh.csv'), row.names = FALSE, col.names = FALSE);
write.table(PLSr1_Psychosis_Weight_rh_CSV, paste0(SpinTest_Folder, '/PLSr1_Psychosis_Weight_rh.csv'), row.names = FALSE, col.names = FALSE);
# Externalizing
PLSr1_Externalizing_Weight_lh_CSV = data.frame(PLSr1_Externalizing_Weight_lh = PLSr1_Externalizing_Weight_lh);
PLSr1_Externalizing_Weight_rh_CSV = data.frame(PLSr1_Externalizing_Weight_rh = PLSr1_Externalizing_Weight_rh);
write.table(PLSr1_Externalizing_Weight_lh_CSV, paste0(SpinTest_Folder, '/PLSr1_Externalizing_Weight_lh.csv'), row.names = FALSE, col.names = FALSE);
write.table(PLSr1_Externalizing_Weight_rh_CSV, paste0(SpinTest_Folder, '/PLSr1_Externalizing_Weight_rh.csv'), row.names = FALSE, col.names = FALSE);




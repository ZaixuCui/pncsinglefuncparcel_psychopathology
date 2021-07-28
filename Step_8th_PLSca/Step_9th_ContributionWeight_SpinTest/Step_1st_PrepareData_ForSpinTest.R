
library(R.matlab)

ProjectFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication';

# PLSca
PLSca_Weight = readMat(paste0(ProjectFolder, '/results/PLSca/AtlasLoading/Visualize/w_Brain_PLSca_Abs_sum.mat'));
PLSca_Weight_lh = as.numeric(PLSca_Weight$w.Brain.PLSca.Abs.sum.lh);
PLSca_Weight_rh = as.numeric(PLSca_Weight$w.Brain.PLSca.Abs.sum.rh);

SNR_Mask_Mat = readMat(paste0(ProjectFolder, '/data/SNR_Mask_fsaverage5/SNR_Mask.mat'));
PLSca_Weight_lh[which(SNR_Mask_Mat$SNR.Mask.lh == 0)] = 100;
PLSca_Weight_rh[which(SNR_Mask_Mat$SNR.Mask.rh == 0)] = 100;

SpinTest_Folder = paste0(ProjectFolder, '/results/PLSca/AtlasLoading/Visualize/PermuteData_SpinTest');
dir.create(SpinTest_Folder, recursive = TRUE);

PLSca_Weight_lh_CSV = data.frame(PLSca_Weight_lh = PLSca_Weight_lh);
PLSca_Weight_rh_CSV = data.frame(PLSca_Weight_rh = PLSca_Weight_rh);

write.table(PLSca_Weight_lh_CSV, paste0(SpinTest_Folder, '/PLSca_Weight_lh.csv'), row.names = FALSE, col.names = FALSE);
write.table(PLSca_Weight_rh_CSV, paste0(SpinTest_Folder, '/PLSca_Weight_rh.csv'), row.names = FALSE, col.names = FALSE);




clear
SpinTest_Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSca/AtlasLoading/Visualize/PermuteData_SpinTest';

% Weight, 17 systems mean
Weight_lh_CSV_Path = [SpinTest_Folder '/PLSca_Weight_lh.csv'];
Weight_rh_CSV_Path = [SpinTest_Folder '/PLSca_Weight_rh.csv'];
Weight_Perm_File = [SpinTest_Folder '/PLSca_Weight_Perm.mat'];
SpinPermuFS(Weight_lh_CSV_Path, Weight_rh_CSV_Path, 1000, Weight_Perm_File);


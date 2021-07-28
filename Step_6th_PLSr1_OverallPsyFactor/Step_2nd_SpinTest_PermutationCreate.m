
clear
SpinTest_Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading/PermuteData_SpinTest';

Weight_lh_CSV_Path = [SpinTest_Folder, '/PLSr1_Fear_Weight_lh.csv'];
Weight_rh_CSV_Path = [SpinTest_Folder, '/PLSr1_Fear_Weight_rh.csv'];
Weight_Perm_File = [SpinTest_Folder '/PLSr1_Fear_Weight_Perm.mat'];
SpinPermuFS(Weight_lh_CSV_Path, Weight_rh_CSV_Path, 1000, Weight_Perm_File);

Weight_lh_CSV_Path = [SpinTest_Folder, '/PLSr1_Psychosis_Weight_lh.csv'];
Weight_rh_CSV_Path = [SpinTest_Folder, '/PLSr1_Psychosis_Weight_rh.csv'];
Weight_Perm_File = [SpinTest_Folder '/PLSr1_Psychosis_Weight_Perm.mat'];
SpinPermuFS(Weight_lh_CSV_Path, Weight_rh_CSV_Path, 1000, Weight_Perm_File);

Weight_lh_CSV_Path = [SpinTest_Folder, '/PLSr1_Externalizing_Weight_lh.csv'];
Weight_rh_CSV_Path = [SpinTest_Folder, '/PLSr1_Externalizing_Weight_rh.csv'];
Weight_Perm_File = [SpinTest_Folder '/PLSr1_Externalizing_Weight_Perm.mat'];
SpinPermuFS(Weight_lh_CSV_Path, Weight_rh_CSV_Path, 1000, Weight_Perm_File);




clear
SpinTest_Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/PermuteData_SpinTest';

% Weight, 17 systems mean
Weight_lh_CSV_Path = [SpinTest_Folder '/Weight_lh.csv'];
Weight_rh_CSV_Path = [SpinTest_Folder '/Weight_rh.csv'];
Weight_Perm_File = [SpinTest_Folder '/Weight_Perm.mat'];
SpinPermuFS(Weight_lh_CSV_Path, Weight_rh_CSV_Path, 1000, Weight_Perm_File);


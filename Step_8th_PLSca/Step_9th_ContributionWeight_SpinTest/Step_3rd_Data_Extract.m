
clear
ProjectFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication';

surfML = [ProjectFolder '/data/SNR_Mask_fsaverage5/lh.Mask_SNR.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [ProjectFolder '/data/SNR_Mask_fsaverage5/rh.Mask_SNR.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

% Contribution weights
PLSca_Weight = load([ProjectFolder '/results/PLSca/AtlasLoading/Visualize/w_Brain_PLSca_Abs_sum.mat']);
PLSca_Weight_lh = PLSca_Weight.w_Brain_PLSca_Abs_sum_lh;
PLSca_Weight_rh = PLSca_Weight.w_Brain_PLSca_Abs_sum_rh;
PLSca_Weight_All_NoMedialWall = [PLSca_Weight_lh(Index_l) PLSca_Weight_rh(Index_r)];
% Permuted weights
SpinTest_Folder = [ProjectFolder '/results/PLSca/AtlasLoading/Visualize/PermuteData_SpinTest'];
PLSca_Weight_Perm_data = load([SpinTest_Folder '/PLSca_Weight_Perm.mat']);
PLSca_Weight_Perm_All_NoMedialWall = [PLSca_Weight_Perm_data.bigrotl(:, Index_l) PLSca_Weight_Perm_data.bigrotr(:, Index_r)];

% PLSR predict overall psychopathology factor
PLSR_Overall_Weight = load([ProjectFolder '/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/w_Brain_OverallPsyFactor_Abs_sum.mat']);
PLSR_Overall_Weight_lh = PLSR_Overall_Weight.w_Brain_OverallPsyFactor_Abs_sum_lh;
PLSR_Overall_Weight_rh = PLSR_Overall_Weight.w_Brain_OverallPsyFactor_Abs_sum_rh;
PLSR_Overall_Weight_NoMedialWall = [PLSR_Overall_Weight_lh(Index_l) PLSR_Overall_Weight_rh(Index_r)];

save([SpinTest_Folder '/AllData_2.mat'], ...
    'PLSca_Weight_All_NoMedialWall', ...
    'PLSca_Weight_Perm_All_NoMedialWall', ...
    'PLSR_Overall_Weight_NoMedialWall');


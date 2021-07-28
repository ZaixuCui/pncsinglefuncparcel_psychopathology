
clear
ProjectFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication';

surfML = [ProjectFolder '/data/SNR_Mask_fsaverage5/lh.Mask_SNR.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [ProjectFolder '/data/SNR_Mask_fsaverage5/rh.Mask_SNR.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

% Principal gradient
PrincipalGradient_lh = gifti([ProjectFolder '/data/Brain_Organization/PrincipalGradient/Gradients.lh.fsaverage5.func.gii']);
PrincipalGradient_rh = gifti([ProjectFolder '/data/Brain_Organization/PrincipalGradient/Gradients.rh.fsaverage5.func.gii']);
PrincipalGradient_lh = PrincipalGradient_lh.cdata(:, 1);
PrincipalGradient_rh = PrincipalGradient_rh.cdata(:, 1);
PrincipalGradient_All_NoMedialWall = [PrincipalGradient_lh(Index_l)' PrincipalGradient_rh(Index_r)'];

% Contribution weights
OverallPsyFactor_Weight = load([ProjectFolder '/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/w_Brain_OverallPsyFactor_Abs_sum.mat']);
Weight_lh = OverallPsyFactor_Weight.w_Brain_OverallPsyFactor_Abs_sum_lh;
Weight_rh = OverallPsyFactor_Weight.w_Brain_OverallPsyFactor_Abs_sum_rh;
Weight_All_NoMedialWall = [Weight_lh(Index_l) Weight_rh(Index_r)];
% Permuted weights
SpinTest_Folder = [ProjectFolder '/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/PermuteData_SpinTest'];
Weight_Perm_data = load([SpinTest_Folder '/Weight_Perm.mat']);
Weight_Perm_All_NoMedialWall = [Weight_Perm_data.bigrotl(:, Index_l) Weight_Perm_data.bigrotr(:, Index_r)];

% PLSr1 weights
% Fear
PLSr1_Fear_Weight = load([ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Fear_RandomCV/w_Brain_Fear_Abs_sum.mat']);
PLSr1_Fear_Weight_lh = PLSr1_Fear_Weight.w_Brain_Fear_Abs_sum_lh;
PLSr1_Fear_Weight_rh = PLSr1_Fear_Weight.w_Brain_Fear_Abs_sum_rh;
PLSr1_Fear_Weight_All_NoMedialWall = [PLSr1_Fear_Weight_lh(Index_l) PLSr1_Fear_Weight_rh(Index_r)];
% Psychosis
PLSr1_Psychosis_Weight = load([ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Psychosis_RandomCV/w_Brain_Psychosis_Abs_sum.mat']);
PLSr1_Psychosis_Weight_lh = PLSr1_Psychosis_Weight.w_Brain_Psychosis_Abs_sum_lh;
PLSr1_Psychosis_Weight_rh = PLSr1_Psychosis_Weight.w_Brain_Psychosis_Abs_sum_rh;
PLSr1_Psychosis_Weight_All_NoMedialWall = [PLSr1_Psychosis_Weight_lh(Index_l) PLSr1_Psychosis_Weight_rh(Index_r)];
% Externalizing
PLSr1_Externalizing_Weight = load([ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Externalizing_RandomCV/w_Brain_Externalizing_Abs_sum.mat']);
PLSr1_Externalizing_Weight_lh = PLSr1_Externalizing_Weight.w_Brain_Externalizing_Abs_sum_lh;
PLSr1_Externalizing_Weight_rh = PLSr1_Externalizing_Weight.w_Brain_Externalizing_Abs_sum_rh;
PLSr1_Externalizing_Weight_All_NoMedialWall = [PLSr1_Externalizing_Weight_lh(Index_l) PLSr1_Externalizing_Weight_rh(Index_r)];
% Anxious-misery
PLSr1_Mood_Weight = load([ProjectFolder, '/results/PLSr1/AtlasLoading/WeightVisualize_Mood_RandomCV/w_Brain_Mood_Abs_sum.mat']);
PLSr1_Mood_Weight_lh = PLSr1_Mood_Weight.w_Brain_Mood_Abs_sum_lh;
PLSr1_Mood_Weight_rh = PLSr1_Mood_Weight.w_Brain_Mood_Abs_sum_rh;
PLSr1_Mood_Weight_All_NoMedialWall = [PLSr1_Mood_Weight_lh(Index_l) PLSr1_Mood_Weight_rh(Index_r)];

save([SpinTest_Folder '/AllData.mat'], ...
    'PrincipalGradient_All_NoMedialWall', ...
    'Weight_All_NoMedialWall', 'Weight_Perm_All_NoMedialWall', ...
    'PLSr1_Fear_Weight_All_NoMedialWall', ...
    'PLSr1_Psychosis_Weight_All_NoMedialWall', ...
    'PLSr1_Externalizing_Weight_All_NoMedialWall', ...
    'PLSr1_Mood_Weight_All_NoMedialWall');


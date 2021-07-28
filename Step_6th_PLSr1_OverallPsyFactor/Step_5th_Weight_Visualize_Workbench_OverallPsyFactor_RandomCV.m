
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PredictionFolder = [ProjectFolder '/Replication/results/PLSr1/AtlasLoading/'];
Results_Cell = g_ls([PredictionFolder '/OverallPsyFactor_All_RegressCovariates_RandomCV/Time_*/Fold_*_Score.mat']);
for i = 1:length(Results_Cell)
  tmp = load(Results_Cell{i});
  w_Brain_OverallPsyFactor_AllModels(i, :) = tmp.w_Brain;
end
w_Brain_OverallPsyFactor = median(w_Brain_OverallPsyFactor_AllModels);
VisualizeFolder = [PredictionFolder '/WeightVisualize_OverallPsyFactor_RandomCV'];
mkdir(VisualizeFolder);
save([VisualizeFolder '/w_Brain_OverallPsyFactor.mat'], 'w_Brain_OverallPsyFactor');

% for surface data
surfML = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/lh.Mask_SNR.label'];
surfMR = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/rh.Mask_SNR.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

load([ProjectFolder '/Replication/results/AtlasData/AtlasLoading/AtlasLoading_All_RemoveZero.mat']); % NonZeroIndex was here
%%%%%%%%%%%%%%%%%%
% OverallPsyFactor Prediction %
%%%%%%%%%%%%%%%%%%
VertexQuantity = 17754;
%% Display sum absolute weight of the 17 maps
w_Brain_OverallPsyFactor_All = zeros(1, 17754*17);
w_Brain_OverallPsyFactor_All(NonZeroIndex) = w_Brain_OverallPsyFactor;
%% Display weight of all regions
for i = 1:17
    w_Brain_OverallPsyFactor_Matrix(i, :) = w_Brain_OverallPsyFactor_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save([VisualizeFolder '/w_Brain_OverallPsyFactor_Matrix.mat'], 'w_Brain_OverallPsyFactor_Matrix');

w_Brain_OverallPsyFactor_Abs_sum = sum(abs(w_Brain_OverallPsyFactor_Matrix));
w_Brain_OverallPsyFactor_Abs_sum_lh = zeros(1, 10242);
w_Brain_OverallPsyFactor_Abs_sum_lh(Index_l) = w_Brain_OverallPsyFactor_Abs_sum(1:length(Index_l));
w_Brain_OverallPsyFactor_Abs_sum_rh = zeros(1, 10242);
w_Brain_OverallPsyFactor_Abs_sum_rh(Index_r) = w_Brain_OverallPsyFactor_Abs_sum(length(Index_l) + 1:end);
save([VisualizeFolder '/w_Brain_OverallPsyFactor_Abs_sum.mat'], 'w_Brain_OverallPsyFactor_Abs_sum', ...
                         'w_Brain_OverallPsyFactor_Abs_sum_lh', 'w_Brain_OverallPsyFactor_Abs_sum_rh');

V_lh = gifti;
V_lh.cdata = w_Brain_OverallPsyFactor_Abs_sum_lh';
V_lh_File = [VisualizeFolder '/w_Brain_OverallPsyFactor_Abs_sum_RandomCV_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_rh = gifti;
V_rh.cdata = w_Brain_OverallPsyFactor_Abs_sum_rh';
V_rh_File = [VisualizeFolder '/w_Brain_OverallPsyFactor_Abs_sum_RandomCV_rh.func.gii'];
save(V_rh, V_rh_File);
% combine 
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_OverallPsyFactor_Abs_sum_RandomCV' ...
         '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);

%% Display the weight of the first 25% regions with the highest absolute weight
VertexQuantity = 17754;
mkdir([VisualizeFolder '/First25Percent']);
w_Brain_OverallPsyFactor_Abs = abs(w_Brain_OverallPsyFactor);
[~, Sorted_IDs] = sort(w_Brain_OverallPsyFactor_Abs);
w_Brain_OverallPsyFactor_FirstPercent = w_Brain_OverallPsyFactor;
w_Brain_OverallPsyFactor_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;
w_Brain_OverallPsyFactor_FirstPercent_All = zeros(1, 17754*17);
w_Brain_OverallPsyFactor_FirstPercent_All(NonZeroIndex) = w_Brain_OverallPsyFactor_FirstPercent;
for i = 1:17
    i
    w_Brain_OverallPsyFactor_FirstPercent_I = w_Brain_OverallPsyFactor_FirstPercent_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
    % left hemi
    w_Brain_OverallPsyFactor_FirstPercent_lh = zeros(1, 10242);
    w_Brain_OverallPsyFactor_FirstPercent_lh(Index_l) = w_Brain_OverallPsyFactor_FirstPercent_I(1:length(Index_l));
    V_lh = gifti;
    V_lh.cdata = w_Brain_OverallPsyFactor_FirstPercent_lh';
    V_lh_File = [VisualizeFolder '/First25Percent/w_Brain_OverallPsyFactor_First25Percent_lh_Network_' num2str(i) '.func.gii'];
    save(V_lh, V_lh_File);

    % right hemi
    w_Brain_OverallPsyFactor_FirstPercent_rh = zeros(1, 10242);
    w_Brain_OverallPsyFactor_FirstPercent_rh(Index_r) = w_Brain_OverallPsyFactor_FirstPercent_I(length(Index_l) + 1:end);
    V_rh = gifti;
    V_rh.cdata = w_Brain_OverallPsyFactor_FirstPercent_rh';
    V_rh_File = [VisualizeFolder '/First25Percent/w_Brain_OverallPsyFactor_First25Percent_rh_Network_' num2str(i) '.func.gii'];
    save(V_rh, V_rh_File);
    % convert into cifti file
    cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/First25Percent/w_Brain_OverallPsyFactor_First25Percent_Network_' ...
           num2str(i) '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
    system(cmd);
end


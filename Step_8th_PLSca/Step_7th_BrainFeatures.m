
clear
% Significance
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSca_Folder = [ProjectFolder '/Replication/results/PLSca/AtlasLoading'];
Weight_AllSubjects = load([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/Weight_AllSubjects_Update.mat']);
w_Brain_PLSca = median(Weight_AllSubjects.Brain_Weight_New);

% Visualizing
VisualizeFolder = [ProjectFolder '/Replication/results/PLSca/Visualize'];
mkdir(VisualizeFolder);
surfML = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/lh.Mask_SNR.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [ProjectFolder '/data/SNR_Mask/subjects/fsaverage5/rh.Mask_SNR.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

%%%%%%%%%%%%%%%%%%%%%
% PLSca Component 1 %
%%%%%%%%%%%%%%%%%%%%%
load([ProjectFolder '/Replication/results/AtlasData/AtlasLoading/AtlasLoading_All_RemoveZero.mat']); % NonZeroIndex was here
VertexQuantity = 17754;
%% Display sum absolute weight of the 17 maps
w_Brain_PLSca_All = zeros(1, 17754*17);
w_Brain_PLSca_All(NonZeroIndex) = w_Brain_PLSca;
%% Display weight of all regions
for i = 1:17
    w_Brain_PLSca_Matrix(i, :) = w_Brain_PLSca_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save([VisualizeFolder '/w_Brain_PLSca_Matrix.mat'], 'w_Brain_PLSca_Matrix');

w_Brain_PLSca_Abs_sum = sum(abs(w_Brain_PLSca_Matrix));
w_Brain_PLSca_Abs_sum_lh = zeros(1, 10242);
w_Brain_PLSca_Abs_sum_lh(Index_l) = w_Brain_PLSca_Abs_sum(1:length(Index_l));
w_Brain_PLSca_Abs_sum_rh = zeros(1, 10242);
w_Brain_PLSca_Abs_sum_rh(Index_r) = w_Brain_PLSca_Abs_sum(length(Index_l) + 1:end);
save([VisualizeFolder '/w_Brain_PLSca_Abs_sum.mat'], 'w_Brain_PLSca_Abs_sum', ...
                         'w_Brain_PLSca_Abs_sum_lh', 'w_Brain_PLSca_Abs_sum_rh');
V_lh = gifti;
V_lh.cdata = w_Brain_PLSca_Abs_sum_lh';
V_lh_File = [VisualizeFolder '/w_Brain_PLSca_Abs_sum_RandomCV_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_rh = gifti;
V_rh.cdata = w_Brain_PLSca_Abs_sum_rh';
V_rh_File = [VisualizeFolder '/w_Brain_PLSca_Abs_sum_RandomCV_rh.func.gii'];
save(V_rh, V_rh_File);
% combine 
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_PLSca_Abs_sum_RandomCV' ...
         '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);


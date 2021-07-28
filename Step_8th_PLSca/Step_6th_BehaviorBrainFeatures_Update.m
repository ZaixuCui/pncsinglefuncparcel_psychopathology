
clear
ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
PLSca_Folder = [ProjectFolder '/Replication/results/PLSca/AtlasLoading'];
Res_Cell = g_ls([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/*/Fold_*_Score.mat']);
% Correct the sign to make most signs in behavior side is positive
% Because we have 112 behavior feaature
for i = 1:length(Res_Cell)
  i
  tmp = load(Res_Cell{i});
  if length(find(tmp.Behavior_Weight(:, 1) > 0)) > 56 
    Behavior_Weight_New(i, :) = tmp.Behavior_Weight(:, 1);    
    Brain_Weight_New(i, :) = tmp.Brain_Weight(:, 1);
  else 
    Behavior_Weight_New(i, :) = -tmp.Behavior_Weight(:, 1);
    Brain_Weight_New(i, :) = -tmp.Brain_Weight(:, 1);    
  end
end

% Calculating BSR
BSR = median(Behavior_Weight_New) ./ std(Behavior_Weight_New);
length(find(BSR > 2.576)) % 2.576 corresponds to P=0.01

save([PLSca_Folder '/RandomCV_101Repeats_RegressCovariates_All_2Fold/Weight_AllSubjects_Update.mat'], 'Behavior_Weight_New', 'Brain_Weight_New', 'BSR');

% 
Psychopathology_Data = load([ProjectFolder '/Replication/results/Psychopathology_790.mat']);
Psychopathology_Colnames = Psychopathology_Data.Psychopathology_Colnames;
load([ProjectFolder '/data/OMI_Factor.mat']);
OMI_ItemNames = OMI_Factor.ItemName
% Search item that exists in both Psychopathology_Mat and OMI_Factor
num = 0;
for i = 1:112
    tmp = Psychopathology_Colnames{i};
    tmp(1) = char(tmp(1) - 32);
    tmp(2) = char(tmp(2) - 32);
    tmp(3) = char(tmp(3) - 32);
    ind = find(strcmp(OMI_ItemNames, tmp));
    if ~isempty(ind)
        num = num + 1;
        CommonItem{num} = tmp;
        BSR_New(num) = BSR(i);
        OMI_Factor_Weight(num, :) = OMI_Factor.Weight(ind, :);
    end
end

[m n] = corr(BSR_New', abs(OMI_Factor_Weight(:, 1)))
[m n] = corr(BSR_New', abs(OMI_Factor_Weight(:, 2)))
[m n] = corr(BSR_New', abs(OMI_Factor_Weight(:, 3)))
[m n] = corr(BSR_New', abs(OMI_Factor_Weight(:, 4)))
[m n] = corr(BSR_New', abs(OMI_Factor_Weight(:, 5)))




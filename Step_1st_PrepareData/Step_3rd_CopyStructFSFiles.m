
clear
%
% This step is to copy the freesurfer processing results of T1-weighted images
% Running this step is time-costly and also needs a lot of space
% Could skip this step and in the following just use the freesurfer processing data in the path:
%      /cbica/projects/GURLAB/projects/pncSingleFuncParcel_psycho/data/Structural
%
DataFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
Demogra_Info = csvread([DataFolder '/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);
ScanID = Demogra_Info(:, 2);

StrucFolder = '/cbica/projects/pncSingleFuncParcel/pncStructuralFS/data/structural/freesurfer53';
ResultantFolder = [DataFolder '/Structural'];
mkdir(ResultantFolder);
for i = 1:length(BBLID)
    %i
    Sub_Folder = [ResultantFolder '/' num2str(BBLID(i))];
    File = [Sub_Folder '/surf/lh.curv'];
    if ~exist(File, 'file')
      disp(i);
      cmd = ['cp -r ' StrucFolder '/' num2str(BBLID(i)) '/*x' num2str(ScanID(i)) '/ ' Sub_Folder];
      system(cmd);
    end
end

%
BBLID_Remain = [110153 110166 110168 110289 110324 110509];
for i = 1:length(BBLID_Remain)
  BBLID_tmp = BBLID_Remain(i);
  ind = find(BBLID == BBLID_tmp);
  scanID_tmp = ScanID(ind);
  Sub_Folder = [ResultantFolder '/' num2str(BBLID_tmp)];
  disp(i);
  cmd = ['cp -r ' StrucFolder '/' num2str(BBLID_tmp) '/*x' num2str(scanID_tmp) '/ ' Sub_Folder];
  disp(cmd);
  system(cmd);
end


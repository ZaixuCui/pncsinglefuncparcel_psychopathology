
clear
DataFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
Demogra_Info = csvread([DataFolder '/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);
ScanID = Demogra_Info(:, 2);

RawDataFolder = '/cbica/projects/pncSingleFuncParcel/pncStructuralFS/data/rawData/';
RestingOutput = [DataFolder '/SNR_Mask/RawImage/RestingState'];
NBackOutput = [DataFolder '/SNR_Mask/RawImage/NBack'];
EmotionIdenOutput = [DataFolder '/SNR_Mask/RawImage/EmotionIden'];
mkdir(RestingOutput);
mkdir(NBackOutput);
mkdir(EmotionIdenOutput);
% Step 1: Extract first signal data
for i = 1:length(BBLID)
  i
  BBLID_Str = num2str(BBLID(i));
  % Resting state
  Resting_Image = g_ls([RawDataFolder '/' num2str(BBLID(i)) '/*' num2str(ScanID(i)) ...
               '/*restbold1*/nifti/*.nii.gz']);
  cmd = ['export FSLOUTPUTTYPE=NIFTI_GZ; fslroi ' Resting_Image{1} ' ' RestingOutput '/' BBLID_Str ' 4 1'];
  system(cmd);
  % NBack
  NBack_Image = g_ls([RawDataFolder '/' num2str(BBLID(i)) '/*' num2str(ScanID(i)) ...
               '/*frac2back1*/nifti/*.nii.gz']);
  cmd = ['export FSLOUTPUTTYPE=NIFTI_GZ; fslroi ' NBack_Image{1} ' ' NBackOutput '/' BBLID_Str ' 0 1'];
  system(cmd);
  % Emotion identification
  Idemo_Image = g_ls([RawDataFolder '/' num2str(BBLID(i)) '/*' num2str(ScanID(i)) ...
               '/*idemo2*/nifti/*.nii.gz']);
  cmd = ['export FSLOUTPUTTYPE=NIFTI_GZ; fslroi ' Idemo_Image{1} ' ' EmotionIdenOutput '/' BBLID_Str ' 6 1'];
  system(cmd);
end



#
# The script projects the fMRI volume data of the three modalities into surface space (fsaverage5)
# Further brain parcellation will be working on the surface space
#

DataFolder='/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
StructuralFolder=${DataFolder}/Structural;
SubjectsIDCSV=${DataFolder}/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv;
# resting state processing
restingDir=${DataFolder}/processedData/restbold_201607151621
targDir_resting=${DataFolder}/SNR_Mask/RawImage_FS_Smooth/RestingState;
mkdir -p ${targDir_resting}
logs=${targDir_resting}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  ImagePath=${DataFolder}/SNR_Mask/RawImage/RestingState/${BBLID}.nii.gz
  SurfPath=`ls -d ${targDir_resting}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/AnalysisScripts/Functions/CZ_FSProjectToSurface_SNR.sh ${restingDir} ${ImagePath} ${targDir_resting} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}

# nback fmri processing
nbackDir=${DataFolder}/processedData/xcptaskregressed;
targDir_nback=${DataFolder}/SNR_Mask/RawImage_FS_Smooth/NBack;
mkdir -p ${targDir_nback}
logs=${targDir_nback}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  ImagePath=${DataFolder}/SNR_Mask/RawImage/NBack/${BBLID}.nii.gz
  SurfPath=`ls -d ${targDir_nback}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/AnalysisScripts/Functions/CZ_FSProjectToSurface_SNR.sh ${nbackDir} ${ImagePath} ${targDir_nback} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}

# emotion identification fmri processing
idemoDir=${DataFolder}/processedData/idemoConnect_201707
targDir_idemo=${DataFolder}/SNR_Mask/RawImage_FS_Smooth/EmotionIden
mkdir -p ${targDir_idemo}
logs=${targDir_idemo}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  ImagePath=${DataFolder}/SNR_Mask/RawImage/NBack/${BBLID}.nii.gz
  SurfPath=`ls -d ${targDir_idemo}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/AnalysisScripts/Functions/CZ_FSProjectToSurface_SNR.sh ${idemoDir} ${ImagePath} ${targDir_idemo} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}


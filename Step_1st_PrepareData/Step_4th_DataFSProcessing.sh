
#
# The script projects the fMRI volume data of the three modalities into surface space (fsaverage5)
# The data was smooth with 6mm kernel size in the surface space
# Further brain parcellation will be working on the surface space
#

DataFolder='/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
StructuralFolder=${DataFolder}/Structural;
SubjectsIDCSV=${DataFolder}/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv;
# resting state processing
restingDir=${DataFolder}/processedData/restbold_201607151621;
targDir_resting=${DataFolder}/SurfaceData/RestingState;
logs=${targDir_resting}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  SurfPath=`ls -d ${targDir_resting}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/Functions/CZ_FSProjectToSurface.sh ${restingDir} ${targDir_resting} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}

# nback fmri processing
nbackDir=${DataFolder}/processedData/xcptaskregressed;
targDir_nback=${DataFolder}/SurfaceData/NBack;
logs=${targDir_nback}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  SurfPath=`ls -d ${targDir_nback}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/Functions/CZ_FSProjectToSurface.sh ${nbackDir} ${targDir_nback} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}

# emotion identification fmri processing
idemoDir=${DataFolder}/processedData/idemoConnect_201707;
targDir_idemo=${DataFolder}/SurfaceData/EmotionIden;
logs=${targDir_idemo}/logs
while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ScanID=`echo $SubjectsID | cut -d "," -f 2`
  SurfPath=`ls -d ${targDir_idemo}/${BBLID}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${SurfPath}" != "X" ]; then
    echo "*-*-*-*-Projection has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/Functions/CZ_FSProjectToSurface.sh ${idemoDir} ${targDir_idemo} ${BBLID} ${ScanID} ${StructuralFolder}
  fi
done < ${SubjectsIDCSV}



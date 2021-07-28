
DataFolder='/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
SubjectsIDCSV=${DataFolder}/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv;
RSFolder=${DataFolder}/SurfaceData/RestingState;
NBackFolder=${DataFolder}/SurfaceData/NBack;
EmotionFolder=${DataFolder}/SurfaceData/EmotionIden;
ResultantFolder=${DataFolder}/SurfaceData/CombinedData;
logs=${ResultantFolder}/logs

while IFD=, read -r SubjectsID
do
  BBLID=`echo $SubjectsID | cut -d "," -f 1`
  ResultantFolder_I=${ResultantFolder}/${BBLID}
  ResultantFolder_I_Exist=`ls -d ${ResultantFolder_I}`
  if [ ${BBLID} == \"bblid\" ] || [ "X${ResultantFolder_I_Exist}" != "X" ]; then
    echo "*-*-*-*-Combination has already been run for this subject-*-*-*-*"
    continue
  else
    qsub -V -e ${logs} -o ${logs} -q all.q -S /bin/bash /cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/Functions/CZ_Merge3Modality_FS.sh ${RSFolder} ${NBackFolder} ${EmotionFolder} ${BBLID} ${ResultantFolder_I}
  fi
done < ${SubjectsIDCSV}


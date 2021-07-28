
. /etc/bashrc

export FREESURFER_HOME="/cbica/projects/GURLAB/projects/pncSingleFuncParcel_psycho/scripts/freesurfer/6.0.0"
. $FREESURFER_HOME/SetUpFreeSurfer.sh
export PATH=${PATH}:$FREESURFER_HOME/bin
export MNI_DIR=$FREESURFER_HOME/mni
export FSF_OUTPUT_FORMAT=nii
export FSFAST_HOME=$FREESURFER_HOME/fsfast

BBLID_Str=$3
ScanID_Str=$4
targDir=$2
rawDir=$1
export SUBJECTS_DIR=$5

mkdir -p ${targDir}/${BBLID_Str}/coreg
mkdir ${targDir}/${BBLID_Str}/surf

#registering native functional volume to native T1 volume
echo 'start registering subject '${BBLID_Str}
bbregister --s ${BBLID_Str} --mov ${rawDir}/referenceVolumeBrain/${BBLID_Str}*${ScanID_Str}*referenceVolumeBrain.nii.gz --reg ${targDir}/${BBLID_Str}/coreg/fs_ep2struct_fsl.dat --init-fsl --bold >> ${targDir}/${BBLID_Str}/coreg/${BBLID_Str}_coreg.log 2>&1
echo 'complete registering subject '${BBLID_Str}

hemi=('lh' 'rh')
for i in ${hemi[@]}; do
  # project volume to the surface
  echo 'start vol2surf projection for subject '${BBLID_Str}' on '${i}
  mri_vol2surf --mov ${rawDir}/residualisedData/${BBLID_Str}*${ScanID_Str}*residualised.nii.gz --reg ${targDir}/${BBLID_Str}/coreg/fs_ep2struct_fsl.dat --hemi ${i} --o ${targDir}/${BBLID_Str}/surf/${i}.sm6.residualised.mgh --projfrac 0.5 --interp trilinear --noreshape --surf-fwhm 6 >> ${targDir}/${BBLID_Str}/surf/${BBLID_Str}_projection.log 2>&1
  echo 'complete vol2surf projection for subject '${BBLID_Str}' on '${i}

  # down-sample the surface to fsaverage5
  mri_surf2surf --srcsubject ${BBLID_Str} --srcsurfval ${targDir}/${BBLID_Str}/surf/${i}.sm6.residualised.mgh --trgsubject ico --trgicoorder 5 --trgsurfval ${targDir}/${BBLID_Str}/surf/${i}.fs5.sm6.residualised.mgh --hemi ${i} >> ${targDir}/${BBLID_Str}/surf/${BBLID_Str}_projection.log 2>&1
  echo 'complete surf2surf resampling for subject '${BBLID_Str}' on '${i}
done


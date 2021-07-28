
. /etc/bashrc

export FREESURFER_HOME="/cbica/projects/GURLAB/projects/pncSingleFuncParcel_psycho/scripts/freesurfer/6.0.0"
. $FREESURFER_HOME/SetUpFreeSurfer.sh
export PATH=${PATH}:$FREESURFER_HOME/bin
export MNI_DIR=$FREESURFER_HOME/mni
export FSF_OUTPUT_FORMAT=nii
export FSFAST_HOME=$FREESURFER_HOME/fsfast

RSFolder=$1
NBackFolder=$2
IdEmotionFolder=$3
BBLID=$4
ResultantFolder=$5
mkdir ${ResultantFolder}

hemi=('lh' 'rh')
for i in ${hemi[@]};do
  RSFile=${RSFolder}/${BBLID}/surf/${i}.fs5.sm6.residualised.mgh
  NBackFile=${NBackFolder}/${BBLID}/surf/${i}.fs5.sm6.residualised.mgh
  IdEmotionFile=${IdEmotionFolder}/${BBLID}/surf/${i}.fs5.sm6.residualised.mgh
  ResultantFile=${ResultantFolder}/${i}.fs5.sm6.residualised.mgh
  mri_concat --i ${RSFile} --i ${NBackFile} --i ${IdEmotionFile} --o ${ResultantFile}
done


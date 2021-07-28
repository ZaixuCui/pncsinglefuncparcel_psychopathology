
library(R.matlab);

ProjectFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho';
###############################################
# Import demographics, cognition and strength #
###############################################
# Demographics, motion
AllInfo <- read.csv(paste0(ProjectFolder, '/data/n790_Psychopathology_20200326.csv'));
BBLID <- AllInfo$bblid;
AgeYears <- AllInfo$ageAtScan1/12;
Sex <- AllInfo$sex;
Motion_Rest <- AllInfo$restRelMeanRMSMotion;
Motion_NBack <- AllInfo$nbackRelMeanRMSMotion;
Motion_Emotion <- AllInfo$idemoRelMeanRMSMotion;
Motion <- (Motion_Rest + Motion_NBack + Motion_Emotion)/3;
overall_psychopathology_4factorv2 <- AllInfo$overall_psychopathology_4factorv2;
mood_4factorv2 <- AllInfo$mood_4factorv2;
psychosis_4factorv2 <- AllInfo$psychosis_4factorv2;
externalizing_4factorv2 <- AllInfo$externalizing_4factorv2;
phobias_4factorv2 <- AllInfo$phobias_4factorv2;
mood_corrtraitsv2 <- AllInfo$mood_corrtraitsv2;
psychosis_corrtraitsv2 <- AllInfo$psychosis_corrtraitsv2;
externalizing_corrtraitsv2 <- AllInfo$externalizing_corrtraitsv2;
fear_corrtraitsv2 <- AllInfo$fear_corrtraitsv2;

AllInfo_Matrix <- as.matrix(AllInfo);
Psychopathology_List <- AllInfo_Matrix[,53:164];
Allcolnames <- colnames(AllInfo);
Psychopathology_Colnames <- Allcolnames[53:164];

dir.create(paste0(ProjectFolder, '/Replication/results'));
writeMat(paste0(ProjectFolder, '/Replication/results/Psychopathology_790.mat'), 
    BBLID = BBLID, AgeYears = AgeYears, Sex = Sex, Motion = Motion, 
    overall_psychopathology_4factorv2 = overall_psychopathology_4factorv2, 
    mood_4factorv2 = mood_4factorv2,
    psychosis_4factorv2 = psychosis_4factorv2,
    externalizing_4factorv2 = externalizing_4factorv2, 
    phobias_4factorv2 = phobias_4factorv2,
    mood_corrtraitsv2 = mood_corrtraitsv2, 
    psychosis_corrtraitsv2 = psychosis_corrtraitsv2,
    externalizing_corrtraitsv2 = externalizing_corrtraitsv2, 
    fear_corrtraitsv2 = fear_corrtraitsv2,
    Psychopathology_List = Psychopathology_List, 
    Psychopathology_Colnames = Psychopathology_Colnames);


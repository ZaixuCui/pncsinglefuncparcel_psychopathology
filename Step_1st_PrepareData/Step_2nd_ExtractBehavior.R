
library(R.matlab)

DataFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data';
DemograBehaviorFolder = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/data/processedData/DemograBehavior';

subjid_df <- read.csv(paste0(DataFolder, "/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv"));
#########################################
### 2. Extrating behavior information ###
#########################################  
demo <- subjid_df;
# Demographics 
Demographics_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_demographics_go1_20161212.csv"));
# Motion
Rest_Motion_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_RestQAData_20170714.csv"));
NBack_Motion_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_NBACKQAData_20181001.csv"));
Idemo_Motion_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_idemo_FinalQA_092817.csv"));
# Cognition
Cognition_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_cnb_factor_scores_tymoore_20151006.csv"));
# Clinical
Psychopathology_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_goassess_112_itemwise_vars_20161214.csv"));
# Corrtraits
Corrtraits_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_goassess_itemwise_corrtraits_scores_20161219.csv"));
# Bifactor
Bifactor_Data <- read.csv(paste0(DemograBehaviorFolder, "/n1601_goassess_itemwise_bifactor_scores_20161219.csv"));
# Merge all data
demo <- merge(demo, Demographics_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Rest_Motion_Data, by = c("scanid", "bblid"));
demo <- merge(demo, NBack_Motion_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Idemo_Motion_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Psychopathology_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Corrtraits_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Bifactor_Data, by = c("scanid", "bblid"));
demo <- merge(demo, Cognition_Data, by = c("scanid", "bblid"));
# Output the subjects' behavior data
write.csv(demo, paste0(DataFolder, "/n790_Psychopathology_20200326.csv"), row.names = FALSE);



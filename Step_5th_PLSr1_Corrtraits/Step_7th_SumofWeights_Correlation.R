
library(R.matlab)
library(ggplot2)
library(corrplot)
library(RColorBrewer)

Fold = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading';
Weight_Data_Vertex = matrix(0, 79727, 4);
tmp = readMat(paste0(Fold, '/WeightVisualize_Externalizing_RandomCV/w_Brain_Externalizing.mat'));
Weight_Data_Vertex[, 1] = tmp$w.Brain.Externalizing;
tmp = readMat(paste0(Fold, '/WeightVisualize_Fear_RandomCV/w_Brain_Fear.mat'));
Weight_Data_Vertex[, 2] = tmp$w.Brain.Fear;
tmp = readMat(paste0(Fold, '/WeightVisualize_Mood_RandomCV/w_Brain_Mood.mat'));
Weight_Data_Vertex[, 3] = tmp$w.Brain.Mood;
tmp = readMat(paste0(Fold, '/WeightVisualize_Psychosis_RandomCV/w_Brain_Psychosis.mat'));
Weight_Data_Vertex[, 4] = tmp$w.Brain.Psychosis;
Weight_Data_Vertex = as.data.frame(Weight_Data_Vertex);
names(Weight_Data_Vertex)[names(Weight_Data_Vertex)=="V1"] <- "Externalizing";
names(Weight_Data_Vertex)[names(Weight_Data_Vertex)=="V2"] <- "Fear";
names(Weight_Data_Vertex)[names(Weight_Data_Vertex)=="V3"] <- "Mood";
names(Weight_Data_Vertex)[names(Weight_Data_Vertex)=="V4"] <- "Psychosis";
cor(Weight_Data_Vertex)

Fold = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading';
Weight_Data_Sum = matrix(0, 17, 4);
tmp = readMat(paste0(Fold, '/WeightVisualize_Externalizing_RandomCV/SumWeights_Externalizing.mat'));
Weight_Data_Sum[, 1] = tmp$SumWeights;
tmp = readMat(paste0(Fold, '/WeightVisualize_Fear_RandomCV/SumWeights_Fear.mat'));
Weight_Data_Sum[, 2] = tmp$SumWeights;
tmp = readMat(paste0(Fold, '/WeightVisualize_Mood_RandomCV/SumWeights_Mood.mat'));
Weight_Data_Sum[, 3] = tmp$SumWeights;
tmp = readMat(paste0(Fold, '/WeightVisualize_Psychosis_RandomCV/SumWeights_Psychosis.mat'));
Weight_Data_Sum[, 4] = tmp$SumWeights;
Weight_Data_Sum = as.data.frame(Weight_Data_Sum);
names(Weight_Data_Sum)[names(Weight_Data_Sum)=="V1"] <- "Externalizing";
names(Weight_Data_Sum)[names(Weight_Data_Sum)=="V2"] <- "Fear";
names(Weight_Data_Sum)[names(Weight_Data_Sum)=="V3"] <- "Mood";
names(Weight_Data_Sum)[names(Weight_Data_Sum)=="V4"] <- "Psychosis";
cor(Weight_Data_Sum)



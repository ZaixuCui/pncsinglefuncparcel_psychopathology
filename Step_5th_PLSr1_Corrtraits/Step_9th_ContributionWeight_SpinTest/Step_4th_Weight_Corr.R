
library(R.matlab)
library(ggplot2)
library(hexbin)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading/PermuteData_SpinTest';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

# Significance
# Fear vs. Psychosis
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Fear_Psychosis = tmp_data$estimate;
Perm_Corr_Weight_Fear_Psychosis = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Fear_Psychosis[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Fear_Psychosis >= Actual_Corr_Weight_Fear_Psychosis)) / 1000;
print(paste0('P value (Fear Weights vs. Psychosis Weights): ', as.character(P_Value)));

# Fear vs. Externalizing
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Fear_Externalizing = tmp_data$estimate;
Perm_Corr_Weight_Fear_Externalizing = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Fear_Externalizing[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Fear_Externalizing >= Actual_Corr_Weight_Fear_Externalizing)) / 1000;
print(paste0('P value (Fear Weights vs. Externalizing Weights): ', as.character(P_Value)));

# Fear vs. Anxious-misery
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Fear_Mood = tmp_data$estimate;
Perm_Corr_Weight_Fear_Mood = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Fear.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Fear_Mood[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Fear_Mood >= Actual_Corr_Weight_Fear_Mood)) / 1000;
print(paste0('P value (Fear Weights vs. Mood Weights): ', as.character(P_Value)));

# Psychosis vs. Externalizing
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Psychosis_Externalizing = tmp_data$estimate;
Perm_Corr_Weight_Psychosis_Externalizing = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Psychosis.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Psychosis.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Psychosis_Externalizing[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Psychosis_Externalizing >= Actual_Corr_Weight_Psychosis_Externalizing)) / 1000;
print(paste0('P value (Psychosis Weights vs. Externalizing Weights): ', as.character(P_Value)));

# Psychosis vs. Anxious-misery
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Psychosis_Mood = tmp_data$estimate;
Perm_Corr_Weight_Psychosis_Mood = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Psychosis.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Psychosis.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Psychosis_Mood[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Psychosis_Mood >= Actual_Corr_Weight_Psychosis_Mood)) / 1000;
print(paste0('P value (Psychosis Weights vs. Mood Weights): ', as.character(P_Value)));

# Externalizing vs. Anxious-misery
tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Externalizing_Mood = tmp_data$estimate;
Perm_Corr_Weight_Externalizing_Mood = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSr1.Externalizing.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSr1.Externalizing.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Externalizing_Mood[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Externalizing_Mood >= Actual_Corr_Weight_Externalizing_Mood)) / 1000;
print(paste0('P value (Externalizing Weights vs. Mood Weights): ', as.character(P_Value)));



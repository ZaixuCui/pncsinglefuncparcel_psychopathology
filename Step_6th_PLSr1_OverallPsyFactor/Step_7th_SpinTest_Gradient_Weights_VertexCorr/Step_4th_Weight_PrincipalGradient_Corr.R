
library(R.matlab)
library(ggplot2)
library(hexbin)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading/WeightVisualize_OverallPsyFactor_RandomCV/PermuteData_SpinTest';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

# plot the highest correlation
myPalette <- c("#333333", "#4C4C4C", "#666666", "#7F7F7F", "#999999", "#B2B2B2", "#CCCCCC");
# Age prediction weights (random CV) vs. atlas variability
# Weight vs. Principal Gradient
data_Corr = data.frame(Weight_Data = as.numeric(t(Data_Mat$Weight.All.NoMedialWall)));
data_Corr$PrincipalGradient = as.numeric(Data_Mat$PrincipalGradient.All.NoMedialWall);
cor.test(data_Corr$Weight_Data, data_Corr$PrincipalGradient, method = "pearson");

hexinfo <- hexbin(data_Corr$PrincipalGradient, data_Corr$Weight_Data, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
         geom_hex(data = subset(data_hex, count >= 10), aes(x, y, fill = count), stat = "identity") +
         scale_fill_gradientn(colours = myPalette, breaks = c(100, 200)) +
         geom_smooth(data = data_Corr, aes(x = PrincipalGradient, y = Weight_Data), method = lm, color = "#FFFFFF", linetype = "dashed") +
         theme_classic() + labs(x = "Principal Gradient", y = "Contribution Weight") +
         theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
         theme(legend.text = element_text(size = 30), legend.title = element_text(size = 30)) +
         theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
         scale_x_continuous(limits = c(-5.5, 6.9), breaks = c(-5.0, -2.5, 0, 2.5, 5.0)) +
         scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03));
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure6_OverallPsychopathology/Weight_PrincipalGradient_Corr.tiff', width = 17, height = 15, dpi = 600, units = "cm");

# Significance
# AgeWeights (Random CV) vs. variability 
tmp_data = cor.test(as.numeric(Data_Mat$Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PrincipalGradient.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_PrincipalGradient = tmp_data$estimate;
Perm_Corr_Weight_PrincipalGradient = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PrincipalGradient.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_PrincipalGradient[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_PrincipalGradient >= Actual_Corr_Weight_PrincipalGradient)) / 1000;
print(paste0('P value (variability vs. age prediction weights): ', as.character(P_Value)));
# Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Weight_PrincipalGradient));
PermutationData$Line_x = as.numeric(matrix(Actual_Corr_Weight_PrincipalGradient, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,91,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=80, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.3, 0.32), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'));
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure6_OverallPsychopathology/SpinTest_Weights_PrincipalGradient.tiff', width = 17, height = 15, dpi = 600, units = "cm");

# Correlation with weight map of the four correlated dimensions
# Overall psychopathology factor vs. Fear
tmp_data = cor.test(as.numeric(Data_Mat$Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Fear.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Overall_Fear = tmp_data$estimate;
Perm_Corr_Weight_Overall_Fear = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Fear.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Overall_Fear[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Overall_Fear >= Actual_Corr_Weight_Overall_Fear)) / 1000;
# Overall vs. Psychosis
tmp_data = cor.test(as.numeric(Data_Mat$Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Overall_Psychosis = tmp_data$estimate;
Perm_Corr_Weight_Overall_Psychosis = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Psychosis.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Overall_Psychosis[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Overall_Psychosis >= Actual_Corr_Weight_Overall_Psychosis)) / 1000;
# Overall vs. Externalizing
tmp_data = cor.test(as.numeric(Data_Mat$Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Overall_Externalizing = tmp_data$estimate;
Perm_Corr_Weight_Overall_Externalizing = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Externalizing.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Overall_Externalizing[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Overall_Externalizing >= Actual_Corr_Weight_Overall_Externalizing)) / 1000;
# Overall vs. Anxious-misery
tmp_data = cor.test(as.numeric(Data_Mat$Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall), method = "pearson");
Actual_Corr_Weight_Overall_Mood = tmp_data$estimate;
Perm_Corr_Weight_Overall_Mood = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSr1.Mood.Weight.All.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_Overall_Mood[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_Overall_Mood >= Actual_Corr_Weight_Overall_Mood)) / 1000;

print((Actual_Corr_Weight_Overall_Mood + Actual_Corr_Weight_Overall_Externalizing + Actual_Corr_Weight_Overall_Psychosis + Actual_Corr_Weight_Overall_Fear)/4)


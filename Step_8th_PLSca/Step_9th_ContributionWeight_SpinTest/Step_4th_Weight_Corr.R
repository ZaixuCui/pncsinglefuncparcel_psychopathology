
library(R.matlab)
library(ggplot2)
library(hexbin)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSca/AtlasLoading/Visualize/PermuteData_SpinTest';
Data_Mat = readMat(paste0(Folder, '/AllData_2.mat'));

# plot the highest correlation
myPalette <- c("#333333", "#4C4C4C", "#666666", "#7F7F7F", "#999999", "#B2B2B2", "#CCCCCC");
# Age prediction weights (random CV) vs. atlas variability
# Weight vs. PLSca Weight
data_Corr = data.frame(Weight_Data = as.numeric(t(Data_Mat$PLSca.Weight.All.NoMedialWall)));
data_Corr$PLSR_Overall_Weight = as.numeric(Data_Mat$PLSR.Overall.Weight.NoMedialWall);
cor.test(data_Corr$Weight_Data, data_Corr$PLSR_Overall_Weight, method = "pearson");

hexinfo <- hexbin(data_Corr$Weight_Data, data_Corr$PLSR_Overall_Weight, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
         geom_hex(data = subset(data_hex, count >= 10), aes(x, y, fill = count), stat = "identity") +
         scale_fill_gradientn(colours = myPalette, breaks = c(150, 300)) +
         geom_smooth(data = data_Corr, aes(x = Weight_Data, y = PLSR_Overall_Weight), method = lm, color = "#FFFFFF", linetype = "dashed") +
         theme_classic() + labs(x = "PLS correlation Weight", y = "PLS regression Weight") +
         theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
         theme(legend.text = element_text(size = 30), legend.title = element_text(size = 30)) +
         theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
         scale_x_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04)) +
         scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04));
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_PLSca/Weight_PLSR_PLSca_Corr.tiff', width = 17, height = 15, dpi = 600, units = "cm");

# Significance
# Weights (PLSca) vs. Weights (PLSR) 
tmp_data = cor.test(as.numeric(Data_Mat$PLSca.Weight.All.NoMedialWall),
                    as.numeric(Data_Mat$PLSR.Overall.Weight.NoMedialWall), method = "pearson");
Actual_Corr_Weight_PLSca_PLSR = tmp_data$estimate;
Perm_Corr_Weight_PLSca_PLSR = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  # Remove medial wall and low SNR regions in the permuted data
  Non100_Index = which(Data_Mat$PLSca.Weight.Perm.All.NoMedialWall[i,] != 100);
  tmp_data = cor.test(as.numeric(Data_Mat$PLSca.Weight.Perm.All.NoMedialWall[i, Non100_Index]),
                      as.numeric(Data_Mat$PLSR.Overall.Weight.NoMedialWall[Non100_Index]), method = "pearson");
  Perm_Corr_Weight_PLSca_PLSR[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Weight_PLSca_PLSR >= Actual_Corr_Weight_PLSca_PLSR)) / 1000;
print(paste0('P value (PLSca Weights vs. PLSR Weights): ', as.character(P_Value)));

# Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Weight_PLSca_PLSR));
#PermutationData$Line_x = as.numeric(matrix(Actual_Corr_Weight_PLSca_PLSR, 1, 1000));
#PermutationData$Line_y = as.numeric(seq(0,91,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    #geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=80, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.3, 0.3), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'));
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_PLSca/SpinTest_Weights_PLSca_PLSR_Corr.tiff', width = 17, height = 15, dpi = 600, units = "cm");



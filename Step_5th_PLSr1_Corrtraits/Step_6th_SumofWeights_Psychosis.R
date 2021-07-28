
library(R.matlab)
library(ggplot2)

ResultsFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results';
WeightFolder = paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_Psychosis_RandomCV');
Weight_Psychosis_Mat = readMat(paste0(WeightFolder, '/w_Brain_Psychosis_Matrix.mat'));
Weight_Psychosis_Matrix = Weight_Psychosis_Mat$w.Brain.Psychosis.Matrix;

# plot contributing weight for overall psychopathology prediction
data <- data.frame(x = matrix(0, 17, 1));
data$x <- matrix(0, 17, 1);
data$y <- matrix(0, 17, 1);
Neg_Weight <- matrix(0, 1, 17);
SumWeights <- matrix(0, 1, 17);
for (i in c(1:17)){
    Weight_tmp = Weight_Psychosis_Matrix[i,];
    data$x[i] = i;
    data$y[i] = sum(Weight_tmp[which(Weight_tmp != 0)]);
    SumWeights[i] = data$y[i];
}
WeightSort <- sort(data$y, decreasing = TRUE, index.return = TRUE);
Rank <- WeightSort$ix;
data$x <- data$x[Rank];
data$y <- data$y[Rank];
data$x_New <- as.matrix(c(1:17));
data$x_ <- as.character(data$x_New);
ColorScheme <- c("#7499C2", "#AF33AD", "#7499C2", "#E76178", "#E76178", "#AF33AD", 
	    "#7499C2", "#4E31A8", "#F5BA2E", "#AF33AD", "#7499C2", "#E443FF",
	    "#E76178", "#00A131", "#F5BA2E", "#F5BA2E", "#E443FF");
Fig <- ggplot(data, aes(x=x_New, y=y, fill = x_)) +
            geom_bar(stat = "identity", colour = "#000000", width = 0.8) +
       scale_fill_manual(limits = data$x_, values = ColorScheme) +
       scale_alpha_manual(limits = c('Above', 'Below'), values = c(0.3, 1)) +
       labs(x = "Networks", y = expression("Sum of Weights")) + theme_classic() +
       theme(axis.text.y = element_text(size= 33, color = "black"),
             axis.title=element_text(size = 33)) +
       theme(legend.position = "none") +
       theme(axis.text.x = element_text(angle = 45, hjust = 1, size= 27, color = ColorScheme)) +
       scale_y_continuous(limits = c(-5, 5), breaks = c(-4, -2, 0, 2, 4)) + 
       scale_x_discrete(limits = factor(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                 13, 14, 15, 16, 17)),
              labels = c("2", "5", "16", "6", "8", "15", "11", "12", "14", "7", 
	         "1", "10", "3", "13", "9", "17", "4"));
Fig
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure4_ContributionPattern/PredictionWeight_Sum_Bar_Psychosis.tiff', width = 19, height = 15, dpi = 600, units = "cm");
writeMat(paste0(WeightFolder, '/SumWeights_Psychosis.mat'), SumWeights = SumWeights);


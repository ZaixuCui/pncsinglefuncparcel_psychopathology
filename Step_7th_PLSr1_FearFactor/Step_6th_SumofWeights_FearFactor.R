
library(R.matlab)
library(ggplot2)

ResultsFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results';
WeightFolder = paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_FearFactor_RandomCV');
Weight_FearFactor_Mat = readMat(paste0(WeightFolder, '/w_Brain_FearFactor_Matrix.mat'));
Weight_FearFactor_Matrix = Weight_FearFactor_Mat$w.Brain.FearFactor.Matrix;

# plot contributing weight for overall psychopathology prediction
data <- data.frame(x = matrix(0, 17, 1));
data$x <- matrix(0, 17, 1);
data$y <- matrix(0, 17, 1);
Neg_Weight <- matrix(0, 1, 17);
SumWeights <- matrix(0, 1, 17);
for (i in c(1:17)){
    Weight_tmp = Weight_FearFactor_Matrix[i,];
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
ColorScheme <- c("#7499C2", "#AF33AD", "#00A131", "#E76178", "#7499C2", 
            "#E76178", "#4E31A8", "#E76178", "#7499C2", "#AF33AD", "#E443FF",
	    "#F5BA2E", "#AF33AD", "#7499C2", "#E443FF", "#F5BA2E", "#F5BA2E");
Fig <- ggplot(data, aes(x=x_New, y=y, fill = x_)) +
            geom_bar(stat = "identity", colour = "#000000", width = 0.8) +
       scale_fill_manual(limits = data$x_, values = ColorScheme) +
       scale_alpha_manual(limits = c('Above', 'Below'), values = c(0.3, 1)) +
       labs(x = "Networks", y = expression("Sum of Weights")) + theme_classic() +
       theme(axis.text.x = element_text(size= 27, color = ColorScheme),
            axis.text.y = element_text(size= 33, color = "black"),
            axis.title=element_text(size = 33)) +
       theme(legend.position = "none") +
       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
       scale_y_continuous(limits = c(-8, 8), breaks = c(-8, -4, 0, 4, 8)) +
       scale_x_discrete(limits = factor(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                 13, 14, 15, 16, 17)),
              labels = c("2", "5", "13", "3", "11", "8", "12", "6", "16", "15",
		 "4", "14", "7", "1", "10", "9", "17"));
Fig
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_FearFactor/PredictionWeight_Sum_Bar_FearFactor.tiff', width = 19, height = 15, dpi = 600, units = "cm");
writeMat(paste0(WeightFolder, '/SumWeights_FearFactor.mat'), SumWeights = SumWeights);


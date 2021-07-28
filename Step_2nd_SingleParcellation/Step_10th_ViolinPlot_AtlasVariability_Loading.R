
library(R.matlab)
library(ggplot2);

ResultsFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results';
AtlasFolder = paste0(ResultsFolder, '/SingleParcellation/SingleAtlas_Analysis');
Variability_Visualize_Folder = paste0(AtlasFolder, '/Variability_Visualize');
Variability_Mat = readMat(paste0(Variability_Visualize_Folder, '/VariabilityLoading_Median_17SystemMean.mat'));

AtlasLabel_Mat = readMat(paste0(AtlasFolder, '/Group_AtlasLabel.mat'));

AllData = data.frame(Variability = matrix(0, 17734, 1));
AllData$Label = matrix(0, 17734, 1);
for (i in c(1:17734))
{
  AllData$Variability[i] = Variability_Mat$VariabilityLoading.Median.17SystemMean.NoMedialWall[i];
  AllData$Label[i] = AtlasLabel_Mat$sbj.AtlasLabel.NoMedialWall[i];
}
AllData$Variability = as.numeric(AllData$Variability);
AllData$Label = as.factor(AllData$Label);

# Order the network by the median value
MedianValue = matrix(0, 1, 17);
for (i in c(1:17)) {
  ind = which(AllData$Label == i);
  MedianValue[i] = median(AllData$Variability[ind]);
}

ColorScheme = c("#7499C2", "#7499C2", "#E76178", "#E443FF", "#AF33AD",
		"#E76178", "#AF33AD", "#E76178", "#F5BA2E", "#E443FF",
		"#7499C2", "#4E31A8", "#00A131", "#F5BA2E", "#AF33AD",
		"#7499C2", "#F5BA2E");
ColorScheme_XText = c("#AF33AD", "#7499C2", "#AF33AD", "#7499C2", "#7499C2",
		"#4E31A8", "#AF33AD", "#7499C2", "#F5BA2E", "#E76178", "#E443FF", 
		"#E76178", "#E443FF", "#E76178", "#00A131", "#F5BA2E", "#F5BA2E");
Order = c(7, 16, 15, 2, 1, 12, 5, 11, 14, 6, 4, 8, 10, 3, 13, 17, 9);
ColorScheme_XText_New = ColorScheme_XText;
for (i in c(1:17)) {
  ind = which(Order == i);
  ColorScheme_XText_New[ind] = ColorScheme_XText[i];
}
ggplot(AllData, aes(x = Label, y = Variability, fill = Label, color = Label)) +
      geom_violin(trim = FALSE, width=1.3) +
      scale_color_manual(values = ColorScheme) +
      scale_fill_manual(values = ColorScheme) +
      labs(x = "Networks", y = "Across-subject Variability") + theme_classic() +
      theme(axis.text.x = element_text(size = 22, color = ColorScheme_XText_New),
            axis.text.y = element_text(size = 22, color = "black"),
            axis.title = element_text(size = 22)) +
      theme(axis.text.x = element_text(angle = 22, hjust = 1)) +
      theme(legend.position = "none") +
      scale_x_discrete(
            limits = c(7, 16, 15, 2, 1, 12, 5, 11, 14, 6, 4, 8, 10, 3, 13, 17, 9),
            labels = c("5", "17", "13", "16", "7", "8", "1", "4", "3", "12", "2", 
		       "11", "6", "15", "10", "9", "14")) + 
      geom_boxplot(width=0.1, fill = "white");
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/FigureS2_AtlasVariability/Variability_Loading_Mean_Violin.tiff', width = 20, height = 15, dpi = 600, units = "cm");


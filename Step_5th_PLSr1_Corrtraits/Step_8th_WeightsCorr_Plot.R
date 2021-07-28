
library(R.matlab)
library(reshape2)
library(ggplot2)

# WeightPattern
ResultsFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results';
WeightPattern_Fear = readMat(paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_Fear_RandomCV/w_Brain_Fear_Abs_sum.mat'));
WeightPattern_Psychosis = readMat(paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_Psychosis_RandomCV/w_Brain_Psychosis_Abs_sum.mat'));
WeightPattern_Externalizing = readMat(paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_Externalizing_RandomCV/w_Brain_Externalizing_Abs_sum.mat'));
WeightPattern_Mood = readMat(paste0(ResultsFolder, '/PLSr1/AtlasLoading/WeightVisualize_Mood_RandomCV/w_Brain_Mood_Abs_sum.mat'));

data = matrix(0, 17754, 4);
data[,1] = WeightPattern_Fear$w.Brain.Fear.Abs.sum;
data[,2] = WeightPattern_Psychosis$w.Brain.Psychosis.Abs.sum;
data[,3] = WeightPattern_Externalizing$w.Brain.Externalizing.Abs.sum;
data[,4] = WeightPattern_Mood$w.Brain.Mood.Abs.sum;
colnames(data) = c("Fear", "Psychosis", "Externalizing", "Anxious-misery");
cormat = round(cor(data), 2);

cormat_lower = cormat;
cormat_lower[lower.tri(cormat_lower)] = NA;
melted_cormat = melt(cormat_lower, na.rm=TRUE);

ggheatmap <- ggplot(data = melted_cormat, aes(x=Var2, y=Var1, fill=value)) +
  geom_tile(color = "white") + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, 
		       limit = c(-1, 1), space = "Lab", name="Pearson\nCorrelation") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle=45, vjust=1, size=16, hjust=1, colour='black'), 
	axis.text.y = element_text(size=16, colour='black'),
	legend.text = element_text(size=12, colour='black')) + 
  coord_fixed()
print(ggheatmap)

Fig <- ggheatmap + 
  geom_text(data = melted_cormat, aes(Var2, Var1, label=value), color="black", size=6) + 
  theme(
	axis.title.x = element_blank(),
	axis.title.y = element_blank(),
	panel.grid.major = element_blank(),
	panel.border = element_blank(),
	panel.background = element_blank(),
	axis.ticks = element_blank(),
	legend.justification = c(1, 0),
	legend.position = c(0.55, 0.78),
	legend.direction = "horizontal") + 
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1, title.position = "top", title.hjust=0.5))
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/FigureS6_ContributionPatternCorrelation/WeightPattern_Corr.png', width = 15, height = 15, dpi = 600, units = "cm");


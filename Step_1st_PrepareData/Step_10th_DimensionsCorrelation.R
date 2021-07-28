
library(R.matlab)
library(reshape2)
library(ggplot2)

# Factor scores of four dimensions
DataFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/data';
PsychopathologyData = read.csv(paste0(DataFolder, "/n790_Psychopathology_20200326.csv"));
data = matrix(0, 790, 4);
data[,1] = PsychopathologyData$fear_corrtraitsv2;
data[,2] = PsychopathologyData$psychosis_corrtraitsv2;
data[,3] = PsychopathologyData$externalizing_corrtraitsv2;
data[,4] = PsychopathologyData$mood_corrtraitsv2;
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
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/FigureS4_DimensionsCorrelation/DimensionsCorrelation.png', width = 15, height = 15, dpi = 600, units = "cm");



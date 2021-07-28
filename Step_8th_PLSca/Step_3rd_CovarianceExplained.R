
library(R.matlab)
library(ggplot2)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSca/AtlasLoading/RandomCV_101Repeats_RegressCovariates_All_2Fold';

# All items
WeightMat = readMat(paste0(Folder, '/2Fold_RandomCV_Corr_PLSca_Comp1.mat'));
CovarianceExplained = WeightMat$CovarianceExplained.Median;
CovarianceExplained = CovarianceExplained / sum(CovarianceExplained);
data1 = data.frame(ComponentNumber = as.numeric(c(1:112)));
data1$CovExplained_All = as.numeric(CovarianceExplained);
#data1$group = as.factor(matrix(1, 1, 112));
#data2 = data.frame(ComponentNumber = as.numeric(matrix(1, 1, 112)));
#data2$CovExplained_Highest = as.numeric(matrix(CovarianceExplained[1], 1, 112));
#data2$group = as.factor(matrix(2, 1, 112));

Fig <- ggplot(data1, aes(x=ComponentNumber, y=CovExplained_All)) +
    geom_point(color='black') + 
    theme_classic() + 
    labs(x = "Component", y = "Covariance Explained") + 
    theme(legend.position = "none") +
    theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30)) +
    scale_x_continuous(breaks = c(1, 20, 40, 60, 80, 100))
Fig
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/FigureS8_PLSca_ScreePlot/CovarianceExplained.tiff', width = 17, height = 15, dpi = 600, units = "cm");


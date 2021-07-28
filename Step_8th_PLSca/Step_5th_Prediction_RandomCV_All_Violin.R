
library(R.matlab)
library(ggplot2)
library(PupillometryR)
library(visreg)

PredictionFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSca/AtlasLoading';
Prediction_Res_PLSca = readMat(paste0(PredictionFolder, '/RandomCV_101Repeats_RegressCovariates_All_2Fold/2Fold_RandomCV_Corr_PLSca_Comp1.mat'));
Corr_PLSca_Actual_Median = median(Prediction_Res_PLSca$Corr.Actual);

# Permutation data
data_Perm = data.frame(Corr_Permutation = t(Prediction_Res_PLSca$Corr.Permutation));
data_Perm$group = as.factor(matrix(1, 1, 1000))
data_Actual = data.frame(Corr_Actual = as.numeric(matrix(Corr_PLSca_Actual_Median, 1, 1000)));
data_Actual$group = as.factor(matrix(2, 1, 1000))

# Plot Correlation 
g <- ggplot(data=data_Perm, aes(y=Corr_Permutation, x=.5, fill=group)) +
  geom_flat_violin(position=position_nudge(x=.2, y=0), alpha=.8, width=.7) +
  geom_point(aes(y=Corr_Permutation, color=group, fill=group), position=position_jitter(width=.15), size=.5, alpha=0.8) +
  scale_color_manual(values = c("#7F7F7F", "#FF0000")) +
  scale_fill_manual(values = c("#7F7F7F", "#FF0000")) +
  geom_boxplot(color="black", width=.15, alpha = 0) +
  geom_point(data=data_Actual, aes(y=Corr_Actual, color=group, fill=group), size = 5) + 
  labs(x = "", y = expression(paste("Correlation (", italic("r"), ")"))) +
  theme_classic() +
  theme(axis.text.y = element_text(size = 33, color = 'black'),
        axis.title=element_text(size = 33)) +
  theme(legend.position = "none") +
  scale_y_continuous(breaks = c(-0.1, 0, 0.1)) + 
  scale_x_continuous(breaks = c(-0.1, 0, 0.1)) +
  #coord_flip() +
  expand_limits(x = 4)
g
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure7_PLSca/Corr_RandomCV_Violin_PLSca_Comp1.png', width = 17, height = 15, dpi = 600, units = "cm");



library(R.matlab)
library(ggplot2)
library(PupillometryR)
library(visreg)

PredictionFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading';
# Fear factor
Prediction_Res_FearFactor = readMat(paste0(PredictionFolder, '/PhobiasFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_FearFactor.mat'));
Corr_FearFactor_Actual_Median = median(Prediction_Res_FearFactor$Corr.FearFactor.Actual);
MAE_FearFactor_Actual_Median = median(Prediction_Res_FearFactor$MAE.FearFactor.Actual);

data_Corr_Perm = data.frame(Corr_Permutation = t(Prediction_Res_FearFactor$Corr.FearFactor.Perm));
data_Corr_Perm$group = as.factor(matrix(1, 1, 1000))
data_Corr_Actual = data.frame(Corr_Actual = as.numeric(matrix(Corr_FearFactor_Actual_Median, 1, 1000)));
data_Corr_Actual$group = as.factor(matrix(2, 1, 1000));

data_MAE_Perm = data.frame(MAE_Permutation = t(Prediction_Res_FearFactor$MAE.FearFactor.Perm));
data_MAE_Perm$group = as.factor(matrix(1, 1, 1000))
data_MAE_Actual = data.frame(MAE_Actual = as.numeric(matrix(MAE_FearFactor_Actual_Median, 1, 1000)));
data_MAE_Actual$group = as.factor(matrix(2, 1, 1000));

# Plot Correlation 
g <- ggplot(data=data_Corr_Perm, aes(y=Corr_Permutation, x=.5, fill=group)) +
  geom_flat_violin(position=position_nudge(x=.2, y=0), alpha=.8, width=.7) +
  geom_point(aes(y=Corr_Permutation, color=group, fill=group), position=position_jitter(width=.15), size=.5, alpha=0.8) +
  scale_color_manual(values = c("#7F7F7F", "#FF0000")) +
  scale_fill_manual(values = c("#7F7F7F", "#FF0000")) +
  geom_boxplot(color="black", width=.15, alpha = 0) +
  geom_point(data=data_Corr_Actual, aes(y=Corr_Actual, color=group, fill=group), size = 5) +
  labs(x = "", y = expression(paste("Correlation (", italic("r"), ")"))) +
  theme_classic() +
  theme(axis.text.y = element_text(size = 30, color = 'black'),
	axis.text.x = element_text(size = 30, color = 'black'),
        axis.title=element_text(size = 30)) +
  theme(legend.position = "none") +
  scale_y_continuous(breaks = c(-0.1, 0, 0.1)) + 
  scale_x_continuous(breaks = c(-0.1, 0, 0.1)) +
#  coord_flip() +
  expand_limits(x = 4)
g
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_FearFactor/Corr_RandomCV_Violin_FearFactor.png', width = 17, height = 15, dpi = 600, units = "cm");

# Psychosis factor
Prediction_Res_PsychosisFactor = readMat(paste0(PredictionFolder, '/PsychosisFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_PsychosisFactor.mat'));
Corr_PsychosisFactor_Actual_Median = median(Prediction_Res_PsychosisFactor$Corr.PsychosisFactor.Actual);
MAE_PsychosisFactor_Actual_Median = median(Prediction_Res_PsychosisFactor$MAE.PsychosisFactor.Actual);

data_Corr_Perm = data.frame(Corr_Permutation = t(Prediction_Res_PsychosisFactor$Corr.PsychosisFactor.Perm));
data_Corr_Perm$group = as.factor(matrix(1, 1, 1000))
data_Corr_Actual = data.frame(Corr_Actual = as.numeric(matrix(Corr_PsychosisFactor_Actual_Median, 1, 1000)));
data_Corr_Actual$group = as.factor(matrix(2, 1, 1000));

data_MAE_Perm = data.frame(MAE_Permutation = t(Prediction_Res_PsychosisFactor$MAE.PsychosisFactor.Perm));
data_MAE_Perm$group = as.factor(matrix(1, 1, 1000))
data_MAE_Actual = data.frame(MAE_Actual = as.numeric(matrix(MAE_PsychosisFactor_Actual_Median, 1, 1000)));
data_MAE_Actual$group = as.factor(matrix(2, 1, 1000));

# Plot Correlation
g <- ggplot(data=data_Corr_Perm, aes(y=Corr_Permutation, x=.5, fill=group)) +
  geom_flat_violin(position=position_nudge(x=.2, y=0), alpha=.8, width=.7) +
  geom_point(aes(y=Corr_Permutation, color=group, fill=group), position=position_jitter(width=.15), size=.5, alpha=0.8) +
  scale_color_manual(values = c("#7F7F7F", "#FF0000")) +
  scale_fill_manual(values = c("#7F7F7F", "#FF0000")) +
  geom_boxplot(color="black", width=.15, alpha = 0) +
  geom_point(data=data_Corr_Actual, aes(y=Corr_Actual, color=group, fill=group), size = 5) +
  labs(x = "", y = expression(paste("Correlation (", italic("r"), ")"))) +
  theme_classic() +
  theme(axis.text.y = element_text(size = 30, color = 'black'),
        axis.text.x = element_text(size = 30, color = 'black'),
        axis.title=element_text(size = 30)) +
  theme(legend.position = "none") +
  scale_y_continuous(breaks = c(-0.1, 0, 0.1)) +
  scale_x_continuous(breaks = c(-0.1, 0, 0.1)) +
#  coord_flip() +
  expand_limits(x = 4)
g
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_OtherFactors/Corr_RandomCV_Violin_PsychosisFactor.png', width = 17, height = 15, dpi = 600, units = "cm");



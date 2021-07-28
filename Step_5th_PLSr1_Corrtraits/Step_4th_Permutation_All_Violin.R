
library(R.matlab)
library(ggplot2)
library(PupillometryR)
library(visreg)

PredictionFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/results_20210218/PLSr1/AtlasLoading';
Prediction_Res_Externalizing = readMat(paste0(PredictionFolder, '/ExternalizingCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Externalizing.mat'));
Prediction_Res_Fear = readMat(paste0(PredictionFolder, '/FearCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Fear.mat'));
Prediction_Res_Mood = readMat(paste0(PredictionFolder, '/MoodCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Mood.mat'));
Prediction_Res_Psychosis = readMat(paste0(PredictionFolder, '/PsychosisCorrtraits_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_Psychosis.mat'));

Corr_Externalizing_Actual_Median = median(Prediction_Res_Externalizing$Corr.Externalizing.Actual);
Corr_Fear_Actual_Median = median(Prediction_Res_Fear$Corr.Fear.Actual);
Corr_Mood_Actual_Median = median(Prediction_Res_Mood$Corr.Mood.Actual);
Corr_Psychosis_Actual_Median = median(Prediction_Res_Psychosis$Corr.Psychosis.Actual);

data = data.frame(Corr_Actual = c(as.numeric(matrix(Corr_Fear_Actual_Median, 1, 1000)),
                          as.numeric(matrix(Corr_Psychosis_Actual_Median, 1, 1000)),
                          as.numeric(matrix(Corr_Externalizing_Actual_Median, 1, 1000)),
                          as.numeric(matrix(Corr_Mood_Actual_Median, 1, 1000))));

# Permutation data
data$Corr_Permutation = c(t(Prediction_Res_Fear$Corr.Fear.Perm),
			  t(Prediction_Res_Psychosis$Corr.Psychosis.Perm),
			  t(Prediction_Res_Externalizing$Corr.Externalizing.Perm),
			  t(Prediction_Res_Mood$Corr.Mood.Perm));
data$group = as.factor(c(matrix(0.5, 1, 1000), matrix(1.5, 1, 1000), 
	                 matrix(2.5, 1, 1000), matrix(3.5, 1, 1000)));

# Plot Correlation 
g <- ggplot(data=data, aes(y=Corr_Permutation, x=group, fill=group)) +
  geom_flat_violin(position=position_nudge(x=.2, y=0), alpha=.8, width=.7) +
  geom_jitter(aes(y=Corr_Permutation, color=group, fill=group), width=.15, size=.5, alpha=0.8) +
  geom_boxplot(color="black", width=.15, alpha = 0) +
  geom_point(aes(y=Corr_Actual, size=3, color=group, fill=group), size=5) +
  scale_color_manual(values = c("#FAC016", "#85338A", "#AB2924", "#005D9B")) +
  scale_fill_manual(values = c("#FAC016", "#85338A", "#AB2924", "#005D9B")) +
  labs(x = "", y = expression(paste("Correlation (", italic("r"), ")"))) +
  theme_classic() +
  theme(axis.text.y = element_text(size = 27, color = 'black'),
	axis.text.x = element_text(size = 27, color = 'black'),
        axis.title=element_text(size = 27)) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 20, hjust = 1)) + 
  scale_y_continuous(breaks = c(-0.1, 0, 0.1)) + 
  scale_x_discrete(labels = c("Fear", "Psychosis", "Externalizing", "Anxious-misery")) 
g
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure3_PredictionAccuracy/Corr_RandomCV_Violin.png', width = 30, height = 15, dpi = 600, units = "cm");


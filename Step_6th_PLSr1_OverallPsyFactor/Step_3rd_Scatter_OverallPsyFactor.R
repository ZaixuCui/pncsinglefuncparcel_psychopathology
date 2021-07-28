
library(R.matlab)
library(ggplot2)
library(visreg)

PredictionFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSr1/AtlasLoading';
Prediction_Res = readMat(paste0(PredictionFolder, '/OverallPsyFactor_All_RegressCovariates_RandomCV/2Fold_RandomCV_Corr_MAE_Actual_OverallPsyFactor.mat'));
Corr_Actual = Prediction_Res$Corr.OverallPsyFactor.Actual;

# Find median value
MedianIndex = which(Corr_Actual == median(Corr_Actual));
MedianFolder = paste0(PredictionFolder, '/OverallPsyFactor_All_RegressCovariates_RandomCV/Time_', 
		    as.character(MedianIndex-1));
Fold0 <- readMat(paste0(MedianFolder, '/Fold_0_Score.mat'));
TestScore_Fold0 <- t(Fold0$Test.Score);
PredictScore_Fold0 <- as.numeric(t(Fold0$Predict.Score));
Index_Fold0 <- Fold0$Index + 1;
Fold1 <- readMat(paste0(MedianFolder, '/Fold_1_Score.mat'));
TestScore_Fold1 <- t(Fold1$Test.Score);
PredictScore_Fold1 <- as.numeric(t(Fold1$Predict.Score));
Index_Fold1 <- Fold1$Index + 1;

Predict_Max <- max(c(PredictScore_Fold0, PredictScore_Fold1));
Predict_Min <- min(c(PredictScore_Fold0, PredictScore_Fold1));
Test_Max <- max(c(TestScore_Fold0, TestScore_Fold1));
Test_Min <- min(c(TestScore_Fold0, TestScore_Fold1));

Color_Fold0 = '#7F7F7F';
Color_Fold1 = '#000000';

# Fold 1
predicts_Fold1 = data.frame(TestScore_Fold1 = as.numeric(TestScore_Fold1));
predicts_Fold1$PredictScore_Fold1 = as.numeric(PredictScore_Fold1);
lm_Fold1 <- lm(PredictScore_Fold1 ~ TestScore_Fold1, data = predicts_Fold1);
plotdata <- visreg(lm_Fold1, "TestScore_Fold1", type = "conditional", scale = "linear", plot = FALSE);
smooths_Fold1 <- data.frame(Variable = plotdata$meta$x,
                      x = plotdata$fit[[plotdata$meta$x]],
                      smooth = plotdata$fit$visregFit,
                      lower = plotdata$fit$visregLwr,
                      upper = plotdata$fit$visregUpr);
predicts_Fold1 <- data.frame(Variable = "dim1",
                      x = plotdata$res$TestScore_Fold1,
                      y = plotdata$res$visregRes)
Fig <- ggplot() +
       geom_point(data = predicts_Fold1, aes(x, y), colour = Color_Fold1, size = 2) +
       geom_line(data = smooths_Fold1, aes(x = x, y = smooth), colour = Color_Fold1, size = 1.5) +
       geom_ribbon(data = smooths_Fold1, aes(x = x, ymin = lower, ymax = upper), fill = Color_Fold1, alpha = 0.2)

# Fold 0
predicts_Fold0 = data.frame(TestScore_Fold0 = as.numeric(TestScore_Fold0));
predicts_Fold0$PredictScore_Fold0 = as.numeric(PredictScore_Fold0);
Energy_lm <- lm(PredictScore_Fold0 ~ TestScore_Fold0, data = predicts_Fold0);
plotdata <- visreg(Energy_lm, "TestScore_Fold0", type = "conditional", scale = "linear", plot = FALSE);
smooths <- data.frame(Variable = plotdata$meta$x,
                      x = plotdata$fit[[plotdata$meta$x]],
                      smooth = plotdata$fit$visregFit,
                      lower = plotdata$fit$visregLwr,
                      upper = plotdata$fit$visregUpr);
predicts <- data.frame(Variable = "dim1",
                      x = plotdata$res$TestScore_Fold0,
                      y = plotdata$res$visregRes)
Fig <- Fig +
       geom_point(data = predicts, aes(x, y), colour = Color_Fold0, size = 2, shape = 17) +
       geom_line(data = smooths, aes(x = x, y = smooth), colour = Color_Fold0, size = 1.5) +
       geom_ribbon(data = smooths, aes(x = x, ymin = lower, ymax = upper), fill = Color_Fold0, alpha = 0.2) +
       theme_classic() + labs(x = "Actual Score", y = "Predicted Score") +
       theme(axis.text=element_text(size=31, color='black'), axis.title=element_text(size=31)) +
       scale_y_continuous(limits = c(-2, 2), breaks = c(-2, 0, 2)) +
       scale_x_continuous(limits = c(-2.1, 3.0), breaks = c(-2, 0, 2))
Fig

ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure6_OverallPsychopathology/OverallPsyFactorPrediction_CorrACC.tiff', width = 16, height = 15, dpi = 600, units = "cm");


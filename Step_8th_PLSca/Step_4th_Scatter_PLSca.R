
library(R.matlab)
library(ggplot2)
library(visreg)

PredictionFolder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/Replication/results/PLSca/AtlasLoading';
Prediction_Res = readMat(paste0(PredictionFolder, '/RandomCV_101Repeats_RegressCovariates_All_2Fold/2Fold_RandomCV_Corr_PLSca_Comp1.mat'));
Corr_Actual = Prediction_Res$Corr.Actual;

# Find median value
MedianIndex = which(Corr_Actual == median(Corr_Actual));
MedianFolder = paste0(PredictionFolder, '/RandomCV_101Repeats_RegressCovariates_All_2Fold/Time_', 
		    as.character(MedianIndex-1));
Fold0 <- readMat(paste0(MedianFolder, '/Fold_0_Score.mat'));
BrainScore_Fold0 <- t(Fold0$Brain.test.ca[,1]);
BehaviorScore_Fold0 <- as.numeric(t(Fold0$Behavior.test.ca[,1]));
Index_Fold0 <- Fold0$Index + 1;
Fold1 <- readMat(paste0(MedianFolder, '/Fold_1_Score.mat'));
BrainScore_Fold1 <- t(Fold1$Brain.test.ca[,1]);
BehaviorScore_Fold1 <- as.numeric(t(Fold1$Behavior.test.ca[,1]));
Index_Fold1 <- Fold1$Index + 1;

BrainScore_Max <- max(c(BrainScore_Fold0, BrainScore_Fold1));
BrainScore_Min <- min(c(BrainScore_Fold0, BrainScore_Fold1));
BehaviorScore_Max <- max(c(BehaviorScore_Fold0, BehaviorScore_Fold1));
BehaviorScore_Min <- min(c(BehaviorScore_Fold0, BehaviorScore_Fold1));

Color_Fold0 = '#7F7F7F';
Color_Fold1 = '#000000';

# Fold 1
PLSca_Fold1 = data.frame(BrainScore_Fold1 = as.numeric(BrainScore_Fold1));
PLSca_Fold1$BehaviorScore_Fold1 = as.numeric(BehaviorScore_Fold1);
lm_Fold1 <- lm(BehaviorScore_Fold1 ~ BrainScore_Fold1, data = PLSca_Fold1);
plotdata <- visreg(lm_Fold1, "BrainScore_Fold1", type = "conditional", scale = "linear", plot = FALSE);
smooths_Fold1 <- data.frame(Variable = plotdata$meta$x,
                      x = plotdata$fit[[plotdata$meta$x]],
                      smooth = plotdata$fit$visregFit,
                      lower = plotdata$fit$visregLwr,
                      upper = plotdata$fit$visregUpr);
Plot_Fold1 <- data.frame(Variable = "dim1",
                      x = plotdata$res$BrainScore_Fold1,
                      y = plotdata$res$visregRes)
Fig <- ggplot() +
       geom_point(data = Plot_Fold1, aes(x, y), colour = Color_Fold1, size = 2) +
       geom_line(data = smooths_Fold1, aes(x = x, y = smooth), colour = Color_Fold1, size = 1.5) +
       geom_ribbon(data = smooths_Fold1, aes(x = x, ymin = lower, ymax = upper), fill = Color_Fold1, alpha = 0.2)

# Fold 0
PLSca_Fold0 = data.frame(BrainScore_Fold0 = as.numeric(BrainScore_Fold0));
PLSca_Fold0$BehaviorScore_Fold0 = as.numeric(BehaviorScore_Fold0);
lm_Fold0 <- lm(BehaviorScore_Fold0 ~ BrainScore_Fold0, data = PLSca_Fold0);
plotdata <- visreg(lm_Fold0, "BrainScore_Fold0", type = "conditional", scale = "linear", plot = FALSE);
smooths <- data.frame(Variable = plotdata$meta$x,
                      x = plotdata$fit[[plotdata$meta$x]],
                      smooth = plotdata$fit$visregFit,
                      lower = plotdata$fit$visregLwr,
                      upper = plotdata$fit$visregUpr);
Plot_Fold0 <- data.frame(Variable = "dim1",
                      x = plotdata$res$BrainScore_Fold0,
                      y = plotdata$res$visregRes)
Fig <- Fig +
       geom_point(data = Plot_Fold0, aes(x, y), colour = Color_Fold0, size = 2, shape = 17) +
       geom_line(data = smooths, aes(x = x, y = smooth), colour = Color_Fold0, size = 1.5) +
       geom_ribbon(data = smooths, aes(x = x, ymin = lower, ymax = upper), fill = Color_Fold0, alpha = 0.2) +
       theme_classic() + labs(x = "Topography Dimension Score", y = "Clinical Dimension Score") +
       theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30)) +
       scale_y_continuous(limits = c(-6, 24), breaks = c(-5, 0, 5, 10, 15, 20)) +
       scale_x_continuous(limits = c(-42, 48), breaks = c(-40, -20, 0, 20, 40))
Fig

ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure8_PLSca/PLSca_Comp1.tiff', width = 17, height = 15, dpi = 600, units = "cm");


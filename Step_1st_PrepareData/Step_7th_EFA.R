
library(ggplot2)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/data';
data = read.csv(paste0(Folder, '/n1601_goassess_itemwise_corrtraits_scores_20161219.csv'));
#PNC_Diagnoses = read.csv(paste0(Folder, '/PNC_diagnoses_Cui.csv'));
Diagnoses = read.csv(paste0(Folder, '/n1601_goassess_psych_summary_vars_20131014.csv'));
Diagnoses_Psychosis = read.csv(paste0(Folder, '/n1601_diagnosis_dxpmr_20170509.csv'));
SubjectsID_CSV = read.csv(paste0(Folder, '/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv'));
data_Merge = merge(data, Diagnoses, by = c("bblid", "scanid"));
data_Merge = merge(data_Merge, Diagnoses_Psychosis, by = c("bblid", "scanid"));
data_Merge = merge(data_Merge, SubjectsID_CSV, by = c("bblid", "scanid"));

fear_corrtraitsv2 = data_Merge$fear_corrtraitsv2;
psychosis_corrtraitsv2 = data_Merge$psychosis_corrtraitsv2;
externalizing_corrtraitsv2 = data_Merge$externalizing_corrtraitsv2;
mood_corrtraitsv2 = data_Merge$mood_corrtraitsv2;

data_Merge$smry_add = 0
data_Merge$smry_add[which(data_Merge$goassessSmryAdd==4)] = 1;
data_Merge$smry_agr = 0
data_Merge$smry_agr[which(data_Merge$goassessSmryAgr==4)] = 1;
data_Merge$smry_ano = 0
data_Merge$smry_ano[which(data_Merge$goassessSmryAno==4)] = 1;
data_Merge$smry_bul = 0
data_Merge$smry_bul[which(data_Merge$goassessSmryBul==4)] = 1;
data_Merge$smry_con = 0
data_Merge$smry_con[which(data_Merge$goassessSmryCon==4)] = 1;
data_Merge$smry_gad = 0
data_Merge$smry_gad[which(data_Merge$goassessSmryGad==4)] = 1;
data_Merge$smry_man = 0
data_Merge$smry_man[which(data_Merge$goassessSmryMan==4)] = 1;
data_Merge$smry_dep = 0
data_Merge$smry_dep[which(data_Merge$goassessSmryDep==4)] = 1;
data_Merge$smry_ocd = 0
data_Merge$smry_ocd[which(data_Merge$goassessSmryOcd==4)] = 1;
data_Merge$smry_odd = 0
data_Merge$smry_odd[which(data_Merge$goassessSmryOdd==4)] = 1;
data_Merge$smry_pan = 0
data_Merge$smry_pan[which(data_Merge$goassessSmryPan==4)] = 1;
data_Merge$smry_psy = 0
data_Merge$smry_psy[which(data_Merge$goassessDxpmr4=="4PS")] = 1;
data_Merge$smry_ptsd = 0
data_Merge$smry_ptsd[which(data_Merge$goassessSmryPtd==4)] = 1;
data_Merge$smry_sep = 0
data_Merge$smry_sep[which(data_Merge$goassessSmrySep==4)] = 1;
data_Merge$smry_soc = 0
data_Merge$smry_soc[which(data_Merge$goassessSmrySoc==4)] = 1;
data_Merge$smry_sph = 0
data_Merge$smry_sph[which(data_Merge$goassessSmryPhb==4)] = 1;
DiagosesSum = rowSums(data_Merge[,42:57]);
data_Merge$TD = 0;
data_Merge$TD[which(DiagosesSum==0)] = 1;

# number of gad(14), man(10), pan(5) are less than 20, will not display these three groups
add_number = length(which(data_Merge$smry_add==1)); # ADHD, 114
agr_number = length(which(data_Merge$smry_agr==1)); # Agoraphobiaa, 47
ano_number = length(which(data_Merge$smry_ano==1)); # Anorexia, 10
bul_number = length(which(data_Merge$smry_bul==1)); # Bulimia, 3
con_number = length(which(data_Merge$smry_con==1)); # Conduct Disorder, 64
gad_number = length(which(data_Merge$smry_gad==1)); # Generalized Anxiety, 14
man_number = length(which(data_Merge$smry_man==1)); # Mania, 10
dep_number = length(which(data_Merge$smry_dep==1)); # Depressive, 132
ocd_number = length(which(data_Merge$smry_ocd==1)); # OCD, 21
odd_number = length(which(data_Merge$smry_odd==1)); # ODD, 236
pan_number = length(which(data_Merge$smry_pan==1)); # PAN, 5
psy_number = length(which(data_Merge$smry_psy==1)); # Psychosis, 226
ptsd_number = length(which(data_Merge$smry_ptsd==1)); # PTSD, 99
sep_number = length(which(data_Merge$smry_sep==1)); # Separation Anxiety, 34
soc_number = length(which(data_Merge$smry_soc==1)); # Social Phobia, 189
sph_number = length(which(data_Merge$smry_sph==1)); # Specific Phobia, 242
TD_number = length(which(data_Merge$TD == 1)); # TD, 245

MeanLoading_Fear_add = mean(fear_corrtraitsv2[which(data_Merge$smry_add==1)]);
MeanLoading_Fear_agr = mean(fear_corrtraitsv2[which(data_Merge$smry_agr==1)]);
MeanLoading_Fear_con = mean(fear_corrtraitsv2[which(data_Merge$smry_con==1)]);
MeanLoading_Fear_dep = mean(fear_corrtraitsv2[which(data_Merge$smry_dep==1)]);
MeanLoading_Fear_ocd = mean(fear_corrtraitsv2[which(data_Merge$smry_ocd==1)]);
MeanLoading_Fear_odd = mean(fear_corrtraitsv2[which(data_Merge$smry_odd==1)]);
MeanLoading_Fear_psy = mean(fear_corrtraitsv2[which(data_Merge$smry_psy==1)]);
MeanLoading_Fear_ptsd = mean(fear_corrtraitsv2[which(data_Merge$smry_ptsd==1)]);
MeanLoading_Fear_sep = mean(fear_corrtraitsv2[which(data_Merge$smry_sep==1)]);
MeanLoading_Fear_soc = mean(fear_corrtraitsv2[which(data_Merge$smry_soc==1)]);
MeanLoading_Fear_sph = mean(fear_corrtraitsv2[which(data_Merge$smry_sph==1)]);
MeanLoading_Fear_TD = mean(fear_corrtraitsv2[which(data_Merge$TD==1)]);
MeanLoading_Fear = c(MeanLoading_Fear_add, MeanLoading_Fear_agr, MeanLoading_Fear_con, MeanLoading_Fear_dep, MeanLoading_Fear_ocd, MeanLoading_Fear_odd, MeanLoading_Fear_psy, MeanLoading_Fear_ptsd, MeanLoading_Fear_sep, MeanLoading_Fear_soc, MeanLoading_Fear_sph, MeanLoading_Fear_TD);

MeanLoading_Psychosis_add = mean(psychosis_corrtraitsv2[which(data_Merge$smry_add==1)]);
MeanLoading_Psychosis_agr = mean(psychosis_corrtraitsv2[which(data_Merge$smry_agr==1)]);
MeanLoading_Psychosis_con = mean(psychosis_corrtraitsv2[which(data_Merge$smry_con==1)]);
MeanLoading_Psychosis_dep = mean(psychosis_corrtraitsv2[which(data_Merge$smry_dep==1)]);
MeanLoading_Psychosis_ocd = mean(psychosis_corrtraitsv2[which(data_Merge$smry_ocd==1)]);
MeanLoading_Psychosis_odd = mean(psychosis_corrtraitsv2[which(data_Merge$smry_odd==1)]);
MeanLoading_Psychosis_psy = mean(psychosis_corrtraitsv2[which(data_Merge$smry_psy==1)]);
MeanLoading_Psychosis_ptsd = mean(psychosis_corrtraitsv2[which(data_Merge$smry_ptsd==1)]);
MeanLoading_Psychosis_sep = mean(psychosis_corrtraitsv2[which(data_Merge$smry_sep==1)]);
MeanLoading_Psychosis_soc = mean(psychosis_corrtraitsv2[which(data_Merge$smry_soc==1)]);
MeanLoading_Psychosis_sph = mean(psychosis_corrtraitsv2[which(data_Merge$smry_sph==1)]);
MeanLoading_Psychosis_TD = mean(psychosis_corrtraitsv2[which(data_Merge$TD==1)]);
MeanLoading_Psychosis = c(MeanLoading_Psychosis_add, MeanLoading_Psychosis_agr, MeanLoading_Psychosis_con, MeanLoading_Psychosis_dep, MeanLoading_Psychosis_ocd, MeanLoading_Psychosis_odd, MeanLoading_Psychosis_psy, MeanLoading_Psychosis_ptsd, MeanLoading_Psychosis_sep, MeanLoading_Psychosis_soc, MeanLoading_Psychosis_sph, MeanLoading_Psychosis_TD);

MeanLoading_Externalizing_add = mean(externalizing_corrtraitsv2[which(data_Merge$smry_add==1)]);
MeanLoading_Externalizing_agr = mean(externalizing_corrtraitsv2[which(data_Merge$smry_agr==1)]);
MeanLoading_Externalizing_con = mean(externalizing_corrtraitsv2[which(data_Merge$smry_con==1)]);
MeanLoading_Externalizing_dep = mean(externalizing_corrtraitsv2[which(data_Merge$smry_dep==1)]);
MeanLoading_Externalizing_ocd = mean(externalizing_corrtraitsv2[which(data_Merge$smry_ocd==1)]);
MeanLoading_Externalizing_odd = mean(externalizing_corrtraitsv2[which(data_Merge$smry_odd==1)]);
MeanLoading_Externalizing_psy = mean(externalizing_corrtraitsv2[which(data_Merge$smry_psy==1)]);
MeanLoading_Externalizing_ptsd = mean(externalizing_corrtraitsv2[which(data_Merge$smry_ptsd==1)]);
MeanLoading_Externalizing_sep = mean(externalizing_corrtraitsv2[which(data_Merge$smry_sep==1)]);
MeanLoading_Externalizing_soc = mean(externalizing_corrtraitsv2[which(data_Merge$smry_soc==1)]);
MeanLoading_Externalizing_sph = mean(externalizing_corrtraitsv2[which(data_Merge$smry_sph==1)]);
MeanLoading_Externalizing_TD = mean(externalizing_corrtraitsv2[which(data_Merge$TD==1)]);
MeanLoading_Externalizing = c(MeanLoading_Externalizing_add, MeanLoading_Externalizing_agr, MeanLoading_Externalizing_con, MeanLoading_Externalizing_dep, MeanLoading_Externalizing_ocd, MeanLoading_Externalizing_odd, MeanLoading_Externalizing_psy, MeanLoading_Externalizing_ptsd, MeanLoading_Externalizing_sep, MeanLoading_Externalizing_soc, MeanLoading_Externalizing_sph, MeanLoading_Externalizing_TD);

MeanLoading_Mood_add = mean(mood_corrtraitsv2[which(data_Merge$smry_add==1)]);
MeanLoading_Mood_agr = mean(mood_corrtraitsv2[which(data_Merge$smry_agr==1)]);
MeanLoading_Mood_con = mean(mood_corrtraitsv2[which(data_Merge$smry_con==1)]);
MeanLoading_Mood_dep = mean(mood_corrtraitsv2[which(data_Merge$smry_dep==1)]);
MeanLoading_Mood_ocd = mean(mood_corrtraitsv2[which(data_Merge$smry_ocd==1)]);
MeanLoading_Mood_odd = mean(mood_corrtraitsv2[which(data_Merge$smry_odd==1)]);
MeanLoading_Mood_psy = mean(mood_corrtraitsv2[which(data_Merge$smry_psy==1)]);
MeanLoading_Mood_ptsd = mean(mood_corrtraitsv2[which(data_Merge$smry_ptsd==1)]);
MeanLoading_Mood_sep = mean(mood_corrtraitsv2[which(data_Merge$smry_sep==1)]);
MeanLoading_Mood_soc = mean(mood_corrtraitsv2[which(data_Merge$smry_soc==1)]);
MeanLoading_Mood_sph = mean(mood_corrtraitsv2[which(data_Merge$smry_sph==1)]);
MeanLoading_Mood_TD = mean(mood_corrtraitsv2[which(data_Merge$TD==1)]);
MeanLoading_Mood = c(MeanLoading_Mood_add, MeanLoading_Mood_agr, MeanLoading_Mood_con, MeanLoading_Mood_dep, MeanLoading_Mood_ocd, MeanLoading_Mood_odd, MeanLoading_Mood_psy, MeanLoading_Mood_ptsd, MeanLoading_Mood_sep, MeanLoading_Mood_soc, MeanLoading_Mood_sph, MeanLoading_Mood_TD);

# 1: Fear; 2: Psychosis; 3: Externalizing; 4: Mood
df2 <- data.frame(Factor=rep(c("1", "2", "3", "4"), each=12), 
		  Diagnoses=rep(c("ADHD", 
				  "Agoraphobia", "Conduct", 
				  "MDD", 
				  "OCD", 
				  "ODD", "PS", 
				  "PTSD", "Sep Anx", 
				  "Soc Pho", "Spec Pho", 
				  "TD"), 4), 
		  MeanLoading=c(MeanLoading_Fear, MeanLoading_Psychosis, MeanLoading_Externalizing, MeanLoading_Mood));

# Change the colors manually
p <- ggplot(data=df2, aes(x=Diagnoses, y=MeanLoading, fill=Factor, color=Factor)) +
     geom_bar(stat="identity", position=position_dodge(), width=0.75)+
     scale_fill_manual(values=c('#FCC010', '#85338A', '#AB2924', '#005D9B')) +
     scale_color_manual(values=c('#FCC010', '#85338A', '#AB2924', '#005D9B')) +
     theme_classic() + 
     theme(legend.position = "none") + 
     labs(x = "", y = "Factor Score (Z)") +
     theme(axis.text.x = element_text(size=16, color="black"),
            axis.text.y = element_text(size=16, color="black"),
            axis.title=element_text(size=16, color="black")) +
     theme(axis.text.x = element_text(angle = 35, hjust = 1)) +
     scale_y_continuous(limits = c(-0.61, 1.83), breaks = c(-0.5, 0, 0.5, 1.0, 1.5))
ggsave('/Users/zaixucui/Dropbox/Paper_Writing_Postdoc/pncSingleParcellation_Psychopathology_PLSR/Figures/Figure1_ExploratoryFactorAnalysis/EFA.tiff', width = 28, height = 15, dpi = 600, units = "cm");


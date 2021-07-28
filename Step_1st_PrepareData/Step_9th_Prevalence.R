
library(ggplot2)

Folder = '/Users/zaixucui/Documents/projects/pncSingleFuncParcel_psychopathology/data';
Diagnoses = read.csv(paste0(Folder, '/n1601_goassess_psych_summary_vars_20131014.csv'));
Diagnoses_Psychosis = read.csv(paste0(Folder, '/n1601_diagnosis_dxpmr_20170509.csv'));
SubjectsID_CSV = read.csv(paste0(Folder, '/pncSingleFuncParcelPsychopatho_n790_SubjectsIDs.csv'));
Demographics = read.csv(paste0(Folder, '/n1601_demographics_go1_20161212.csv'));
Diagnoses_Merge = merge(Diagnoses, Diagnoses_Psychosis, by = c("bblid", "scanid"));
Diagnoses_Merge = merge(Diagnoses_Merge, SubjectsID_CSV, by = c("bblid", "scanid"));
Diagnoses_Merge = merge(Diagnoses_Merge, Demographics, by = c("bblid", "scanid"));

mean(Diagnoses_Merge$ageAtScan1)/12
sd(Diagnoses_Merge$ageAtScan1)/12
length(which(Diagnoses_Merge$sex == 1)) # Male

# Prevalence
Diagnoses_Merge$smry_add = 0
Diagnoses_Merge$smry_add[which(Diagnoses_Merge$goassessSmryAdd==4)] = 1;
Diagnoses_Merge$smry_agr = 0
Diagnoses_Merge$smry_agr[which(Diagnoses_Merge$goassessSmryAgr==4)] = 1;
Diagnoses_Merge$smry_ano = 0
Diagnoses_Merge$smry_ano[which(Diagnoses_Merge$goassessSmryAno==4)] = 1;
Diagnoses_Merge$smry_bul = 0
Diagnoses_Merge$smry_bul[which(Diagnoses_Merge$goassessSmryBul==4)] = 1;
Diagnoses_Merge$smry_con = 0
Diagnoses_Merge$smry_con[which(Diagnoses_Merge$goassessSmryCon==4)] = 1;
Diagnoses_Merge$smry_gad = 0
Diagnoses_Merge$smry_gad[which(Diagnoses_Merge$goassessSmryGad==4)] = 1;
Diagnoses_Merge$smry_man = 0
Diagnoses_Merge$smry_man[which(Diagnoses_Merge$goassessSmryMan==4)] = 1;
Diagnoses_Merge$smry_dep = 0#
Diagnoses_Merge$smry_dep[which(Diagnoses_Merge$goassessSmryDep==4)] = 1;
Diagnoses_Merge$smry_ocd = 0
Diagnoses_Merge$smry_ocd[which(Diagnoses_Merge$goassessSmryOcd==4)] = 1;
Diagnoses_Merge$smry_odd = 0
Diagnoses_Merge$smry_odd[which(Diagnoses_Merge$goassessSmryOdd==4)] = 1;
Diagnoses_Merge$smry_pan = 0
Diagnoses_Merge$smry_pan[which(Diagnoses_Merge$goassessSmryPan==4)] = 1;
Diagnoses_Merge$smry_psy = 0
Diagnoses_Merge$smry_psy[which(Diagnoses_Merge$goassessDxpmr4=="4PS")] = 1;
Diagnoses_Merge$smry_ptsd = 0
Diagnoses_Merge$smry_ptsd[which(Diagnoses_Merge$goassessSmryPtd==4)] = 1;
Diagnoses_Merge$smry_sep = 0
Diagnoses_Merge$smry_sep[which(Diagnoses_Merge$goassessSmrySep==4)] = 1;
Diagnoses_Merge$smry_soc = 0
Diagnoses_Merge$smry_soc[which(Diagnoses_Merge$goassessSmrySoc==4)] = 1;
Diagnoses_Merge$smry_sph = 0
Diagnoses_Merge$smry_sph[which(Diagnoses_Merge$goassessSmryPhb==4)] = 1;
DiagnosesSum = rowSums(Diagnoses_Merge[,49:64]);
Diagnoses_Merge$TD = 0;
Diagnoses_Merge$TD[which(DiagnosesSum==0)] = 1;

TD_number = length(which(Diagnoses_Merge$TD==1)) # TD, 245
TD_number/790

add_number = length(which(Diagnoses_Merge$smry_add==1)) # ADHD, 114
add_number/790

agr_number = length(which(Diagnoses_Merge$smry_agr==1)) # Agoraphobia, 47
agr_number/790

ano_number = length(which(Diagnoses_Merge$smry_ano==1)) # Anorexia, 10
ano_number/790

bul_number = length(which(Diagnoses_Merge$smry_bul==1)) # Bulimia, 3
bul_number/790

con_number = length(which(Diagnoses_Merge$smry_con==1)) # Conduct Disorder, 64
con_number/790

gad_number = length(which(Diagnoses_Merge$smry_gad==1)) # Generalized Anxiety, 14
gad_number/790

man_number = length(which(Diagnoses_Merge$smry_man==1)) # Mania, 10
man_number/790

dep_number = length(which(Diagnoses_Merge$smry_dep==1)) # Depressive, 132
dep_number/790

ocd_number = length(which(Diagnoses_Merge$smry_ocd==1)) # OCD, 21
ocd_number/790

odd_number = length(which(Diagnoses_Merge$smry_odd==1)) # ODD, 236
odd_number/790

pan_number = length(which(Diagnoses_Merge$smry_pan==1)) # PAN, 5
pan_number/790

psy_number = length(which(Diagnoses_Merge$smry_psy==1)) # Psychosis, 226
psy_number/790

ptsd_number = length(which(Diagnoses_Merge$smry_ptsd==1)) # PTSD, 99
ptsd_number/790

sep_number = length(which(Diagnoses_Merge$smry_sep==1)) # Separation Anxiety, 34
sep_number/790

soc_number = length(which(Diagnoses_Merge$smry_soc==1)) # Social Phobia, 189
soc_number/790

sph_number = length(which(Diagnoses_Merge$smry_sph==1)) # Specific Phobia, 242
sph_number/790

# matrix figure
# ADHD, Agoraphobia, Conduct, MDD, OCD, ODD, PS, PTSD, Sep Anxiety, Soc Phobia, Spec Phobia
DiagnosesFlag = matrix(0, 790, 11);
DiagnosesFlag[, 1] = Diagnoses_Merge$smry_add;
DiagnosesFlag[, 2] = Diagnoses_Merge$smry_agr;
DiagnosesFlag[, 3] = Diagnoses_Merge$smry_con;
DiagnosesFlag[, 4] = Diagnoses_Merge$smry_dep;
DiagnosesFlag[, 5] = Diagnoses_Merge$smry_ocd;
DiagnosesFlag[, 6] = Diagnoses_Merge$smry_odd;
DiagnosesFlag[, 7] = Diagnoses_Merge$smry_psy;
DiagnosesFlag[, 8] = Diagnoses_Merge$smry_ptsd;
DiagnosesFlag[, 9] = Diagnoses_Merge$smry_sep;
DiagnosesFlag[, 10] = Diagnoses_Merge$smry_soc;
DiagnosesFlag[, 11] = Diagnoses_Merge$smry_sph;
# Overlap matrix plot
OverlapMatrix = matrix(0, 11, 11);
for (i in c(1:11)){
	Indice_I = which(DiagnosesFlag[, i] == 1);
	Number_I = length(Indice_I);
	for (j in c(1:11)){
		Number_J = length(which(DiagnosesFlag[Indice_I, j] == 1));
		OverlapMatrix[i, j] = Number_J/Number_I;
	}
}
diag(OverlapMatrix) = NA;
colnames(OverlapMatrix) = as.factor(c('ADHD', 'Agoraphobia', 'Conduct', 'MDD', 'OCD', 'ODD', 'PS', 'PTSD', 'SepAnxiety', 'SocPhobia', 'SpecPhobia'));
rownames(OverlapMatrix) = as.factor(c('ADHD', 'Agoraphobia', 'Conduct', 'MDD', 'OCD', 'ODD', 'PS', 'PTSD', 'SepAnxiety', 'SocPhobia', 'SpecPhobia'));
library(pheatmap)
library(RColorBrewer)
pheatmap(OverlapMatrix, display_numbers=T, cluster_rows = FALSE, cluster_cols = FALSE, color = colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(100), fontsize_number=10)
# Histogram of number of diagnoses
NumberOfDiagnoses = rowSums(DiagnosesFlag); # Number of diagnoses is from 0 to 8
sbjNum_EachNumOfDiagnoses = matrix(0, 1, 9);
for (i in c(0:9)){
	sbjNum_EachNumOfDiagnoses[i + 1] = length(which(NumberOfDiagnoses == i));
}
Number = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
barplot(sbjNum_EachNumOfDiagnoses, names.arg=Number, ylim=c(0, 250));


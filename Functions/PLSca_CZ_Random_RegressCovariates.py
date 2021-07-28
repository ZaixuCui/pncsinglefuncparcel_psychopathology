# -*- coding: utf-8 -*-

import os
import scipy.io as sio
import numpy as np
import time
import random
from sklearn import linear_model
from sklearn import preprocessing
from joblib import Parallel, delayed
from sklearn.cross_decomposition import PLSCanonical
from sklearn.experimental import enable_iterative_imputer  
from sklearn.impute import IterativeImputer
import statsmodels.formula.api as sm
CodesPath = '/cbica/projects/pncSingleFuncParcel/pncSingleFuncParcel_psycho/scripts/AnalysisScripts/Functions';

def PLSca_KFold_RandomCV_MultiTimes(Brain_Matrix, Behavior_Matrix, Covariates, Components_Number, Fold_Quantity, CVRepeatTimes, ResultantFolder, Permutation_Flag):

    if not os.path.exists(ResultantFolder):
        os.makedirs(ResultantFolder);
    Brain_Matrix_Mat = {'Brain_Matrix': Brain_Matrix}
    Brain_Matrix_Mat_Path = ResultantFolder + '/Brain_Matrix.mat'
    sio.savemat(Brain_Matrix_Mat_Path, Brain_Matrix_Mat);
    Behavior_Matrix_Mat = {'Behavior_Matrix': Behavior_Matrix}
    Behavior_Matrix_Mat_Path = ResultantFolder + '/Behavior_Matrix.mat'
    sio.savemat(Behavior_Matrix_Mat_Path, Behavior_Matrix_Mat);

    Corr_MTimes = np.zeros((CVRepeatTimes, Components_Number));
    for i in np.arange(CVRepeatTimes):
        ResultantFolder_TimeI = ResultantFolder + '/Time_' + str(i)
        if not os.path.exists(ResultantFolder_TimeI):
            os.makedirs(ResultantFolder_TimeI);
        if not os.path.exists(ResultantFolder_TimeI + '/Res_NFold.mat'):
            Configuration_Mat = {'Brain_Matrix_Mat_Path': Brain_Matrix_Mat_Path, \
                                 'Behavior_Matrix_Mat_Path': Behavior_Matrix_Mat_Path, \
                                 'Covariates': Covariates, \
                                 'Components_Number': Components_Number, \
                                 'Fold_Quantity': Fold_Quantity, \
                                 'CVRepeatTimes': CVRepeatTimes, \
                                 'ResultantFolder_TimeI': ResultantFolder_TimeI, \
                                 'Permutation_Flag': Permutation_Flag};
            sio.savemat(ResultantFolder_TimeI + '/Configuration.mat', Configuration_Mat);

            system_cmd = 'python3 -c ' + '\'import sys;\
                sys.path.append("' + CodesPath + '");\
                from PLSca_CZ_Random_RegressCovariates import PLSca_KFold_RandomCV_MultiTimes_Sub;\
                import os;\
                import scipy.io as sio;\
                Configuration = sio.loadmat("' + ResultantFolder_TimeI + '/Configuration.mat");\
                Brain_Matrix_Mat_Path = Configuration["Brain_Matrix_Mat_Path"];\
                Behavior_Matrix_Mat_Path = Configuration["Behavior_Matrix_Mat_Path"];\
                Covariates = Configuration["Covariates"];\
                Components_Number = Configuration["Components_Number"];\
                Fold_Quantity = Configuration["Fold_Quantity"];\
                ResultantFolder_TimeI = Configuration["ResultantFolder_TimeI"];\
                Permutation_Flag = Configuration["Permutation_Flag"];\
                PLSca_KFold_RandomCV_MultiTimes_Sub(Brain_Matrix_Mat_Path[0], Behavior_Matrix_Mat_Path[0], Covariates, Components_Number[0][0], Fold_Quantity[0][0], ResultantFolder_TimeI[0], Permutation_Flag[0][0])\' ';
            system_cmd = system_cmd + ' > "' + ResultantFolder_TimeI + '/Time_' + str(i) + '.log" 2>&1\n'
            script = open(ResultantFolder_TimeI + '/script.sh', 'w');
            script.write(system_cmd);
            script.close();
            Option = ' -V -o "' + ResultantFolder_TimeI + '/RandomCV_' + str(i) + '.o" -e "' + ResultantFolder_TimeI + '/RandomCV_' + str(i) + '.e" ';
            os.system('chmod +x ' + ResultantFolder_TimeI + '/script.sh');
            os.system('qsub -N RandomCV_' + str(i) + Option + ' ' + ResultantFolder_TimeI + '/script.sh')
            #os.system('sh ' + ResultantFolder_TimeI + '/script.sh');

def PLSca_KFold_RandomCV_MultiTimes_Sub(Brain_Matrix_Mat_Path, Behavior_Matrix_Mat_Path, Covariates, Components_Number, Fold_Quantity, ResultantFolder, Permutation_Flag):

    data = sio.loadmat(Brain_Matrix_Mat_Path);
    Brain_Matrix = data['Brain_Matrix'];
    data = sio.loadmat(Behavior_Matrix_Mat_Path);
    Behavior_Matrix = data['Behavior_Matrix'];
    PLSca_KFold_RandomCV(Brain_Matrix, Behavior_Matrix, Covariates, Components_Number, Fold_Quantity, ResultantFolder, Permutation_Flag);
 
def PLSca_KFold_RandomCV(Brain_Matrix, Behavior_Matrix, Covariates, Components_Number, Fold_Quantity, ResultantFolder, Permutation_Flag):

    if not os.path.exists(ResultantFolder):
        os.makedirs(ResultantFolder)
    Subjects_Quantity = np.shape(Brain_Matrix)[0]
    EachFold_Size = np.int(np.fix(np.divide(Subjects_Quantity, Fold_Quantity)))
    Remain = np.mod(Subjects_Quantity, Fold_Quantity)
    RandIndex = np.arange(Subjects_Quantity)
    np.random.shuffle(RandIndex)
    RandIndex_Mat = {'RandIndex': RandIndex};
    sio.savemat(ResultantFolder + '/RandIndex.mat', RandIndex_Mat);
    
    Features_Quantity = np.shape(Brain_Matrix)[1];
    Behavior_Quantity = np.shape(Behavior_Matrix)[1];
    Covariates_Quantity = np.shape(Covariates)[1];
    Fold_Corr = np.zeros((Fold_Quantity, Components_Number))
    for j in np.arange(Fold_Quantity):
        Fold_J_Index = RandIndex[EachFold_Size * j + np.arange(EachFold_Size)]
        if Remain > j:
            Fold_J_Index = np.insert(Fold_J_Index, len(Fold_J_Index), RandIndex[EachFold_Size * Fold_Quantity + j]);

        Brain_test = Brain_Matrix[Fold_J_Index, :]
        Behavior_test = Behavior_Matrix[Fold_J_Index, :]
        Covariates_test = Covariates[Fold_J_Index, :]
        Brain_train = np.delete(Brain_Matrix, Fold_J_Index, axis=0)
        Behavior_train = np.delete(Behavior_Matrix, Fold_J_Index, axis=0) 
        Covariates_train = np.delete(Covariates, Fold_J_Index, axis=0)

        imp_mean = IterativeImputer(random_state=0, sample_posterior=True)
        Behavior_train = imp_mean.fit_transform(Behavior_train);
        Behavior_test = imp_mean.transform(Behavior_test);

        # Controlling covariates from brain data
        df = {};
        for k in np.arange(Covariates_Quantity):
            df['Covariate_'+str(k)] = Covariates_train[:,k];
        # Construct formula
        Formula = 'Data ~ Covariate_0';
        for k in np.arange(Covariates_Quantity - 1) + 1:
            Formula = Formula + ' + Covariate_' + str(k)
        # Regress covariates from each brain feature
        for k in np.arange(Features_Quantity):
            df['Data'] = Brain_train[:,k];
            # Regressing covariates using training data
            LinModel_Res = sm.ols(formula=Formula, data=df).fit()
            # Using residuals replace the training data
            Brain_train[:,k] = LinModel_Res.resid;
            # Calculating the residuals of testing data by applying the coeffcients of training data
            Coefficients = LinModel_Res.params;
            Brain_test[:,k] = Brain_test[:,k] - Coefficients[0];
            for m in np.arange(Covariates_Quantity):
                Brain_test[:,k] = Brain_test[:,k] - Coefficients[m+1]*Covariates_test[:,m]

        if Permutation_Flag:
          # If do permutation, the training scores should be permuted
          Training_Quantity = np.shape(Behavior_train)[0]
          Subjects_Index_Random = np.arange(Training_Quantity)
          np.random.shuffle(Subjects_Index_Random)
          Behavior_train = Behavior_train[Subjects_Index_Random, :]
          if j == 0:
              PermutationIndex = {'Fold_0': Subjects_Index_Random}
          else:
              PermutationIndex['Fold_' + str(j)] = Subjects_Index_Random

        normalize = preprocessing.StandardScaler()
        Brain_train = normalize.fit_transform(Brain_train);
        Brain_test = normalize.transform(Brain_test);
        Behavior_train = normalize.fit_transform(Behavior_train)
        Behavior_test = normalize.transform(Behavior_test)

        plsca = PLSCanonical(n_components=Components_Number, algorithm='svd');
        plsca.fit(Brain_train, Behavior_train);
        Covariances = plsca.Covariances;
        Brain_test_ca, Behavior_test_ca = plsca.transform(Brain_test, Behavior_test);
    
        # Correlation on training data
        Fold_J_Corr_Training = [];
        for k in np.arange(Components_Number):
            Fold_J_Corr_tmp = np.corrcoef(plsca.x_scores_[:,k], plsca.y_scores_[:,k])
            Fold_J_Corr_tmp = Fold_J_Corr_tmp[0,1]
            Fold_J_Corr_Training.append(Fold_J_Corr_tmp)
        # Correlation on testing data
        Fold_J_Corr = [];
        for k in np.arange(Components_Number):
            Fold_J_Corr_tmp = np.corrcoef(Brain_test_ca[:,k], Behavior_test_ca[:,k])
            Fold_J_Corr_tmp = Fold_J_Corr_tmp[0,1]
            Fold_J_Corr.append(Fold_J_Corr_tmp)

        Brain_Weight = plsca.x_weights_;
        Behavior_Weight = plsca.y_weights_;
        Fold_J_result = {'Index': Fold_J_Index, 'Fold_J_Corr': Fold_J_Corr, \
                         'Brain_test_ca': Brain_test_ca, 'Behavior_test_ca': Behavior_test_ca, \
                         'Brain_Weight': Brain_Weight, 'Behavior_Weight': Behavior_Weight, \
                         'Fold_J_Corr_Training': Fold_J_Corr_Training, 'Covariances': Covariances}
        Fold_J_FileName = 'Fold_' + str(j) + '_Score.mat'
        ResultantFile = os.path.join(ResultantFolder, Fold_J_FileName)
        sio.savemat(ResultantFile, Fold_J_result)
        Fold_Corr[j,:] = Fold_J_Corr;

    Mean_Corr = np.mean(Fold_Corr, axis = 0)
    Res_NFold = {'Mean_Corr':Mean_Corr};
    ResultantFile = os.path.join(ResultantFolder, 'Res_NFold.mat')
    sio.savemat(ResultantFile, Res_NFold)
    return (Mean_Corr)  


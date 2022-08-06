%% Read preds and target of VMD-empowered models
% %Always change the mode number and which IMFs to use before running the rest of this section..
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2\EXPIII'))
clear
clc

%VOL 1m
%-Preds 
path4  = 'test_predsdata_VOLF1m_VolTime_LSTMPlus63IMFs_FallWinter_S2';
opts = detectImportOptions(path4);
Vol_1m_Season1_S2 = readtable(path4,opts);

path4  = 'test_predsdata_VOLF1m_VolTime_LSTMPlus31IMFs_SpringSummer_S2';
opts = detectImportOptions(path4);
Vol_1m_Season2_S2 = readtable(path4,opts);

%-Targets
path4  = strrep('test_predsdata_VOLF1m_VolTime_LSTMPlus63IMFs_FallWinter_S2','preds','target');
opts = detectImportOptions(path4);
Vol_1m_Season1_S2_targets = readtable(path4,opts);

path4  = strrep('test_predsdata_VOLF1m_VolTime_LSTMPlus31IMFs_SpringSummer_S2','preds','target');
opts = detectImportOptions(path4);
Vol_1m_Season2_S2_targets = readtable(path4,opts);
 
%THICK 1m
%-Preds 
path4  = 'test_predsdata_THICKF1m_ThickTime_LSTMPlus71IMFs_FallWinter_S2';
opts = detectImportOptions(path4);
Thick_1m_Season1_S2 = readtable(path4,opts);

path4  = 'test_predsdata_THICKF1m_ThickTime_LSTMPlus29IMFs_SpringSummer_S2';
opts = detectImportOptions(path4);
Thick_1m_Season2_S2 = readtable(path4,opts);

%-Targets
path4  = strrep('test_predsdata_THICKF1m_ThickTime_LSTMPlus71IMFs_FallWinter_S2','preds','target');
opts = detectImportOptions(path4);
Thick_1m_Season1_S2_targets = readtable(path4,opts);

path4  = strrep('test_predsdata_THICKF1m_ThickTime_LSTMPlus29IMFs_SpringSummer_S2','preds','target');
opts = detectImportOptions(path4);
Thick_1m_Season2_S2_targets = readtable(path4,opts);

%VOL 7d
%-Preds 
path4  = 'test_predsdata_VOLF7d_VolTime_LSTMPlus39IMFs_FallWinter_S2';
opts = detectImportOptions(path4);
Vol_7d_Season1_S2 = readtable(path4,opts);

path4  = 'test_predsdata_VOLF7d_VolTime_LSTMPlus15IMFs_SpringSummer_S2';
opts = detectImportOptions(path4);
Vol_7d_Season2_S2 = readtable(path4,opts);

%-Targets
path4  = strrep('test_predsdata_VOLF7d_VolTime_LSTMPlus39IMFs_FallWinter_S2','preds','target');
opts = detectImportOptions(path4);
Vol_7d_Season1_S2_targets = readtable(path4,opts);

path4  = strrep('test_predsdata_VOLF7d_VolTime_LSTMPlus15IMFs_SpringSummer_S2','preds','target');
opts = detectImportOptions(path4);
Vol_7d_Season2_S2_targets = readtable(path4,opts);
 
%THICK 7d
%-Preds 
path4  = 'test_predsdata_THICKF7d_ThickTime_LSTMPlus15IMFs_FallWinter_S2';
opts = detectImportOptions(path4);
Thick_7d_Season1_S2 = readtable(path4,opts);

path4  = 'test_predsdata_THICKF7d_ThickTime_LSTMPlus31IMFs_SpringSummer_S2';
opts = detectImportOptions(path4);
Thick_7d_Season2_S2 = readtable(path4,opts);

%-Targets
path4  = strrep('test_predsdata_THICKF7d_ThickTime_LSTMPlus15IMFs_FallWinter_S2','preds','target');
opts = detectImportOptions(path4);
Thick_7d_Season1_S2_targets = readtable(path4,opts);

path4  = strrep('test_predsdata_THICKF7d_ThickTime_LSTMPlus31IMFs_SpringSummer_S2','preds','target');
opts = detectImportOptions(path4);
Thick_7d_Season2_S2_targets = readtable(path4,opts);

fprintf('Finished!\n')

%% then, plot performance per metric for all season
%METRICS ARE: RMSE, MAPE, FS, CV
clc
clear y_preds y_test ymean

name= 'Thick_7d_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')

name= 'Thick_1m_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')



clear y_preds y_test ymean

name= 'Vol_7d_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')

name= 'Vol_1m_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')



name= 'Thick_7d_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')

name= 'Thick_1m_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')



clear y_preds y_test ymean

name= 'Vol_7d_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')

name= 'Vol_1m_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
fprintf('\n')



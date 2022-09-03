%% Read preds and target of VMD-empowered models
% %Always change the mode number and which IMFs to use before running the rest of this section..
addpath(genpath('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2\EXPIII'))
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
 
% %THICK 1m
% %-Preds 
% path4  = 'test_predsdata_THICKF1m_ThickTime_LSTMPlus71IMFs_FallWinter_S2';
% opts = detectImportOptions(path4);
% Thick_1m_Season1_S2 = readtable(path4,opts);
% 
% path4  = 'test_predsdata_THICKF1m_ThickTime_LSTMPlus29IMFs_SpringSummer_S2';
% opts = detectImportOptions(path4);
% Thick_1m_Season2_S2 = readtable(path4,opts);
% 
% %-Targets
% path4  = strrep('test_predsdata_THICKF1m_ThickTime_LSTMPlus71IMFs_FallWinter_S2','preds','target');
% opts = detectImportOptions(path4);
% Thick_1m_Season1_S2_targets = readtable(path4,opts);
% 
% path4  = strrep('test_predsdata_THICKF1m_ThickTime_LSTMPlus29IMFs_SpringSummer_S2','preds','target');
% opts = detectImportOptions(path4);
% Thick_1m_Season2_S2_targets = readtable(path4,opts);

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
 
% %THICK 7d
% %-Preds 
% path4  = 'test_predsdata_THICKF7d_ThickTime_LSTMPlus15IMFs_FallWinter_S2';
% opts = detectImportOptions(path4);
% Thick_7d_Season1_S2 = readtable(path4,opts);
% 
% path4  = 'test_predsdata_THICKF7d_ThickTime_LSTMPlus31IMFs_SpringSummer_S2';
% opts = detectImportOptions(path4);
% Thick_7d_Season2_S2 = readtable(path4,opts);
% 
% %-Targets
% path4  = strrep('test_predsdata_THICKF7d_ThickTime_LSTMPlus15IMFs_FallWinter_S2','preds','target');
% opts = detectImportOptions(path4);
% Thick_7d_Season1_S2_targets = readtable(path4,opts);
% 
% path4  = strrep('test_predsdata_THICKF7d_ThickTime_LSTMPlus31IMFs_SpringSummer_S2','preds','target');
% opts = detectImportOptions(path4);
% Thick_7d_Season2_S2_targets = readtable(path4,opts);
clear opts path4
fprintf('Finished!\n')

%% then, plot performance per metric for all season
%METRICS ARE: RMSE, MAPE, FS, CV
clc
clear y_preds y_test ymean
% 
% name= 'Thick_7d_Season1_S2';
% eval(sprintf('y_test = table2array(%s_targets);',name))
% ymean = mean(mean((y_test)));
% 
% eval(sprintf('y_preds = table2array(%s);',name))
% 
% MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
% RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
% CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
% fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
% fprintf('\n')
% 
% name= 'Thick_1m_Season1_S2';
% eval(sprintf('y_test = table2array(%s_targets);',name))
% ymean = mean(mean((y_test)));
% 
% eval(sprintf('y_preds = table2array(%s);',name))
% 
% MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
% RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
% CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
% fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
% fprintf('\n')
% 
% 
% 
% clear y_preds y_test ymean

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


% 
% name= 'Thick_7d_Season2_S2';
% eval(sprintf('y_test = table2array(%s_targets);',name))
% ymean = mean(mean((y_test)));
% 
% eval(sprintf('y_preds = table2array(%s);',name))
% 
% MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
% RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
% CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
% fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
% fprintf('\n')
% 
% name= 'Thick_1m_Season2_S2';
% eval(sprintf('y_test = table2array(%s_targets);',name))
% ymean = mean(mean((y_test)));
% 
% eval(sprintf('y_preds = table2array(%s);',name))
% 
% MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
% RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
% CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
% fprintf('%s, %.3f,%.3f,%.3f\n',name, RMSE,MAPE,CV)
% fprintf('\n')
% 
% 
% 
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

%% Plot RMSE over all horizons

addpath(genpath('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2'))
%Fall/Winter - 7d
season = {'FallWinter'};
mode = {'VolTime'}; model = {'LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'39IMFs'};%
Horizon = {'VOLF7d_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    fprintf(' -Mode %s:\n',mode{:});
    for H=1:length(Horizon)
        fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'F',''));
        for L=1:length(IMFS) %which IMFs group
            model_name = strrep(model,'Plus','');
            fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{:});
            path4  = strcat('\test_predsdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
            opts = detectImportOptions(path4);
            eval(sprintf('X = readtable(''%s'',opts);',path4))
            if gt(size(X,2),6)
                clear data %Just in case!
                col = X.Properties.VariableNames;
                for j = 2 : length(col)
                    for i = 1 :length(X.(col{j}))
                        eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                    end
                    fld = fieldnames(data);
                    tempsum=0;
                    for i=1:length(fld)
                        eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                    end
                    eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                end
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                clear data tempsum
                fprintf('finished!\n')
            else
                eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                fprintf('finished!\n')
            end
        end
        %Targets
        model_name = strrep(model{1},'Plus','');
        path5 = strcat('\EXPII\test_targetdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{1},'_',season{Y},'.csv');
        fprintf(' *Importing targets..');
        opts = detectImportOptions(path5);
        eval(sprintf('X = readtable(''%s'',opts);',path5))
        X = readtable(path5);
        if gt(size(X,2),6) 
            col = X.Properties.VariableNames;
            for j = 2 : length(col)
                for i = 1 :length(X.(col{j}))
                    eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                end
                fld = fieldnames(data);
                tempsum=0;
                for i=1:length(fld)
                    eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                end
            eval(sprintf('%s.%s.%s.Targets = tempsum(:,:);',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            end
            fprintf('finished!\n')

        else
            eval(sprintf('%s.%s.%s.Targets = X;',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            fprintf('finished!\n')

        end
    end
end

clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T Horizon2 path5 X tempsum data


%Spring/Summer - 7d
season = {'SpringSummer'};
mode = {'VolTime'}; model = {'LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'15IMFs'};%
Horizon = {'VOLF7d_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    fprintf(' -Mode %s:\n',mode{:});
    for H=1:length(Horizon)
        fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'F',''));
        for L=1:length(IMFS) %which IMFs group
            model_name = strrep(model,'Plus','');
            fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{:});
            path4  = strcat('\test_predsdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
            opts = detectImportOptions(path4);
            eval(sprintf('X = readtable(''%s'',opts);',path4))
            if gt(size(X,2),6)
                clear data %Just in case!
                col = X.Properties.VariableNames;
                for j = 2 : length(col)
                    for i = 1 :length(X.(col{j}))
                        eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                    end
                    fld = fieldnames(data);
                    tempsum=0;
                    for i=1:length(fld)
                        eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                    end
                    eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                end
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                clear data tempsum
                fprintf('finished!\n')
            else
                eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                fprintf('finished!\n')
            end
        end
        %Targets
        model_name = strrep(model{1},'Plus','');
        path5 = strcat('\EXPII\test_targetdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{1},'_',season{Y},'.csv');
        fprintf(' *Importing targets..');
        opts = detectImportOptions(path5);
        eval(sprintf('X = readtable(''%s'',opts);',path5))
        X = readtable(path5);
        if gt(size(X,2),6) 
            col = X.Properties.VariableNames;
            for j = 2 : length(col)
                for i = 1 :length(X.(col{j}))
                    eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                end
                fld = fieldnames(data);
                tempsum=0;
                for i=1:length(fld)
                    eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                end
            eval(sprintf('%s.%s.%s.Targets = tempsum(:,:);',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            end
            fprintf('finished!\n')

        else
            eval(sprintf('%s.%s.%s.Targets = X;',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            fprintf('finished!\n')

        end
    end
end

clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T Horizon2 path5 X tempsum data

%Fall/Winter - 1m
season = {'FallWinter'};
mode = {'VolTime'}; model = {'LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'63IMFs'};%
Horizon = {'VOLF1m_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    fprintf(' -Mode %s:\n',mode{:});
    for H=1:length(Horizon)
        fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'F',''));
        for L=1:length(IMFS) %which IMFs group
            model_name = strrep(model,'Plus','');
            fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{:});
            path4  = strcat('\test_predsdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
            opts = detectImportOptions(path4);
            eval(sprintf('X = readtable(''%s'',opts);',path4))
            if gt(size(X,2),6)
                clear data %Just in case!
                col = X.Properties.VariableNames;
                for j = 2 : length(col)
                    for i = 1 :length(X.(col{j}))
                        eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                    end
                    fld = fieldnames(data);
                    tempsum=0;
                    for i=1:length(fld)
                        eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                    end
                    eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                end
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                clear data tempsum
                fprintf('finished!\n')
            else
                eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                fprintf('finished!\n')
            end
        end
        %Targets
        model_name = strrep(model{1},'Plus','');
        path5 = strcat('\EXPII\test_targetdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{1},'_',season{Y},'.csv');
        fprintf(' *Importing targets..');
        opts = detectImportOptions(path5);
        eval(sprintf('X = readtable(''%s'',opts);',path5))
        X = readtable(path5);
        if gt(size(X,2),6) 
            col = X.Properties.VariableNames;
            for j = 2 : length(col)
                for i = 1 :length(X.(col{j}))
                    eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                end
                fld = fieldnames(data);
                tempsum=0;
                for i=1:length(fld)
                    eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                end
            eval(sprintf('%s.%s.%s.Targets = tempsum(:,:);',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            end
            fprintf('finished!\n')

        else
            eval(sprintf('%s.%s.%s.Targets = X;',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            fprintf('finished!\n')

        end
    end
end

clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T Horizon2 path5 X tempsum data


%Spring/Summer - 1m
season = {'SpringSummer'};
mode = {'VolTime'}; model = {'LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'31IMFs'};%
Horizon = {'VOLF1m_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    fprintf(' -Mode %s:\n',mode{:});
    for H=1:length(Horizon)
        fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'F',''));
        for L=1:length(IMFS) %which IMFs group
            model_name = strrep(model,'Plus','');
            fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{:});
            path4  = strcat('\test_predsdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
            opts = detectImportOptions(path4);
            eval(sprintf('X = readtable(''%s'',opts);',path4))
            if gt(size(X,2),6)
                clear data %Just in case!
                col = X.Properties.VariableNames;
                for j = 2 : length(col)
                    for i = 1 :length(X.(col{j}))
                        eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                    end
                    fld = fieldnames(data);
                    tempsum=0;
                    for i=1:length(fld)
                        eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                    end
                    eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                end
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                clear data tempsum
                fprintf('finished!\n')
            else
                eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                fprintf('finished!\n')
            end
        end
        %Targets
        model_name = strrep(model{1},'Plus','');
        path5 = strcat('\EXPII\test_targetdata_',Horizon{H},mode{:},'_',model{:},ind{O},IMFS{1},'_',season{Y},'.csv');
        fprintf(' *Importing targets..');
        opts = detectImportOptions(path5);
        eval(sprintf('X = readtable(''%s'',opts);',path5))
        X = readtable(path5);
        if gt(size(X,2),6) 
            col = X.Properties.VariableNames;
            for j = 2 : length(col)
                for i = 1 :length(X.(col{j}))
                    eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                end
                fld = fieldnames(data);
                tempsum=0;
                for i=1:length(fld)
                    eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                end
            eval(sprintf('%s.%s.%s.Targets = tempsum(:,:);',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            end
            fprintf('finished!\n')

        else
            eval(sprintf('%s.%s.%s.Targets = X;',season{Y},mode{:},Horizon{H}));
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            fprintf('finished!\n')

        end
    end
end

clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T Horizon2 path5 X tempsum data


y_test = FallWinter.VolTime.VOLF7d_.Targets;
y_preds = table2array(FallWinter.VolTime.VOLF7d_.IMF39.Preds_LSTMPlus);

ERROR_7d_FallWinter_S1 = sqrt(mean(((y_test-y_preds).^2)));

%
y_test = SpringSummer.VolTime.VOLF7d_.Targets;
y_preds = table2array(SpringSummer.VolTime.VOLF7d_.IMF15.Preds_LSTMPlus);

ERROR_7d_SpringSummer_S1 = sqrt(mean(((y_test-y_preds).^2)));

%
y_test = FallWinter.VolTime.VOLF1m_.Targets;
y_preds = table2array(FallWinter.VolTime.VOLF1m_.IMF63.Preds_LSTMPlus);

ERROR_1m_FallWinter_S1 = sqrt(mean(((y_test-y_preds).^2)));

%
y_test = SpringSummer.VolTime.VOLF1m_.Targets;
y_preds = table2array(SpringSummer.VolTime.VOLF1m_.IMF31.Preds_LSTMPlus);

ERROR_1m_SpringSummer_S1 = sqrt(mean(((y_test-y_preds).^2)));

%


name= 'Vol_7d_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

ERROR_7d_FallWinter_S2 = sqrt(mean(((y_test-y_preds).^2)));

name= 'Vol_7d_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

ERROR_7d_SpringSummer_S2 = sqrt(mean(((y_test-y_preds).^2)));

name= 'Vol_1m_Season1_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

ERROR_1m_FallWinter_S2 = sqrt(mean(((y_test-y_preds).^2)));

name= 'Vol_1m_Season2_S2';
eval(sprintf('y_test = table2array(%s_targets);',name))
y_test = y_test*1000;
ymean = mean(mean((y_test)));

eval(sprintf('y_preds = table2array(%s);',name))
y_preds = y_preds*1000;

ERROR_1m_SpringSummer_S2 = sqrt(mean(((y_test-y_preds).^2)));

%%
%PLOT:FallWinter-7d
size1=23;
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
figure1 = figure('WindowState','maximized');
t = tiledlayout('flow','TileSpacing','tight','Padding','tight');%3,4
nexttile;
plot(categorical(1:length(ERROR_7d_FallWinter_S1)), ERROR_7d_FallWinter_S1','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','Divide \& conquer','Color',[0 0.4470 0.7410]);
hold on;
plot(categorical(1:length(ERROR_7d_FallWinter_S2)), ERROR_7d_FallWinter_S2','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','All-in-one','Color',[0.8500 0.3250 0.0980]);
ylabel('RMSE ($km^3$)','Interpreter','latex','FontSize',15)
xlabel('Horizon','Interpreter','latex','FontSize',15)
set(gca,'FontSize',15,'TickLabelInterpreter','latex','Ylim',[0 max(max(ERROR_7d_FallWinter_S1'+1,ERROR_7d_FallWinter_S2'+1))+20]);            
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex','XGrid','on','YGrid','on','YMinorGrid','on');%,'Ylim',[0 500]); just in the case of Household 3
box(gca,'on');
text(categorical(1:length(ERROR_7d_FallWinter_S1)), ERROR_7d_FallWinter_S1'+1,num2str(round(ERROR_7d_FallWinter_S1')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
text(categorical(1:length(ERROR_7d_FallWinter_S2)), ERROR_7d_FallWinter_S2'+1,num2str(round(ERROR_7d_FallWinter_S2')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
%then EXPORT
exportgraphics(t,string(strcat('Errors_EXPIII_FallWinter_7d.pdf')),'ContentType','vector')
fprintf(' done!\n')
exportgraphics(t,string(strcat('Errors_EXPIII_FallWinter_7d.pdf')),'ContentType','vector')
close(gcf)

%PLOT:SpringSummer-7d
size1=23;
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
figure1 = figure('WindowState','maximized');
t = tiledlayout('flow','TileSpacing','tight','Padding','tight');%3,4
nexttile;
plot(categorical(1:length(ERROR_7d_SpringSummer_S1)), ERROR_7d_SpringSummer_S1','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','Divide \& conquer','Color',[0 0.4470 0.7410]);
hold on;
plot(categorical(1:length(ERROR_7d_SpringSummer_S2)), ERROR_7d_SpringSummer_S2','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','All-in-one','Color',[0.8500 0.3250 0.0980]);
ylabel('RMSE ($km^3$)','Interpreter','latex','FontSize',15)
xlabel('Horizon','Interpreter','latex','FontSize',15)
set(gca,'FontSize',15,'TickLabelInterpreter','latex','Ylim',[0 max(max(ERROR_7d_SpringSummer_S1'+1,ERROR_7d_SpringSummer_S2'+1))+20]);            
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex','XGrid','on','YGrid','on','YMinorGrid','on');%,'Ylim',[0 500]); just in the case of Household 3
box(gca,'on');
text(categorical(1:length(ERROR_7d_SpringSummer_S1)), ERROR_7d_SpringSummer_S1'+1,num2str(round(ERROR_7d_SpringSummer_S1')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
text(categorical(1:length(ERROR_7d_SpringSummer_S2)), ERROR_7d_SpringSummer_S2'+1,num2str(round(ERROR_7d_SpringSummer_S2')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
%then EXPORT
exportgraphics(t,string(strcat('Errors_EXPIII_SpringSummer_7d.pdf')),'ContentType','vector')
fprintf(' done!\n')
exportgraphics(t,string(strcat('Errors_EXPIII_SpringSummer_7d.pdf')),'ContentType','vector')
close(gcf)


%PLOT:FallWinter-1m
size1=23;
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
figure1 = figure('WindowState','maximized');
t = tiledlayout('flow','TileSpacing','tight','Padding','tight');%3,4
nexttile;
plot(categorical(1:length(ERROR_1m_FallWinter_S1)), ERROR_1m_FallWinter_S1','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','Divide \& conquer','Color',[0 0.4470 0.7410]);
hold on;
plot(categorical(1:length(ERROR_1m_FallWinter_S2)), ERROR_1m_FallWinter_S2','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','All-in-one','Color',[0.8500 0.3250 0.0980]);
ylabel('RMSE ($km^3$)','Interpreter','latex','FontSize',15)
xlabel('Horizon','Interpreter','latex','FontSize',15)
set(gca,'FontSize',15,'TickLabelInterpreter','latex','Ylim',[0 max(max(ERROR_1m_FallWinter_S1'+1,ERROR_1m_FallWinter_S2'+1))+50]);            
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex','XGrid','on','YGrid','on','YMinorGrid','on');%,'Ylim',[0 500]); just in the case of Household 3
box(gca,'on');
text(categorical(1:length(ERROR_1m_FallWinter_S1)), ERROR_1m_FallWinter_S1'+1,num2str(round(ERROR_1m_FallWinter_S1')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
text(categorical(1:length(ERROR_1m_FallWinter_S2)), ERROR_1m_FallWinter_S2'+1,num2str(round(ERROR_1m_FallWinter_S2')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')

%then EXPORT
exportgraphics(t,string(strcat('Errors_EXPIII_FallWinter_1m.pdf')),'ContentType','vector')
fprintf(' done!\n')
exportgraphics(t,string(strcat('Errors_EXPIII_FallWinter_1m.pdf')),'ContentType','vector')
close(gcf)


%PLOT:SpringSummer-1m
size1=23;
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
figure1 = figure('WindowState','maximized');
t = tiledlayout('flow','TileSpacing','tight','Padding','tight');%3,4
nexttile;
plot(categorical(1:length(ERROR_1m_SpringSummer_S1)), ERROR_1m_SpringSummer_S1','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','Divide \& conquer','Color',[0 0.4470 0.7410]);
hold on;
plot(categorical(1:length(ERROR_1m_SpringSummer_S2)), ERROR_1m_SpringSummer_S2','Marker','o','MarkerFaceColor','w','MarkerSize',10,'LineWidth',3.5,'Parent',gca,'DisplayName','All-in-one','Color',[0.8500 0.3250 0.0980]);
ylabel('RMSE ($km^3$)','Interpreter','latex','FontSize',15)
xlabel('Horizon','Interpreter','latex','FontSize',15)
set(gca,'FontSize',15,'TickLabelInterpreter','latex','Ylim',[0 max(max(ERROR_1m_SpringSummer_S1'+1,ERROR_1m_SpringSummer_S2'+1))+30]);            
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex','XGrid','on','YGrid','on','YMinorGrid','on');%,'Ylim',[0 500]); just in the case of Household 3
box(gca,'on');
text(categorical(1:length(ERROR_1m_SpringSummer_S1)), ERROR_1m_SpringSummer_S1'+1,num2str(round(ERROR_1m_SpringSummer_S1')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')
text(categorical(1:length(ERROR_1m_SpringSummer_S2)), ERROR_1m_SpringSummer_S2'+1,num2str(round(ERROR_1m_SpringSummer_S2')),'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',15,'Interpreter','latex')

%then EXPORT
exportgraphics(t,string(strcat('Errors_EXPIII_SpringSummer_1m.pdf')),'ContentType','vector')
fprintf(' done!\n')
exportgraphics(t,string(strcat('Errors_EXPIII_SpringSummer_1m.pdf')),'ContentType','vector')
close(gcf)


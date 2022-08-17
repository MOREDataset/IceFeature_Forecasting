%% Read preds and target of VMD-empowered models
% %Always change the mode number and which IMFs to use before running the rest of this section..
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2'))
clear
clc
season = {'SpringSummer','FallWinter'};
mode = {'VolTime'}; model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'', '31IMFs'};%
Horizon = {'VOLF7d_','VOLF1m_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    for M=1:length(mode)%which mode
        fprintf(' -Mode %s:\n',mode{M});
        for H=1:length(Horizon)
            fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
            for L=1:length(IMFS) %which IMFs group
                for k = 1:length(model) %which model
                    model_name = strrep(model{k},'Plus','');
                    if isequal(L,1)
                        fprintf('   *Processing predictions using %s with model: %s...','noVMD',model{k});
                        path2  = strcat('\test_predsdata_',Horizon{H},mode{M},'_',model{k},ind{O},'_',season{Y},'.csv');
                        if ~exist(path2)
                            path2 = strrep(path2,'VOL','ICE');
                        end
                        opts = detectImportOptions((path2));
                        eval(sprintf('%s.%s.%s.noVMD.Preds_%s = readtable(''%s'',opts);',season{Y},mode{M},Horizon{H},model{k},path2))
                        eval(sprintf('%s.%s.%s.noVMD.Preds_%s.Variables = %s.%s.%s.noVMD.Preds_%s.Variables*1000;',season{Y},mode{M},Horizon{H},model{k},season{Y},mode{M},Horizon{H},model{k})) %values*unit (1000)
                        fprintf('finished!\n')
                    else
                        fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{k});
                        path4  = strcat('\test_predsdata_',Horizon{H},mode{M},'_',model{k},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
                        if ~exist(path4)
                            path4 = strrep(path4,'VOL','ICE');
                        end
                        opts = detectImportOptions(path4);
                        eval(sprintf('X = readtable(''%s'',opts);',path4))
                        if gt(size(X,2),7)
                            col = X.Properties.VariableNames;
                            for j = 2 : length(col)
                                for i = 1 :length(X.(col{j}))
                                    eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                                end
                            end
                            fld = fieldnames(data);
                            tempsum=0;
                            for i=1:length(fld)
                                eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                            end
                            eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{M},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                        else
                            eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{M},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                        end
                        eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{M},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{k},season{Y},mode{M},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                        clear data tempsum
                        fprintf('finished!\n')
                    end
                end
            end
            %Targets
            model_name = strrep(model{1},'Plus','');
            if isequal(Y,2)
                path5 =   sprintf('%sVolsequences_%s.csv',Horizon{H},season{Y});
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T(round(height(T)*80/100)+1:end,:));                
                eval(sprintf('%s.%s.%s.Targets = Target(:,indx:end);',season{Y},mode{M},Horizon{H}));                
            else
                path5 = strcat('\test_targetdata_',Horizon{H},mode{M},'_',model{k},ind{O},'_',season{Y},'.csv');            
                fprintf(' *Importing targets..');
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T);
                eval(sprintf('%s.%s.%s.Targets = Target(:,:);',season{Y},mode{M},Horizon{H}));                
            end
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{M},Horizon{H},season{Y},mode{M},Horizon{H}));
            clear dataTarget tempsum Target X
            fprintf('finished!\n')
        end
    end
end

mode = {'Time'}; %Modes are split because Time is not decomposed, only thickTime is!
IMFS={''};%
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    for M=1:length(mode)%which mode
        fprintf(' -Mode %s:\n',mode{M});
        for H=1:length(Horizon)
            fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
            for L=1:length(IMFS) %which IMFs group
                for k = 1:length(model) %which model
                    model_name = strrep(model{k},'Plus','');
                    if isequal(L,1)
                        fprintf('   *Processing predictions using %s with model: %s...','noVMD',model{k});
                        path2  = strcat('\test_predsdata_',Horizon{H},mode{M},'_',model{k},ind{O},'_',season{Y},'.csv');
                        if ~exist(path2)
                            path2 = strrep(path2,'VOL','ICE');
                        end
                        opts = detectImportOptions((path2));
                        eval(sprintf('%s.%s.%s.noVMD.Preds_%s = readtable(''%s'',opts);',season{Y},mode{M},Horizon{H},model{k},path2))
                        eval(sprintf('%s.%s.%s.noVMD.Preds_%s.Variables = %s.%s.%s.noVMD.Preds_%s.Variables*1000;',season{Y},mode{M},Horizon{H},model{k},season{Y},mode{M},Horizon{H},model{k})) %values*unit (1000)
                        fprintf('finished!\n')
                    end
                end
            end
            %Targets
            model_name = strrep(model{1},'Plus','');
            fprintf(' *Importing targets..');
            if isequal(Y,2)
                path5 =   sprintf('%sVolsequences_%s.csv',Horizon{H},season{Y});
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T(round(height(T)*80/100)+1:end,:));                
                eval(sprintf('%s.%s.%s.Targets = Target(:,indx:end);',season{Y},mode{M},Horizon{H}));                
            else
                path5 = strcat('\test_targetdata_',Horizon{H},mode{M},'_',model{k},ind{O},'_',season{Y},'.csv');            
                fprintf(' *Importing targets..');
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T);
                eval(sprintf('%s.%s.%s.Targets = Target(:,:);',season{Y},mode{M},Horizon{H}));                
            end
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{M},Horizon{H},season{Y},mode{M},Horizon{H}));
            clear dataTarget tempsum Target X
            fprintf('finished!\n')
        end
    end
end


season = {'SpringSummer','FallWinter'};
mode = {'VolTime'}; model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'EMD4IMFs'};%
Horizon = {'VOLF7d_','VOLF1m_'};%
indx = 31;
for Y = 1:length(season)
    fprintf('%s season:\n',season{Y});
    for M=1:length(mode)%which mode
        fprintf(' -Mode %s:\n',mode{M});
        for H=1:length(Horizon)
            fprintf('  -%s horizon:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
            for L=1:length(IMFS) %which IMFs group
                for k = 1:length(model) %which model
                    model_name = strrep(model{k},'Plus','');
                    fprintf('   *Processing predictions using %s with model: %s...',IMFS{L},model{k});
                    path4  = strcat('\test_predsdata_',Horizon{H},mode{M},'_',model{k},ind{O},IMFS{L},'_',season{Y},'.csv'); %model_name
                    if ~exist(path4)
                        path4 = strrep(path4,'VOL','ICE');
                    end
                    opts = detectImportOptions(path4);
                    eval(sprintf('X = readtable(''%s'',opts);',path4))
                    if gt(size(X,2),5)
                        col = X.Properties.VariableNames;
                        for j = 2 : length(col)
                            for i = 1 :length(X.(col{j}))
                                eval(sprintf('data.%s(i,:) =  cell2mat(textscan(erase(X.%s{i},{''['', '']''}),''%%f''));',(col{j}),(col{j})))
                            end
                        end
                        fld = fieldnames(data);
                        tempsum=0;
                        for i=1:length(fld)
                            eval(sprintf('tempsum=tempsum+data.%s;',fld{i}))
                        end
                        eval(sprintf('%s.%s.%s.%s.Preds_%s = table(tempsum);',season{Y},mode{M},Horizon{H},string(strcat('EMDIMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                    else
                        eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{M},Horizon{H},string(strcat('EMDIMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                    end
                    eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{M},Horizon{H},string(strcat('EMDIMF',regexp(IMFS{L},'\d*','match'))),model{k},season{Y},mode{M},Horizon{H},string(strcat('EMDIMF',regexp(IMFS{L},'\d*','match'))),model{k}))
                    clear data tempsum
                    fprintf('finished!\n')
                end
            end
            %Targets
            model_name = strrep(model{1},'Plus','');
            if isequal(Y,2)
                path5 =   sprintf('%sVolsequences_%s.csv',Horizon{H},season{Y});
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T(round(height(T)*80/100)+1:end,:));                
                eval(sprintf('%s.%s.%s.Targets = Target(:,indx:end);',season{Y},mode{M},Horizon{H}));                
            else
                path5 = strcat('\test_targetdata_',Horizon{H},mode{M},'_',model{k},ind{O},'_',season{Y},'.csv');            
                fprintf(' *Importing targets..');
                if ~exist(path5)
                    path5 = strrep(path5,'VOL','ICE');
                end
                T = readtable(path5);
                Target = table2array(T);
                eval(sprintf('%s.%s.%s.Targets = Target(:,:);',season{Y},mode{M},Horizon{H}));                
            end
            eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{M},Horizon{H},season{Y},mode{M},Horizon{H}));
            clear dataTarget tempsum Target X
            fprintf('finished!\n')
        end
    end
end


clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T path5


fprintf('Finished!\n')

%% then, compute performance per metric for all season
%METRICS ARE: RMSE, MAPE, FS, CV
clc
clear Results
IMF_names = {'EMDIMF4'};%'noVMD','EMDIMF4','IMF31'
season={'FallWinter','SpringSummer'};%
mode = {'VolTime'};
metric = {'RMSE','MAPE','CV','FS'};
model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};%
Horizon = {'VOLF7d_', 'VOLF1m_'};%

for j=1:length(season)
    fprintf('%s:\n',season{j});
    for M=1:length(mode)%which mode
        fprintf(' -Mode %s:\n',mode{M});
        for H=1:length(Horizon)
            fprintf(' -%s:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
            for i=1:length(IMF_names)
                fprintf('  *%s:\n',IMF_names{i});
                eval(sprintf('y_test = (%s.%s.%s.Targets);',season{j},mode{M},Horizon{H}))
                ymean = mean(mean(y_test));
                for k=1:length(model)
                    eval(sprintf('y_preds = table2array(%s.%s.%s.(IMF_names{i}).Preds_%s);',season{j},mode{M},Horizon{H},model{k}))
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
                    %         Results.(season{j}).(Horizon{H}).(IMF_names{i}).(model{k}).FS = (1-(Results.(season{j}).(IMF_names{i}).ResNet.RMSE/RMSE_histMean).^2)*100;
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
                    fprintf('  **%s: %.2f,%.2f,%.2f\n',strcat(model{k}),Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).RMSE,Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).MAPE,Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).CV)
                end
            end
        end
    end
end
fprintf('*******************************\n') %Modes are split because Time is not decomposed, only thickTime is!
mode = {'Time'};
for j=1:length(season)
    fprintf('%s:\n',season{j});
    for M=1:length(mode)%which mode
        fprintf(' -Mode %s:\n',mode{M});
        for H=1:length(Horizon)
            fprintf(' -%s:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
            for i=1:1
                fprintf('  *%s:\n',IMF_names{i});
                eval(sprintf('y_test = (%s.%s.%s.Targets);',season{j},mode{M},Horizon{H}))
                ymean = mean(mean(y_test));
                for k=1:length(model)
                    eval(sprintf('y_preds = table2array(%s.%s.%s.(IMF_names{i}).Preds_%s);',season{j},mode{M},Horizon{H},model{k}))
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
                    %         Results.(season{j}).(Horizon{H}).(IMF_names{i}).(model{k}).FS = (1-(Results.(season{j}).(IMF_names{i}).ResNet.RMSE/RMSE_histMean).^2)*100;
                    Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
                    fprintf('  **%s: %.2f,%.2f,%.2f\n',strcat(model{k}),Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).RMSE,Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).MAPE,Results.(season{j}).(mode{M}).(Horizon{H}).(IMF_names{i}).(model{k}).CV)
                end
            end
        end
    end
end


%% General performance predicted against actual consumption
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2'))
clc

% VOLNESS 1month
IMF_names = {'noVMD'};
season={'FallWinter','SpringSummer'};
mode = {'Time', 'VolTime', 'EMDIMF4', 'IMF31'};
metric = {'RMSE','MAPE','CV'};%,'FS'
model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};
Horizon = {'VOLF1m_'};%'VOLF7d_'
indx = {'31'};
lgds = {'Time','$V$ + Time', '$V^{EMD}$ + Time', '$V^{VMD,31}$ + Time'};
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
for J = 1:length(IMF_names)
    for k=1:length(season)
        fprintf('%s:\n',season{k});
        for H=1:length(Horizon)
            fprintf(' -%s: ...',strrep(strrep(Horizon{H},'_',''),'TF',''));
            size1=23;
            % Create figure
            figure1 = figure('WindowState','maximized');
            t = tiledlayout(4,4,'TileSpacing','tight','Padding','tight');%3,4
            nexttile([4 3]);
            path5 = sprintf('%sTSsequences_%s.csv',Horizon{H},season{k});
            fprintf(' *Importing targets..');
            if ~exist(path5)
                path5 = strrep(path5,'VOL','ICE');
            end
            T = readtable(path5);
            TS_test_set = table2array(T(round(height(T)*80/100)+1:end,:));
            % % Create axes
            % axes1 = axes('Parent',figure1,'Units','Normalize','Position',[0.05 0.0847457627118644 0.939583333333333 0.897308075772681]);
            % Create multiple lines using matrix input to plot
            eval(sprintf('plt = plot(TS_test_set(1,%s:end), (%s.%s.%s.Targets(1,:)),''Marker'',''o'',''MarkerFaceColor'',''w'',''MarkerSize'',10,''LineWidth'',3.5,''Parent'',gca,''DisplayName'',''Actual'',''Color'',[0 0.4470 0.7410]);',indx{H},season{k},mode{1},Horizon{H}))
            box(gca,'on');
            hold on,
            for S = 1:2%length(mode)
                eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{S},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(S,:))',indx{H},season{k},mode{S},Horizon{H},IMF_names{J},lgds{S})) %''Color'',[0.8500 0.3250 0.0980]
            end
            eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{3},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(3,:))',indx{H},season{k},mode{2},Horizon{H},mode{3},lgds{3}))
            eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{4},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2.5,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(4,:))',indx{H},season{k},mode{2},Horizon{H},mode{4},lgds{4}))
            legend1 = legend(gca,'show');
            set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
            set(gca,'FontSize',size1,'TickLabelInterpreter','latex');%,'Ylim',[0 500]); just in the case of Household 3
            xlabel('Time','interpreter','latex','FontSize',size1);
            ylabel('Volume ($km^3$)','interpreter','latex','FontSize',size1);
            eval(sprintf('set(gca,''Box'',''on'',''FontSize'',size1,''TickLabelInterpreter'',''latex'',''LineWidth'',0.5,''YMinorGrid'',''on'',''YMinorTick'',''on'',''TickDir'',''in'',''TickLength'',[0.005 0.005]);'))%,''YLim'',[0 max(max(table2array(%s.%s.Targets(k,:))))+(max(max(table2array(%s.%s.Targets(k,:))))*5/100)]',season{k},Horizon{H},season{k},Horizon{H}))
            for S = 1:2%length(mode)
                eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{S},Horizon{H},IMF_names{J}))
                nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{S},''MarkerEdgeColor'',clr(S,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(S,:),''LineWidth'',2);'))
                ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
                %                 title(lgds{S},'FontSize',15,'Interpreter','latex')
                set(gca,'FontSize',15,'TickLabelInterpreter','latex');
            end
            eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{2},Horizon{H},mode{3}))
            nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{3},''MarkerEdgeColor'',clr(3,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(3,:),''LineWidth'',2);'))
            ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
            %                 title(lgds{3},'FontSize',15,'Interpreter','latex')
            set(gca,'FontSize',15,'TickLabelInterpreter','latex');
            %
            eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{2},Horizon{H},mode{4}))
            nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{4},''MarkerEdgeColor'',clr(4,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(4,:),''LineWidth'',2);'))
            ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
            xlabel('Horizon','Interpreter','latex','FontSize',15)
            %                 title(lgds{3},'FontSize',15,'Interpreter','latex')
            set(gca,'FontSize',15,'TickLabelInterpreter','latex');            
        end
        %then EXPORT
        exportgraphics(t,string(strcat('GeneralPerformance_allModes_LSTMPlus_',Horizon{H},season{k},'.pdf')),'ContentType','vector')
        fprintf(' done!\n')
        exportgraphics(t,string(strcat('GeneralPerformance_allModes_LSTMPlus_',Horizon{H},season{k},'.pdf')),'ContentType','vector')
        close(gcf)
    end
end


% VOLNESS 7days
IMF_names = {'noVMD'};
season={'FallWinter','SpringSummer'};
mode = {'Time', 'VolTime', 'EMDIMF4', 'IMF31'};
metric = {'RMSE','MAPE','CV'};%,'FS'
model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};
Horizon = {'VOLF7d_'};%''
indx = {'31'};
lgds = {'Time','$V$ + Time', '$V^{EMD}$ + Time', '$V^{VMD,31}$ + Time'};
smbls = {'v','^','s','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4660 0.6740 0.1880; 0.4940 0.1840 0.5560];
for J = 1:length(IMF_names)
    for k=1:length(season)
        fprintf('%s:\n',season{k});
        for H=1:length(Horizon)
            fprintf(' -%s: ...',strrep(strrep(Horizon{H},'_',''),'TF',''));
            size1=23;
            % Create figure
            figure1 = figure('WindowState','maximized');
            t = tiledlayout(4,4,'TileSpacing','tight','Padding','tight');%3,4
            nexttile([4 3]);
            path5 = sprintf('%sTSsequences_%s.csv',Horizon{H},season{k});
            fprintf(' *Importing targets..');
            if ~exist(path5)
                path5 = strrep(path5,'VOL','ICE');
            end
            T = readtable(path5);
            TS_test_set = table2array(T(round(height(T)*80/100)+1:end,:));
            % % Create axes
            % axes1 = axes('Parent',figure1,'Units','Normalize','Position',[0.05 0.0847457627118644 0.939583333333333 0.897308075772681]);
            % Create multiple lines using matrix input to plot
            eval(sprintf('plt = plot(TS_test_set(1,%s:end), (%s.%s.%s.Targets(1,:)),''Marker'',''o'',''MarkerFaceColor'',''w'',''MarkerSize'',10,''LineWidth'',3.5,''Parent'',gca,''DisplayName'',''Actual'',''Color'',[0 0.4470 0.7410]);',indx{H},season{k},mode{1},Horizon{H}))
            box(gca,'on');
            hold on,
            for S = 1:2%length(mode)
                eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{S},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(S,:))',indx{H},season{k},mode{S},Horizon{H},IMF_names{J},lgds{S})) %''Color'',[0.8500 0.3250 0.0980]
            end
            eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{3},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(3,:))',indx{H},season{k},mode{2},Horizon{H},mode{3},lgds{3}))
            eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{4},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2.5,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(4,:))',indx{H},season{k},mode{2},Horizon{H},mode{4},lgds{4}))
            legend1 = legend(gca,'show');
            set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
            set(gca,'FontSize',size1,'TickLabelInterpreter','latex');%,'Ylim',[0 500]); just in the case of Household 3
            xlabel('Time','interpreter','latex','FontSize',size1);
            ylabel('Volume ($km^3$)','interpreter','latex','FontSize',size1);
            eval(sprintf('set(gca,''Box'',''on'',''FontSize'',size1,''TickLabelInterpreter'',''latex'',''LineWidth'',0.5,''YMinorGrid'',''on'',''YMinorTick'',''on'',''TickDir'',''in'',''TickLength'',[0.005 0.005]);'))%,''YLim'',[0 max(max(table2array(%s.%s.Targets(k,:))))+(max(max(table2array(%s.%s.Targets(k,:))))*5/100)]',season{k},Horizon{H},season{k},Horizon{H}))
            for S = 1:2%length(mode)
                eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{S},Horizon{H},IMF_names{J}))
                nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{S},''MarkerEdgeColor'',clr(S,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(S,:),''LineWidth'',2);'))
                ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
                %                 title(lgds{S},'FontSize',15,'Interpreter','latex')
                set(gca,'FontSize',15,'TickLabelInterpreter','latex');
            end
            eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{2},Horizon{H},mode{3}))
            nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{3},''MarkerEdgeColor'',clr(3,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(3,:),''LineWidth'',2);'))
            ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
            %                 title(lgds{3},'FontSize',15,'Interpreter','latex')
            set(gca,'FontSize',15,'TickLabelInterpreter','latex');
            %
            eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{2},Horizon{H},mode{4}))
            nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{4},''MarkerEdgeColor'',clr(4,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(4,:),''LineWidth'',2);'))
            ylabel('Error ($km^3$)','Interpreter','latex','FontSize',15)
            xlabel('Horizon','Interpreter','latex','FontSize',15)
            %                 title(lgds{3},'FontSize',15,'Interpreter','latex')
            set(gca,'FontSize',15,'TickLabelInterpreter','latex');            
        end
        %then EXPORT
        exportgraphics(t,string(strcat('GeneralPerformance_allModes_LSTMPlus_',Horizon{H},season{k},'.pdf')),'ContentType','vector')
        fprintf(' done!\n')
        exportgraphics(t,string(strcat('GeneralPerformance_allModes_LSTMPlus_',Horizon{H},season{k},'.pdf')),'ContentType','vector')
        close(gcf)
    end
end

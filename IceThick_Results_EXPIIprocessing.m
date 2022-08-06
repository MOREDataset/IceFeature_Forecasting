%% Read preds and target of VMD-empowered models
% %Always change the mode number and which IMFs to use before running the rest of this section..
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2\EXPII'))
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2'))
clear
clc
season = {'SpringSummer','FallWinter'};
mode = {'ThickTime'}; model = {'LSTMPlus'};%};
ind = {''}; O=1; %O to refer to which element from ind
IMFS={'7IMFs','15IMFs','23IMFs','29IMFs','31IMFs', '33IMFs','35IMFs','39IMFs','47IMFs','55IMFs','63IMFs','71IMFs','79IMFs'};%
Horizon = {'THICKF7d_','THICKF1m_'};%
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
%                 eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
                clear data tempsum
                fprintf('finished!\n')
            else
                eval(sprintf('%s.%s.%s.%s.Preds_%s = X;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
%                 eval(sprintf('%s.%s.%s.%s.Preds_%s.Variables = %s.%s.%s.%s.Preds_%s.Variables*1000;',season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:},season{Y},mode{:},Horizon{H},string(strcat('IMF',regexp(IMFS{L},'\d*','match'))),model{:}))
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
%             eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));

            end
            fprintf('finished!\n')

        else
            eval(sprintf('%s.%s.%s.Targets = X;',season{Y},mode{:},Horizon{H}));
%             eval(sprintf('%s.%s.%s.Targets = %s.%s.%s.Targets*1000;',season{Y},mode{:},Horizon{H},season{Y},mode{:},Horizon{H}));
            fprintf('finished!\n')

        end
    end
end

clear path4 path3 path2 opts model_name model M L k j IMFS i mode Horizon H fld col Y indx O ind season T Horizon2 path5 X tempsum data

fprintf('Finished!\n')

%% then, plot performance per metric for all season
%METRICS ARE: RMSE, MAPE, FS, CV
clc
clear Results
IMF_names = {'IMF7', 'IMF15','IMF23','IMF29','IMF31','IMF33','IMF35','IMF39','IMF47','IMF55','IMF63','IMF71','IMF79'};%
season={'FallWinter','SpringSummer'};%
mode = {'ThickTime'};
metric = {'RMSE','MAPE','CV','FS'};
model = {'LSTMPlus'};%
Horizon = {'THICKF7d_', 'THICKF1m_'};%

for j=1:length(season)
    fprintf('%s:\n',season{j});
    fprintf(' -Mode %s:\n',mode{:});
    for H=1:length(Horizon)
        fprintf(' -%s:\n',strrep(strrep(Horizon{H},'_',''),'TF',''));
        for i=1:length(IMF_names)
            eval(sprintf('y_test = (%s.%s.%s.Targets);',season{j},mode{:},Horizon{H}))
            ymean = mean(mean(y_test));
            eval(sprintf('y_preds = table2array(%s.%s.%s.(IMF_names{i}).Preds_%s);',season{j},mode{:},Horizon{H},model{:}))
            Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).MAPE = mean(mean(abs((y_test-y_preds)./y_test)))*100;
            Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).RMSE = sqrt(mean(mean((y_test-y_preds).^2)));
            %         Results.(season{j}).(Horizon{H}).(IMF_names{i}).(model{:}).FS = (1-(Results.(season{j}).(IMF_names{i}).ResNet.RMSE/RMSE_histMean).^2)*100;
            Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).CV = sqrt((1/size(y_test,2))*sum(mean(abs(y_test-y_preds).^2)))/ymean*100;
            fprintf('%d, %.3f,%.3f,%.3f\n',str2num(strrep(IMF_names{i},'IMF',''))+1, Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).RMSE,Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).MAPE,Results.(season{j}).(mode{:}).(Horizon{H}).(IMF_names{i}).(model{:}).CV)
        end
    end
fprintf('\n')
end

%% General performance predicted against actual consumption
addpath(genpath('C:\Users\PC GAMER\Desktop\aymane\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2'))
clc

% THICKNESS
IMF_names = {'noVMD'};
season={'FallWinter','SpringSummer'};
mode = {'Time', 'ThickTime', 'IMF31'};
metric = {'RMSE','MAPE','CV'};%,'FS'
model = {'TSTPlus','InceptionTimePlus','LSTMPlus'};
Horizon = {'THICKF1m_'};%
indx = {'31'};
lgds = {'Time','$T_{ICE}$ + Time', '$T_{ICE}^{VMD}$ + Time'};
smbls = {'v','^','d'};
clr = [0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4940 0.1840 0.5560];
for J = 1:length(IMF_names)
    for k=1:length(season)
        fprintf('%s:\n',season{k});
        for H=1:length(Horizon)
            fprintf(' -%s: ...',strrep(strrep(Horizon{H},'_',''),'TF',''));
            size1=23;
            % Create figure
            figure1 = figure('WindowState','maximized');
            t = tiledlayout(3,4,'TileSpacing','tight','Padding','tight');%3,4
            nexttile([3 3]);
            path5 = sprintf('%sTSsequences_%s.csv',Horizon{H},season{k});
            fprintf(' *Importing targets..');
            if ~exist(path5)
                path5 = strrep(path5,'THICK','ICE');
            end
            T = readtable(path5);
            TS_test_set = table2array(T(round(height(T)*80/100)+1:end,:));
            % % Create axes
            % axes1 = axes('Parent',figure1,'Units','Normalize','Position',[0.05 0.0847457627118644 0.939583333333333 0.897308075772681]);
            % Create multiple lines using matrix input to plot
            eval(sprintf('plt = plot(TS_test_set(1,%s:end), (%s.%s.%s.Targets(1,:)),''Marker'',''o'',''MarkerFaceColor'',''w'',''MarkerSize'',10,''LineWidth'',3.5,''Parent'',gca,''DisplayName'',''Actual'',''Color'',[0 0.4470 0.7410]);',indx{H},season{k},mode{1},Horizon{H}))
            box(gca,'on');
            hold on,
            for S = 1:2%length(mode{:})
                eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{S},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(S,:))',indx{H},season{k},mode{S},Horizon{H},IMF_names{J},lgds{S})) %''Color'',[0.8500 0.3250 0.0980]
            end
            eval(sprintf('plot(TS_test_set(1,%s:end), table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:)),''Marker'',smbls{3},''MarkerSize'',10,''MarkerFaceColor'',''w'',''LineWidth'',2,''Parent'',gca,''DisplayName'',''%s'',''LineStyle'','':'',''Color'',clr(3,:))',indx{H},season{k},mode{2},Horizon{H},mode{3},lgds{3}))
            legend1 = legend(gca,'show');
            set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
            set(gca,'FontSize',size1,'TickLabelInterpreter','latex');%,'Ylim',[0 500]); just in the case of Household 3
            xlabel('Time','interpreter','latex','FontSize',size1);
            ylabel('Amplitude (W/$m^2$)','interpreter','latex','FontSize',size1);
            eval(sprintf('set(gca,''Box'',''on'',''FontSize'',size1,''TickLabelInterpreter'',''latex'',''LineWidth'',0.5,''YMinorGrid'',''on'',''YMinorTick'',''on'',''TickDir'',''in'',''TickLength'',[0.005 0.005]);'))%,''YLim'',[0 max(max(table2array(%s.%s.Targets(k,:))))+(max(max(table2array(%s.%s.Targets(k,:))))*5/100)]',season{k},Horizon{H},season{k},Horizon{H}))
            for S = 1:2%length(mode{:})
                eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{S},Horizon{H},IMF_names{J}))
                nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{S},''MarkerEdgeColor'',clr(S,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(S,:),''LineWidth'',2);'))
                ylabel('Error (W/$m^2$)','Interpreter','latex','FontSize',15)
                %                 title(lgds{S},'FontSize',15,'Interpreter','latex')
                set(gca,'FontSize',15,'TickLabelInterpreter','latex');
            end
            eval(sprintf('errors = (%s.%s.%s.Targets(1,:))-table2array(%s.%s.%s.%s.Preds_LSTMPlus(1,:));',season{k},mode{S},Horizon{H},season{k},mode{2},Horizon{H},mode{3}))
            nexttile, eval(sprintf('t1 = stem(categorical([1:length(errors)]), errors,''Marker'',smbls{3},''MarkerEdgeColor'',clr(3,:),''MarkerSize'',10,''LineStyle'','':'',''MarkerFaceColor'',''white'',''Color'',clr(3,:),''LineWidth'',2);'))
            ylabel('Error (W/$m^2$)','Interpreter','latex','FontSize',15)
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


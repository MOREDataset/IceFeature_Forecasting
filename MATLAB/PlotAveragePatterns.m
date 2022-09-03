%% read data
clear
% read ice thikness data
opts1 = detectImportOptions('PIOMAS.thick.daily.1979.2022.Current.v2.1.dat');
opts1.VariableNames{1, 2} = 'day_number';
Thick = readtable('PIOMAS.thick.daily.1979.2022.Current.v2.1.dat',opts1);

%read ice volume data
opts2 = detectImportOptions('PIOMAS.vol.daily.1979.2022.Current.v2.1.dat');
opts2.VariableNames{1, 2} = 'day_number';
Vol = readtable('PIOMAS.vol.daily.1979.2022.Current.v2.1.dat',opts2);
clear opts1 opts2 ans

%configure date column in both tables
Thick_data = timetable(datetime(datevec(datenum(Thick.Year,1,Thick.day_number)),'Format','uuuu-MM-dd'), Thick.Thickness,'VariableNames',{'Thickness'});
Vol_data = timetable(datetime(datevec(datenum(Vol.Year,1,Vol.day_number)),'Format','uuuu-MM-dd'), Vol.Vol,'VariableNames',{'Volume'});
data_temp = [Thick_data Vol_data];
clear Thick Vol Thick_data Vol_data
clc
%% Plot data
%mean over all years
Meandata = groupsummary(data_temp,"Time","monthofyear","mean",...
    "IncludeEmptyGroups",true);
Meandata.GroupCount = [];

%mean over every month of a year
newTable = groupsummary(data_temp,"Time","month","mean","IncludeEmptyGroups",true);
newTable.GroupCount = [];

newTable.month_Time = datetime(string(newTable.month_Time));
newTable = table2timetable(newTable);

%Plot Thickness
figure('units','normalized','outerposition',[0 0 1 1])
t = tiledlayout("flow",'TileSpacing','tight','Padding','tight','units','normalized','outerposition',[0 0 1 1]);
%
% nexttile
% hold on,
% for i = 1979:2021
%     S = timerange(datetime([i,1,1]),datetime([i,12,31]));
%     temp = newTable(S,:);
%     plot(categorical(1:12),temp.mean_Thickness,'LineStyle',':','Color',[0.4470 0.4470 0.4470],'LineWidth',1.6)%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
% end
% plot(categorical(1:12),Meandata.mean_Thickness,'Marker','o','MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',10,'LineStyle','-','MarkerFaceColor',[0.8500 0.3250 0.0980]	,'Color', [0.8500 0.3250 0.0980],'LineWidth',3)
%
% xlabel('','interpreter','latex','FontSize',21);
% ylabel('Ice thickness ($m$)','interpreter','latex','FontSize',21);
% set(gca,'FontSize',21,'TickLabelInterpreter','latex','xticklabel',{'January','February','March','April','May','June','July','August','September','October','November','December'},'Ylim',[0 3])
% box("on")

%Plot Volume
nexttile,
hold on,

%
clr = [0.3010 0.7450 0.9330];
for i = 2020:2021
    S = timerange(datetime([i,1,1]),datetime([i,12,31]));
    temp = newTable(S,:);
    %     plot(categorical(1:12),temp.mean_Volume,'LineStyle',':','LineWidth',1.6)%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
    signal(:,i-2019) = temp.mean_Volume;
end
y1 = max(signal,[],2);
y2 = min(signal,[],2);
patch([categorical(1:12) fliplr(categorical(1:12))], [y1' fliplr(y2')], clr,'FaceAlpha',.6,'EdgeAlpha',.8,'LineStyle',':','Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','2020-2021');

%
clear signal
clr = [0.4660 0.6740 0.1880];
for i = 2010:2019
    S = timerange(datetime([i,1,1]),datetime([i,12,31]));
    temp = newTable(S,:);
    %     plot(categorical(1:12),temp.mean_Volume,'LineStyle',':','LineWidth',1.6)%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
    signal(:,i-2009) = temp.mean_Volume;
end
y1 = max(signal,[],2);
y2 = min(signal,[],2);
patch([categorical(1:12) fliplr(categorical(1:12))], [y1' fliplr(y2')], clr,'FaceAlpha',.6,'EdgeAlpha',.8,'LineStyle',':','Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','2010-2019')

%
clr = [0.4940 0.1840 0.5560];
clear signal
for i = 2000:2009
    S = timerange(datetime([i,1,1]),datetime([i,12,31]));
    temp = newTable(S,:);
    %     plot(categorical(1:12),temp.mean_Volume,'LineStyle',':','LineWidth',1.6)%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
    signal(:,i-1999) = temp.mean_Volume;
end
y1 = max(signal,[],2);
y2 = min(signal,[],2);
patch([categorical(1:12) fliplr(categorical(1:12))], [y1' fliplr(y2')], clr,'FaceAlpha',.6,'EdgeAlpha',.8,'LineStyle',':','Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','2000-2009')

%
clear signal
clr = [0.9290 0.6940 0.1250];
for i = 1990:1999
    S = timerange(datetime([i,1,1]),datetime([i,12,31]));
    temp = newTable(S,:);
    %     plot(categorical(1:12),temp.mean_Volume,'LineStyle',':','LineWidth',1.6)%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
    signal(:,i-1989) = temp.mean_Volume;
end
y1 = max(signal,[],2);
y2 = min(signal,[],2);
patch([categorical(1:12) fliplr(categorical(1:12))], [y1' fliplr(y2')], clr,'FaceAlpha',.6,'EdgeAlpha',.8,'LineStyle',':','Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','1990-1999')

%
clr = [0.8500 0.3250 0.0980];
for i = 1980:1989
    S = timerange(datetime([i,1,1]),datetime([i,12,31]));
    temp = newTable(S,:);
    %     plot(categorical(1:12),temp.mean_Volume,'LineStyle',':','LineWidth',1.6,'Color',[0.4470 0.4470 0.4470 .9])%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',
    signal(:,i-1979) = temp.mean_Volume;
end
y1 = max(signal,[],2);
y2 = min(signal,[],2);
patch([categorical(1:12) fliplr(categorical(1:12))], [y1' fliplr(y2')], clr,'FaceAlpha',.6,'EdgeAlpha',.8,'LineStyle',':','Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','1980-1989')

%
clear signal
clr = [0 0.4470 0.7410];
S = timerange(datetime([1979,1,1]),datetime([1979,12,31]));
plot(categorical(1:12),temp.mean_Volume,'Color',clr,'LineStyle','-','LineWidth',2,'Marker','o','MarkerEdgeColor',clr,'MarkerSize',5,'MarkerFaceColor',clr,'DisplayName','1979')%'Marker','o','MarkerEdgeColor',[0.4470 0.4470 0.4470],'MarkerSize',7,'MarkerFaceColor','white',

%
plot(categorical(1:12),Meandata.mean_Volume,'Marker','o','MarkerEdgeColor',[1 1 1],'MarkerSize',10,'LineStyle','-','MarkerFaceColor', [0 0 0],'Color', [0 0 0],'LineWidth',3,'DisplayName','Average')

xlabel('Months of year','interpreter','latex','FontSize',21);
ylabel('Arctic sea ice volume ($10^3km^3$)','interpreter','latex','FontSize',21);
set(gca,'FontSize',21,'TickLabelInterpreter','latex','xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
set(gca,'YGrid','on','YMinorGrid','on')
box("on")
legend(gca,'show');

exportgraphics(t,'AverageMonthlyPatterns_decades.pdf','ContentType','vector')
sprintf('Finito!')
exportgraphics(t,'AverageMonthlyPatterns_decades.pdf','ContentType','vector')
close(gcf)

%% BoxPlot - per Month
[~, mon, ~] = ymd(data_temp.Time);
Jan = data_temp(mon == 1, :);
Feb = data_temp(mon == 2, :);
Mar = data_temp(mon == 3, :);
Apr = data_temp(mon == 4, :);
May = data_temp(mon == 5, :);
Jun = data_temp(mon == 6, :);
Jul = data_temp(mon == 7, :);
Aug = data_temp(mon == 8, :);
Sep = data_temp(mon == 9, :);
Oct = data_temp(mon == 10, :);
Nov = data_temp(mon == 11, :);
Dec = data_temp(mon == 12, :);

G = [ones(size(Jan.Volume));2*ones(size(Feb.Volume));3*ones(size(Mar.Volume));4*ones(size(Apr.Volume));5*ones(size(May.Volume));6*ones(size(Jun.Volume));7*ones(size(Jul.Volume));8*ones(size(Aug.Volume));9*ones(size(Sep.Volume));10*ones(size(Oct.Volume));11*ones(size(Nov.Volume));12*ones(size(Dec.Volume))];

figure('units','normalized','outerposition',[0 0 1 1])
boxplot([Jan.Volume;Feb.Volume;Mar.Volume;Apr.Volume;May.Volume;Jun.Volume;Jul.Volume;Aug.Volume;Sep.Volume;Oct.Volume;Nov.Volume;Dec.Volume], G,'Labels',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},'PlotStyle','traditional')
xlabel('Months of year','interpreter','latex','FontSize',30);
ylabel('Arctic sea ice volume ($10^3km^3$)','interpreter','latex','FontSize',30);
set(gca,'FontSize',30,'TickLabelInterpreter','latex','YGrid','on','YMinorGrid','on')
box("on")
InSet = get(gca, 'TightInset');
set(gca, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)-0.005])

exportgraphics(gcf,'AverageMonthlyPatterns.pdf','ContentType','vector')
sprintf('Finito!')
exportgraphics(gcf,'AverageMonthlyPatterns.pdf','ContentType','vector')
close(gcf)
%%find color using this: cmap = get(0, 'defaultaxescolororder');

%% BoxPlot - per day
clear D G d
clc
[~, ~, d] = ymd(data_temp.Time);
D = [];
G = [];
for i = 1:31
    eval(sprintf('D = [D;data_temp.Volume(d == %d)];',i))
    eval(sprintf('G = [G;%d*ones(size(data_temp.Volume(d == %d)))];',i,i))
end

figure('units','normalized','outerposition',[0 0 1 1],'WindowState','fullscreen')
boxplot(D, G,'PlotStyle','traditional')
xlabel('Days of month','interpreter','latex','FontSize',30);
ylabel('Arctic sea ice volume ($10^3km^3$)','interpreter','latex','FontSize',30);
set(gca,'FontSize',30,'TickLabelInterpreter','latex','YGrid','on','YMinorGrid','on')
box("on")
InSet = get(gca, 'TightInset');
set(gca, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)-0.005])


exportgraphics(gcf,'AverageDailyPatterns.pdf','ContentType','vector')
sprintf('Finito!')
exportgraphics(gcf,'AverageDailyPatterns.pdf','ContentType','vector')
close(gcf)

%% min and max of yearly volume
clear y
clc
[y, ~, ~] = ymd(data_temp.Time);
Y = [];
G = [];
for i = 1979:2021
    eval(sprintf('Y = [Y;mean(data_temp.Volume(y == %d))];',i))
end
[v_min,i_min] = min(Y);
[v_max,i_max] = max(Y);
fprintf('Min : %.3f happened in %d!\n',v_min,i_min+1978);
fprintf('Max : %.3f happened in %d!\n',v_max,i_max+1978);

%% correlation for next 7days
clear
clc
hrz = 7;
LEN = 7:7:7*12; %3months
LEN = LEN + hrz;
for i = 1:length(LEN)
    [TS_FallWinter, TS_SpringSummer, ~, ~, Vol_FallWinter, Vol_SpringSummer] = ThickVol_ForecastData_preprocessing(LEN(i));
    %extract time information variables
    [y_FallWinter, m_FallWinter, d_FallWinter] = ymd(TS_FallWinter);
    [y_SpringSummer, m_SpringSummer, d_SpringSummer] = ymd(TS_SpringSummer);
    %compute correlation
    %- Volume
    eval(sprintf('CorrResults.Shortterm.rho_FallWinter_%d = corr(Vol_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Shortterm.rho_SpringSummer_%d = corr(Vol_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    %- Year
    eval(sprintf('CorrResults.Shortterm.rho_FallWinter_Y_%d = corr(y_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Shortterm.rho_SpringSummer_Y_%d = corr(y_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
    %- Month
    eval(sprintf('CorrResults.Shortterm.rho_FallWinter_M_%d = corr(m_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Shortterm.rho_SpringSummer_M_%d = corr(m_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
    %- Day of month
    eval(sprintf('CorrResults.Shortterm.rho_FallWinter_D_%d = corr(d_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Shortterm.rho_SpringSummer_D_%d = corr(d_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
end

% correlation for next 30days
hrz = 30;
LEN = 7:7:7*12;
LEN = LEN + hrz;
for i = 1:length(LEN)
    [TS_FallWinter, TS_SpringSummer, ~, ~, Vol_FallWinter, Vol_SpringSummer] = ThickVol_ForecastData_preprocessing(LEN(i));

    %extract time information variables
    [y_FallWinter, m_FallWinter, d_FallWinter] = ymd(TS_FallWinter);
    [y_SpringSummer, m_SpringSummer, d_SpringSummer] = ymd(TS_SpringSummer);
    %compute correlation
    %- Volume
    eval(sprintf('CorrResults.Midterm.rho_FallWinter_%d = corr(Vol_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Midterm.rho_SpringSummer_%d = corr(Vol_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    %- Year
    eval(sprintf('CorrResults.Midterm.rho_FallWinter_Y_%d = corr(y_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Midterm.rho_SpringSummer_Y_%d = corr(y_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
    %- Month
    eval(sprintf('CorrResults.Midterm.rho_FallWinter_M_%d = corr(m_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Midterm.rho_SpringSummer_M_%d = corr(m_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
    %- Day of month
    eval(sprintf('CorrResults.Midterm.rho_FallWinter_D_%d = corr(d_FallWinter(:,1:%d),Vol_FallWinter(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))
    eval(sprintf('CorrResults.Midterm.rho_SpringSummer_D_%d = corr(d_SpringSummer(:,1:%d),Vol_SpringSummer(:,%d+1:end));',LEN(i)-hrz,LEN(i)-hrz,LEN(i)-hrz))    
end

clear y_SpringSummer d_FallWinter d_SpringSummer hrz i LEN m_FallWinter m_SpringSummer RHO_FallWinter RHO_SpringSummer size1 smbls TS_FallWinter TS_SpringSummer Vol_FallWinter Vol_SpringSummer y_FallWinter ans
%% Plot correlations -short-term
hrz = 7;
LEN = 7:7:7*12;
LEN = LEN + hrz;
cmap = get(0, 'defaultaxescolororder');
indx = {'','_Y','_M','_D'};
smbls = {'o', 'v','^','d'};
size1 = 30;

% Plot average correlation over all horizons for diff. input lengths
% 
% for i = 1:length(indx)
% eval(strcat('RHO_FallWinter',indx{i},' = [];'))
% eval(strcat('RHO_SpringSummer',indx{i},' = [];'))
% end
% 
% for i = 1:length(LEN)
%     %- Volume
%     eval(sprintf('RHO_FallWinter = [RHO_FallWinter, mean(mean(CorrResults.Shortterm.rho_FallWinter_%d))];',LEN(i)-hrz))
%     eval(sprintf('RHO_SpringSummer = [RHO_SpringSummer, mean(mean(CorrResults.Shortterm.rho_SpringSummer_%d))];',LEN(i)-hrz))
%     %- Year
%     eval(sprintf('RHO_FallWinter_Y = [RHO_FallWinter_Y, mean(mean(CorrResults.Shortterm.rho_FallWinter_Y_%d))];',LEN(i)-hrz))
%     eval(sprintf('RHO_SpringSummer_Y = [RHO_SpringSummer_Y, mean(mean(CorrResults.Shortterm.rho_SpringSummer_Y_%d))];',LEN(i)-hrz))
%     %- Month
%     eval(sprintf('RHO_FallWinter_M = [RHO_FallWinter_M, mean(mean(CorrResults.Shortterm.rho_FallWinter_M_%d))];',LEN(i)-hrz))
%     eval(sprintf('RHO_SpringSummer_M = [RHO_SpringSummer_M, mean(mean(CorrResults.Shortterm.rho_SpringSummer_M_%d))];',LEN(i)-hrz))
%     %- Day of month
%     eval(sprintf('RHO_FallWinter_D = [RHO_FallWinter_D, mean(mean(CorrResults.Shortterm.rho_FallWinter_D_%d))];',LEN(i)-hrz))
%     eval(sprintf('RHO_SpringSummer_D = [RHO_SpringSummer_D, mean(mean(CorrResults.Shortterm.rho_SpringSummer_D_%d))];',LEN(i)-hrz))
% end


figure('units','normalized','outerposition',[0 0 1 1])
t = tiledlayout("flow",'TileSpacing','tight','Padding','tight','units','normalized','outerposition',[0 0 1 1]);
nexttile,
hold on,
for i = 1:length(indx)
    eval(sprintf('temp = %s',strcat('RHO_FallWinter',indx{i})))
    plot(7:7:7*12,RHO_FallWinter,'DisplayName',indx{i},'Marker',smbls{i},'MarkerEdgeColor',cmap(1,:),'MarkerSize',15,'LineStyle','-','MarkerFaceColor', [1 1 1],'LineWidth',3)
    eval(sprintf('temp = %s',strcat('RHO_SpringSummer',indx{i})))
    plot(7:7:7*12,temp,'DisplayName',indx{i},'Marker',smbls{i},'MarkerEdgeColor',cmap(2,:),'MarkerSize',15,'LineStyle','-','MarkerFaceColor', [1 1 1], 'LineWidth',3)
end
xlabel('Input length','interpreter','latex','FontSize',size1);
ylabel('Spearman coefficient','interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex')
set(gca,'YGrid','on','YMinorGrid','on')
box("on")
legend1 =legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1)
% exportgraphics(t,strcat('CORR_',hrz,'d_Volume.pdf'),'ContentType','vector')
% fprintf('Done!\n')
% exportgraphics(t,strcat('CORR_',hrz,'d_Volume.pdf'),'ContentType','vector')
% close(gcf)


%% Plot correlations -mid-term
hrz = 30;
size1 = 30;

% Plot average correlation over all horizons for diff. input lengths
RHO_FallWinter = [];
RHO_SpringSummer = [];
for i = 1:length(LEN)
    eval(sprintf('RHO_FallWinter = [RHO_FallWinter, mean(mean(rho_FallWinter_%d))];',LEN(i)-hrz))
    eval(sprintf('RHO_SpringSummer = [RHO_SpringSummer, mean(mean(rho_SpringSummer_%d))];',LEN(i)-hrz))
end

cmap = get(0, 'defaultaxescolororder');
figure('units','normalized','outerposition',[0 0 1 1])
t = tiledlayout("flow",'TileSpacing','tight','Padding','tight','units','normalized','outerposition',[0 0 1 1]);
nexttile,
hold on,
plot(10:10:90,RHO_FallWinter,'DisplayName','Fall/Winter','Marker','o','MarkerEdgeColor',cmap(1,:),'MarkerSize',15,'LineStyle','-','MarkerFaceColor', [1 1 1],'LineWidth',3)
plot(10:10:90,RHO_SpringSummer,'DisplayName','Spring/Summer','Marker','o','MarkerEdgeColor',cmap(2,:),'MarkerSize',15,'LineStyle','-','MarkerFaceColor', [1 1 1], 'LineWidth',3)
xlabel('Input length','interpreter','latex','FontSize',size1);
ylabel('Spearman coefficient','interpreter','latex','FontSize',size1);
set(gca,'FontSize',size1,'TickLabelInterpreter','latex')
set(gca,'YGrid','on','YMinorGrid','on')
box("on")
legend1 =legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1)
exportgraphics(t,strcat('CORR_',hrz,'d_Volume.pdf'),'ContentType','vector')
fprintf('Done!\n')
exportgraphics(t,strcat('CORR_',hrz,'d_Volume.pdf'),'ContentType','vector')
close(gcf)

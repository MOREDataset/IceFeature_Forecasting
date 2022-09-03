function [TS_FallWinter, TS_SpringSummer, Thick_FallWinter, Thick_SpringSummer, Vol_FallWinter, Vol_SpringSummer] = ThickVol_ForecastData_preprocessing_4stationary(len)
%% read data 
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
data_temp = [Thick_data Vol_data];%
clear Thick Vol Thick_data Vol_data

%% Divide into two seasons of the year: 22March-21September : spring/summer | 22September-21March fall/winter
[~, mm, dd] = ymd(data_temp.Time);
%*spring summer
mask = ismember(mm, [3:9]);
data_temp_SpringSummer = data_temp(mask,:);
infmt = 'yyyy-MM-dd';
for i = year(data_temp.Time(1)):year(data_temp.Time(end))
    eval(sprintf('S = timerange(datetime(''%d-03-01'',''InputFormat'',infmt),datetime(''%d-03-21'',''InputFormat'',infmt),''closed'');',i,i));
    data_temp_SpringSummer(S,:)=[];
end

%*fall winter
mask = ismember(mm, [9 10 11 12 1 2 3]);
data_temp_FallWinter = data_temp(mask,:);
for i = year(data_temp.Time(1)):year(data_temp.Time(end))
    eval(sprintf('S = timerange(datetime(''%d-09-22'',''InputFormat'',infmt),datetime(''%d-09-30'',''InputFormat'',infmt),''closed'');',i,i));
    data_temp_FallWinter(S,:)=[];
end
clear S mm mask infmt i dd
% 
% % plot data to shocase difference between seasons
% figure('units','normalized','outerposition',[0 0 1 1])
% t = tiledlayout(2,1,'TileSpacing','tight','Padding','tight','units','normalized','outerposition',[0 0 1 1]);
% 
% nexttile
% scatter(data_temp_FallWinter.Time,data_temp_FallWinter.Thickness,'DisplayName','FallWinter')
% hold on
% scatter(data_temp_SpringSummer.Time,data_temp_SpringSummer.Thickness,'DisplayName','SpringSummer')
% legend1 = legend(gca,'show');
% set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',21);
% set(gca,'FontSize',21,'TickLabelInterpreter','latex');%,'Ylim',[0 500]); just in the case of Household 3
% xlabel('','interpreter','latex','FontSize',21);
% ylabel('Ice thickness ($m$)','interpreter','latex','FontSize',21);
% box("on")
% 
% nexttile
% scatter(data_temp_FallWinter.Time,data_temp_FallWinter.Volume,'DisplayName','FallWinter')
% hold on
% scatter(data_temp_SpringSummer.Time,data_temp_SpringSummer.Volume,'DisplayName','SpringSummer');hold off;
% % legend1 = legend(gca,'show');
% % set(legend1,'Orientation','horizontal','Location','northeast','Interpreter','latex','FontSize',21);
% set(gca,'FontSize',21,'TickLabelInterpreter','latex');%,'Ylim',[0 500]); just in the case of Household 3
% xlabel('Time','interpreter','latex','FontSize',21);
% ylabel('Ice volume ($10^3km^3$)','interpreter','latex','FontSize',21);
% box("on")
% exportgraphics(t,'FallWinterVSSpringSummer_plots_IceThickVol.pdf')
% close(gcf)
% clear t legend1 data_temp

%% Compute stats
% clc
% % -Day
% fprintf('Daily: \n')
% % --FallWinter
% newTable = groupsummary(data_temp_FallWinter,"Time","day",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - FallWinter: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - FallWinter: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % --SpringSummer
% newTable = groupsummary(data_temp_SpringSummer,"Time","day",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - SpringSummer: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - SpringSummer: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % -Week
% fprintf('Weekly: \n')
% % --FallWinter
% newTable = groupsummary(data_temp_FallWinter,"Time","week",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - FallWinter: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - FallWinter: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % --SpringSummer
% newTable = groupsummary(data_temp_SpringSummer,"Time","week",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - SpringSummer: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - SpringSummer: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % -Month
% fprintf('Monthly: \n')
% % --FallWinter
% newTable = groupsummary(data_temp_FallWinter,"Time","month",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - FallWinter: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - FallWinter: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % --SpringSummer
% newTable = groupsummary(data_temp_SpringSummer,"Time","month",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - SpringSummer: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - SpringSummer: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % -Year
% fprintf('Yearly: \n')
% % --FallWinter
% newTable = groupsummary(data_temp_FallWinter,"Time","year",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - FallWinter: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - FallWinter: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))
% % --SpringSummer
% newTable = groupsummary(data_temp_SpringSummer,"Time","year",["mean"]);
% newTable.GroupCount = [];
% fprintf('Thickness - SpringSummer: %.3g, [%.3g-%.3g]\n',mean(newTable.mean_Thickness),min(newTable.mean_Thickness),max(newTable.mean_Thickness))
% fprintf('Volume - SpringSummer: %.7g, [%.7g-%.7g]\n',mean(newTable.mean_Volume),min(newTable.mean_Volume),max(newTable.mean_Volume))

%% split and export data
fprintf('\n*SpringSummer Data splitting started..');
Thick_SpringSummer = zeros(length(1 : len: length(data_temp_SpringSummer.Thickness)-len+1), len);
Vol_SpringSummer = zeros(length(1 : len: length(data_temp_SpringSummer.Volume)-len+1), len);
TS_SpringSummer = NaT(length(1 : len: length(data_temp_SpringSummer.Thickness)-len+1), len);

for i = 1 : len: length(data_temp_SpringSummer.Volume)-len+1
    Thick_SpringSummer(i,1:len) = data_temp_SpringSummer.Thickness(i:(i + len-1))';
    Vol_SpringSummer(i,1:len) = data_temp_SpringSummer.Volume(i:(i + len-1))';
    TS_SpringSummer(i,1:len) = data_temp_SpringSummer.Time(i:(i + len-1))';
end

fprintf(', cleaning data...');
dur=TS_SpringSummer(:,end)-TS_SpringSummer(:,1);
Thick_SpringSummer(dur>duration((len-1)*24,0,0),:)=[];
Vol_SpringSummer(dur>duration((len-1)*24,0,0),:)=[];
TS_SpringSummer(dur>duration((len-1)*24,0,0),:)=[];
[Thick_SpringSummer,TF] = rmmissing(Thick_SpringSummer,1);
[Vol_SpringSummer,TF] = rmmissing(Vol_SpringSummer,1);
TS_SpringSummer = TS_SpringSummer(~TF,:);
toDelete       = (sum(Vol_SpringSummer, 2) == 0);
Thick_SpringSummer(toDelete, :) = [];
Vol_SpringSummer(toDelete, :) = [];
TS_SpringSummer(toDelete, :) = [];
clear  data_temp_SpringSummer 

fprintf(', finito!\n');

fprintf('\n*FallWinter Data splitting started..');
Thick_FallWinter = zeros(length(1 : len: length(data_temp_FallWinter.Thickness)-len+1), len);
Vol_FallWinter = zeros(length(1 : len: length(data_temp_FallWinter.Thickness)-len+1), len);
TS_FallWinter = NaT(length(1 : len: length(data_temp_FallWinter.Thickness)-len+1), len);

for i = 1 : len : length(data_temp_FallWinter.Thickness)-len+1
    Thick_FallWinter(i,1:len) = data_temp_FallWinter.Thickness(i:(i + len-1))';
    Vol_FallWinter(i,1:len) = data_temp_FallWinter.Volume(i:(i + len-1))';
    TS_FallWinter(i,1:len) = data_temp_FallWinter.Time(i:(i + len-1))';
end

fprintf(', cleaning data...');
dur=TS_FallWinter(:,end)-TS_FallWinter(:,1);
Thick_FallWinter(dur>duration((len-1)*24,0,0),:)=[];
Vol_FallWinter(dur>duration((len-1)*24,0,0),:)=[];
TS_FallWinter(dur>duration((len-1)*24,0,0),:)=[];
[Thick_FallWinter,TF] = rmmissing(Thick_FallWinter,1);
[Vol_FallWinter,TF] = rmmissing(Vol_FallWinter,1);
TS_FallWinter = TS_FallWinter(~TF,:);
toDelete       = (sum(Vol_FallWinter, 2) == 0);
Thick_FallWinter(toDelete, :) = [];
Vol_FallWinter(toDelete, :) = [];
TS_FallWinter (toDelete, :) = [];
% clear  data_temp_FallWinter 

fprintf(', finito!\n');

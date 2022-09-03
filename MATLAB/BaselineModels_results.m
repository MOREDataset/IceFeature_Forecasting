addpath 'C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\results2\BaselineModels'
clear
clc
% short-term forecasting
%Preds
name = 'BaselineModels_test_predsdata_VOLF_';
mdl = 'GBDT';%'SVRsigmoid','SVRrbf','GBDT','SARIMAX'
filename = strcat(name,mdl,'.csv');

opts1 = detectImportOptions(filename);
Vol = readmatrix(filename,opts1);


%Targets
name = 'BaselineModels_test_targetdata_VOLF';
filename = strcat(name,'.csv');

opts1 = detectImportOptions(filename);
Target = readmatrix(filename,opts1);

%Preprocess
Target(Target==0,1) = 1;
Vol = Vol';
Target = Target';
if ~isequal(rem(length(Vol),7),0)
    Vol(end:end+rem(length(Vol),7)-1) = Vol(end)*ones(rem(length(Vol),7),1);
    Target(end:end+rem(length(Target),7)-1) = Target(end)*ones(rem(length(Target),7),1);    
end
clear temp_Vol temp_Target
j=1;
for i=1:7:length(Vol)
    temp_Vol(j,:) = Vol(1,i:i+6);
    temp_Target(j,:) = Target(1,i:i+6);
    j=j+1;
end

Vol = temp_Vol;
Target = temp_Target;
ymean = mean(mean((Target)));

%Performance
clc
MAPE = mean(mean(abs((Target-Vol)./Target)))*100;
RMSE = sqrt(mean(mean((Target-Vol).^2)));
CV = sqrt((1/size(Target,2))*sum(mean(abs(Target-Vol).^2)))/ymean*100;
fprintf('Short-term-%s, %.3f,%.3f,%.3f\n',mdl, RMSE,MAPE,CV)

% Mid-term forecasting
%Preds
name = 'BaselineModels_test_predsdata_VOLF_';
filename = strcat(name,mdl,'.csv');

opts1 = detectImportOptions(filename);
Vol = readmatrix(filename,opts1);


%Targets
name = 'BaselineModels_test_targetdata_VOLF';
filename = strcat(name,'.csv');

opts1 = detectImportOptions(filename);
Target = readmatrix(filename,opts1);

%Preprocess
Target(Target==0,1) = 1;
Vol = Vol';
Target = Target';
if ~isequal(rem(length(Vol),30),0)
    Vol(end-rem(length(Vol),30)+1:end) = [];
    Target(end-rem(length(Target),30)+1:end) = [];    
end
clear temp_Vol temp_Target
j=1;
for i=1:30:length(Vol)
    temp_Vol(j,:) = Vol(1,i:i+6);
    temp_Target(j,:) = Target(1,i:i+6);
    j=j+1;
end

Vol = temp_Vol;
Target = temp_Target;
ymean = mean(mean((Target)));

%Performance

MAPE = mean(mean(abs((Target-Vol)./Target)))*100;
RMSE = sqrt(mean(mean((Target-Vol).^2)));
CV = sqrt((1/size(Target,2))*sum(mean(abs(Target-Vol).^2)))/ymean*100;
fprintf('Mid-term-%s, %.3f,%.3f,%.3f\n',mdl, RMSE,MAPE,CV)

%% Historical mean
% short term
clear
clc

%read and reshape
filename = 'C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\IceTimeSeries.csv';
opts1 = detectImportOptions(filename);
data = readtimetable(filename,opts1);
data = retime(data,"regular","fillwithmissing","TimeStep",caldays(1));
data = fillmissing(data,'constant',1);
Test_data = data(data.Time(end-round(height(data)*20/100-2)+1:end),:); %make sure start is 2013-10-21
Vol = Test_data.Volume.*1000;
TS = datetime(Test_data.Time);
tempTime = TS(end);
TS_L = length(TS);
Vol = Vol';
TS = TS';

if ~isequal(rem(length(Vol),7),0)
    Vol(end:end+rem(length(Vol),7)-1) = Vol(end)*ones(rem(length(Vol),7),1);
    TS(end:end+rem(length(TS),7)-1) = NaT(rem(length(TS),7),1);
end
j=1;
for i=TS_L:TS_L+rem(TS_L,7)-1
    TS(i) = TS(TS_L-1)+caldays(j);
    j=j+1;
end

clear temp_Vol
j=1;
for i=1:7:length(Vol)
    temp_Vol(j,:) = Vol(1,i:i+6);
    temp_TS(j,:) = TS(1,i:i+6);
    j=j+1;
end
Vol_resh = temp_Vol;
TS_resh = temp_TS;
clear temp_Vol 

%whole time series
Vol_all = data.Volume.*1000;
TS_all = datetime(data.Time);
Test_TT = timetable(TS_all,Vol_all);
TS_L = height(Test_TT);
if ~isequal(rem(length(Test_TT.Vol_all),7),0)
    Test_TT.Vol_all(end:end+rem(length(Test_TT.Vol_all),7)-1) = Test_TT.Vol_all(end)*ones(rem(length(Test_TT.Vol_all),7),1);
    Test_TT.TS_all(end:end+rem(length(Test_TT.TS_all),7)-1) = NaT(rem(length(Test_TT.TS_all),7),1);
end
j=1;
for i=TS_L:TS_L+rem(TS_L,7)-1
    Test_TT.TS_all(i) = Test_TT.TS_all(TS_L-1)+caldays(j);
    j=j+1;
end


%LAST WEEK's MEAN
F1 = zeros(length(TS_resh),7);
for i = 1:length(TS_resh)
    %find start and end dates of sequence i
    Seq_start(i) = TS_resh(i,1);
    Seq_end(i) = TS_resh(i,end);

    %last week's
    Seq_start_MinusWeek = Seq_start(i) - calweeks(1);
    S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
    F1(i,:) = Test_TT.Vol_all(S)';
end

ymean = mean(mean((Vol_resh)));

%Performance

MAPE = mean(mean(abs((Vol_resh-F1)./Vol_resh)))*100;
RMSE = sqrt(mean(mean((Vol_resh-F1).^2)));
CV = sqrt((1/size(Vol_resh,2))*sum(mean(abs(Vol_resh-F1).^2)))/ymean*100;
fprintf('Short-term-F1, %.3f,%.3f,%.3f\n', RMSE,MAPE,CV)
% 
% %Same Week from last month's MEAN
% F2 = zeros(length(TS_resh),7);
% for i = 1:length(TS_resh)
%     %find start and end dates of sequence i
%     Seq_start(i) = TS_resh(i,1);
%     Seq_end(i) = TS_resh(i,end);
% 
%     %last week's
%     Seq_start_MinusWeek = Seq_start(i) - calmonths(1);
%     S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
%     F2(i,:) = Test_TT.Vol_all(S)';
% end
% 
% %Performance
% MAPE2 = mean(mean(abs((Vol_resh-F2)./Vol_resh)))*100;
% RMSE2 = sqrt(mean(mean((Vol_resh-F2).^2)));
% CV2 = sqrt((1/size(Vol_resh,2))*sum(mean(abs(Vol_resh-F2).^2)))/ymean*100;
% fprintf('Short-term-F2, %.3f,%.3f,%.3f\n', RMSE2,MAPE2,CV2)
% 
% %last Week from last month's MEAN
% F3 = zeros(length(TS_resh),7);
% for i = 1:length(TS_resh)
%     %find start and end dates of sequence i
%     Seq_start(i) = TS_resh(i,1);
%     Seq_end(i) = TS_resh(i,end);
% 
%     %last week's
%     Seq_start_MinusWeek = Seq_start(i) - calmonths(1) - calweeks(1);
%     S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
%     F3(i,:) = Test_TT.Vol_all(S)';
% end
% 
% %same week from last year's MEAN
% F4 = zeros(length(TS_resh),7);
% for i = 1:length(TS_resh)
%     %find start and end dates of sequence i
%     Seq_start(i) = TS_resh(i,1);
%     Seq_end(i) = TS_resh(i,end);
% 
%     %last week's
%     Seq_start_MinusWeek = Seq_start(i) - calyears(1);
%     S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
%     F4(i,:) = Test_TT.Vol_all(S)';
% end
% 
% %same week from two years ago's MEAN
% F5 = zeros(length(TS_resh),7);
% for i = 1:length(TS_resh)
%     %find start and end dates of sequence i
%     Seq_start(i) = TS_resh(i,1);
%     Seq_end(i) = TS_resh(i,end);
% 
%     %last week's
%     Seq_start_MinusWeek = Seq_start(i) - calyears(2);
%     S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
%     F5(i,:) = Test_TT.Vol_all(S)';
% end
% 
% %same week from three years ago's MEAN
% F6 = zeros(length(TS_resh),7);
% for i = 1:length(TS_resh)
%     %find start and end dates of sequence i
%     Seq_start(i) = TS_resh(i,1);
%     Seq_end(i) = TS_resh(i,end);
% 
%     %last week's
%     Seq_start_MinusWeek = Seq_start(i) - calyears(3);
%     S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + calweeks(1),'closedleft');
%     F6(i,:) = Test_TT.Vol_all(S)';
% end
% 
% for i = 1:length(F1)
%     Fx(i,:) = mean([F4(i,:);F5(i,:);F6(i,:)]);
% end

%mid-term
clear


%read and reshape
filename = 'C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\IceTimeSeries.csv';
opts1 = detectImportOptions(filename);
data = readtimetable(filename,opts1);
data = retime(data,"regular","fillwithmissing","TimeStep",caldays(1));
data = fillmissing(data,'constant',1);
Test_data = data(data.Time(end-round(height(data)*20/100-2)+1:end),:); %make sure start is 2013-10-21
Vol = Test_data.Volume.*1000;
TS = datetime(Test_data.Time);
tempTime = TS(end);
TS_L = length(TS);
Vol = Vol';
TS = TS';

if ~isequal(rem(length(Vol),30),0)
    Vol(end-rem(length(Vol),30)+1:end) = [];
    TS(end-rem(length(TS),30)+1:end) = [];
end


clear temp_Vol
j=1;
for i=1:30:length(Vol)
    temp_Vol(j,:) = Vol(1,i:i+29);
    temp_TS(j,:) = TS(1,i:i+29);
    j=j+1;
end
Vol_resh = temp_Vol;
TS_resh = temp_TS;
clear temp_Vol 

%whole time series
Vol_all = data.Volume.*1000;
TS_all = datetime(data.Time);
Test_TT = timetable(TS_all,Vol_all);
TS_L = height(Test_TT);
% if ~isequal(rem(length(Test_TT.Vol_all),30),0)
%     Test_TT.Vol_all(end-rem(length(Test_TT.Vol_all),30)+1:end) = [];
%     Test_TT.TS_all(end-rem(length(Test_TT.TS_all),30)+1:end) = [];
% end
% j=1;
% for i=TS_L:TS_L+rem(TS_L,30)-1
%     Test_TT.TS_all(i) = Test_TT.TS_all(TS_L-1)+caldays(j);
%     j=j+1;
% end


%LAST WEEK's MEAN
F1 = zeros(length(TS_resh),30);
for i = 1:length(TS_resh)
    %find start and end dates of sequence i
    Seq_start(i) = TS_resh(i,1);
    Seq_end(i) = TS_resh(i,end);

    %last week's
    Seq_start_MinusWeek = Seq_start(i) - calmonths(1);
    S = timerange(Seq_start_MinusWeek,Seq_start_MinusWeek + caldays(30),'closedleft');
    F1(i,:) = Test_TT.Vol_all(S)';
end

ymean = mean(mean((Vol_resh)));

%Performance

MAPE = mean(mean(abs((Vol_resh-F1)./Vol_resh)))*100;
RMSE = sqrt(mean(mean((Vol_resh-F1).^2)));
CV = sqrt((1/size(Vol_resh,2))*sum(mean(abs(Vol_resh-F1).^2)))/ymean*100;
fprintf('Mid-term-F1, %.3f,%.3f,%.3f\n', RMSE,MAPE,CV)
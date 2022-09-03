%% Construction of Volume sequences
clear
clc
len = 30 + 7; %30 days + 1 day
horizon = '7d';
fprintf('-Processing data for %d forecasting horizons!\n',len-30);
[TS, ~, ~, ~, Vol_FallWinter, Vol_SpringSummer] = ThickVol_ForecastData_preprocessing_4stationary(len);
fprintf('...')

for k = 1:height(Vol_FallWinter)
    [h(k),pValue(k),stat(k),cValue(k)] = kpsstest(Vol_FallWinter(k,1:30),Alpha=0.01);
end
H = mean(h,'omitnan');
PVALUE = mean(pValue,'omitnan');
STAT = mean(stat,'omitnan');
CVALUE = mean(cValue,'omitnan');
fprintf('\nnoDecomposition- FALL/WINTER: \npValue, stat, cValue\n%.6f, %.6f, %.6f\n',mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
clear h pValue stat cValue H PVALUE STAT CVALUE

fprintf('...')
for k = 1:height(Vol_SpringSummer)
    [h(k),pValue(k),stat(k),cValue(k)] = kpsstest(Vol_SpringSummer(k,1:30),Alpha=0.01);
end
H = mean(h,'omitnan');
PVALUE = mean(pValue,'omitnan');
STAT = mean(stat,'omitnan');
CVALUE = mean(cValue,'omitnan');
fprintf('\nnoDecomposition- SPRING/SUMMER: \npValue, stat, cValue\n%.6f, %.6f, %.6f\n',mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
clear h pValue stat cValue H PVALUE STAT CVALUE

%% EMD
clc
%find out number of IMFs for EMD
temp = eemd(Vol_SpringSummer(1,:),0,1);
numberIMFs_Vol_SpringSummer = size(temp,2)-2;
temp = eemd(Vol_FallWinter(1,:),0,1);
numberIMFs_Vol_FallWinter = size(temp,2)-2;

%Fall/Winter
numberIMFs = numberIMFs_Vol_FallWinter;
clear x
for i = 0:len
    x{i+1} = 'Element'+string(i);
end
for L = 1:1 %numberIMFs
    fprintf('*Extracting %s EMD volume fall/winter features using %d IMFs..\n',horizon, numberIMFs(L));
    EMD = table('Size',[length(Vol_FallWinter)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
    EMD.Properties.VariableNames{1}='SequenceNumber';
    TEMVol_FallWinter=ones(length(Vol_FallWinter)*(numberIMFs(L)+1),1+len);
    for i = 1:1:length(Vol_FallWinter)
        imf = eemd(Vol_FallWinter(i,:),0,1);
        res = imf(:,end);
        imf = imf(:,2:end-1);
        TEMVol_FallWinter(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
    end
    EMD = array2table(TEMVol_FallWinter,'VariableNames',string(x));
    fprintf('finished!\n');
end

j = 1;
for k = 1:5:height(Vol_FallWinter)
    fprintf('%d, ',j)
    temp = EMD(k:k+4,2:31);
    for i = 1:4
        [h(i),pValue(i),stat(i),cValue(i)] = kpsstest(table2array(temp(i,:)),Alpha=0.01);
    end
    H(j) = mean(h,'omitnan');
    PVALUE(j) = mean(pValue,'omitnan');
    STAT(j) = mean(stat,'omitnan');
    CVALUE(j) = mean(cValue,'omitnan');
    j = j+1;
end
fprintf('EMD- FALL/WINTER: \n, pValue, stat, cValue\n%.6f, %.6f, %.6f\n',mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
clear h pValue stat cValue H PVALUE STAT CVALUE

%Spring/Summer
numberIMFs = numberIMFs_Vol_SpringSummer;
clear x
for i = 0:len
    x{i+1} = 'Element'+string(i);
end
for L = 1:1 %numberIMFs
    fprintf('*Extracting %s EMD thickness spring/summer features using %d IMFs..\n',horizon, numberIMFs(L));
    EMD = table('Size',[length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
    EMD.Properties.VariableNames{1}='SequenceNumber';
    TEMVol_SpringSummer=ones(length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len);
    for i = 1:1:length(Vol_SpringSummer)
        imf = eemd(Vol_SpringSummer(i,:),0,1);
        res = imf(:,end);
        imf = imf(:,2:end-1);
        TEMVol_SpringSummer(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
    end
    EMD = array2table(TEMVol_SpringSummer,'VariableNames',string(x));
    fprintf('finished!\n');
end
j = 1;
for k = 1:5:height(Vol_SpringSummer)
    fprintf('%d, ',j)
    temp = EMD(k:k+4,2:31);
    for i = 1:4
        [h(i),pValue(i),stat(i),cValue(i)] = kpsstest(table2array(temp(i,:)),Alpha=0.01);
    end
    H(j) = mean(h,'omitnan');
    PVALUE(j) = mean(pValue,'omitnan');
    STAT(j) = mean(stat,'omitnan');
    CVALUE(j) = mean(cValue,'omitnan');
    j = j+1;
end
fprintf('EMD- SPRING/SUMMER: \npValue, stat, cValue\n%.6f, %.6f, %.6f\n',mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
clear h pValue stat cValue H PVALUE STAT CVALUE

%% VMD
clc
% VOLUME
numberIMFs = [7 15 23 31 39 47 55 63 71 79];

for L=1:length(numberIMFs)
    %Fall/Winter
    clear x
    for i = 0:len
        x{i+1} = 'Element'+string(i);
    end
    %     fprintf('*Extracting %s VMD volume fall/winter features using %d IMFs..\n',horizon, numberIMFs(L));
    VMD = table('Size',[length(Vol_FallWinter)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
    VMD.Properties.VariableNames{1}='SequenceNumber';
    TEMVol_FallWinter=ones(length(Vol_FallWinter)*(numberIMFs(L)+1),1+len);
    for i = 1:1:length(Vol_FallWinter)
        [imf,res] = vmd(Vol_FallWinter(i,:),'NumIMFs',numberIMFs(L));
        TEMVol_FallWinter(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
    end
    VMD = array2table(TEMVol_FallWinter,'VariableNames',string(x));
    %         fprintf('finished!\n');

    j = 1;
    for k = 1:numberIMFs(L)+1:height(Vol_FallWinter)
        %         fprintf('%d, ',k)
        temp = VMD(k:k+numberIMFs(L),2:31);
        for i = 1:numberIMFs(L)
            [h(i),pValue(i),stat(i),cValue(i)] = kpsstest(table2array(temp(i,:)),Alpha=0.01);
        end
        H(j) = mean(h,'omitnan');
        PVALUE(j) = mean(pValue,'omitnan');
        STAT(j) = mean(stat,'omitnan');
        CVALUE(j) = mean(cValue,'omitnan');
        j = j+1;
    end
    fprintf('VMD:%dIMFs- FALL/WINTER:,pValue, stat, cValue,%.6f, %.6f, %.6f\n',numberIMFs(L),mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
    clear h pValue stat cValue H PVALUE STAT CVALUE
end

for L=1:length(numberIMFs)
    %Spring/Summer
    clear x
    for i = 0:len
        x{i+1} = 'Element'+string(i);
    end
    %         fprintf('*Extracting %s VMD thickness spring/summer features using %d IMFs..\n',horizon, numberIMFs(L));
    VMD = table('Size',[length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
    VMD.Properties.VariableNames{1}='SequenceNumber';
    TEMVol_SpringSummer=ones(length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len);
    for i = 1:1:length(Vol_SpringSummer)
        [imf,res] = vmd(Vol_SpringSummer(i,:),'NumIMFs',numberIMFs(L));
        TEMVol_SpringSummer(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
    end
    VMD = array2table(TEMVol_SpringSummer,'VariableNames',string(x));
    %         fprintf('finished!\n');

    j = 1;
    for k = 1:numberIMFs(L)+1:height(Vol_FallWinter)
        %         fprintf('%d, ',j)
        temp = VMD(k:k+numberIMFs(L),2:31);
        for i = 1:numberIMFs(L)
            [h(i),pValue(i),stat(i),cValue(i)] = kpsstest(table2array(temp(i,:)),Alpha=0.01);
        end
        H(j) = mean(h,'omitnan');
        PVALUE(j) = mean(pValue,'omitnan');
        STAT(j) = mean(stat,'omitnan');
        CVALUE(j) = mean(cValue,'omitnan');
        j = j+1;
    end
    fprintf('VMD:%dIMFs- SPRING/SUMMER:,pValue, stat, cValue,%.6f, %.6f, %.6f\n',numberIMFs(L),mean(PVALUE,'omitnan'),mean(STAT,'omitnan'),mean(CVALUE,'omitnan'))
    clear h pValue stat cValue H PVALUE STAT CVALUE
end
fprintf('finished!\n');

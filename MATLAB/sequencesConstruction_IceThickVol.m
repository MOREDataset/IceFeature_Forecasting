function sequencesConstruction_IceThickVol(len,horizon,numberIMFs)
% numberIMFs = 15; %[31 63 127 255];
%% Construction of Thickness, Volume, and TS sequences
len = 30 + 7; %30 days + 1 day
horizon = '7d';
fprintf('-Processing data for %d forecasting horizons!\n',len-30);
[TS_FallWinter, TS_SpringSummer, Thick_FallWinter, Thick_SpringSummer, Vol_FallWinter, Vol_SpringSummer] = ThickVol_ForecastData_preprocessing(len);

% % fprintf('-Exporting data...');
% % % FallWinter
% writematrix(Thick_FallWinter,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_FallWinter.csv'))
% writematrix(TS_FallWinter,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_TSsequences_FallWinter.csv'))
% writematrix(Vol_FallWinter,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_FallWinter.csv'))
% % % SpringSummer
% writematrix(Thick_SpringSummer,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_SpringSummer.csv'))
% writematrix(TS_SpringSummer,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_TSsequences_SpringSummer.csv'))
% writematrix(Vol_SpringSummer,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_SpringSummer.csv'))
% % fprintf(', finito!\n');

%% Construction of decomposed sequences from input data
clc
%- VMD
VMD_func(len, horizon, numberIMFs)

%- EMD
% find out number of IMFs for each input
temp = eemd(Thick_SpringSummer(1,:),0,1);
numberIMFs_Thick_SpringSummer = size(temp,2)-2;
temp = eemd(Thick_FallWinter(1,:),0,1);
numberIMFs_Thick_FallWinter = size(temp,2)-2;
temp = eemd(Vol_SpringSummer(1,:),0,1);
numberIMFs_Vol_SpringSummer = size(temp,2)-2;
temp = eemd(Vol_FallWinter(1,:),0,1);
numberIMFs_Vol_FallWinter = size(temp,2)-2;

EMD_func(len, horizon, numberIMFs_Thick_SpringSummer, numberIMFs_Thick_FallWinter, numberIMFs_Vol_SpringSummer, numberIMFs_Vol_FallWinter)

%% Additional functions
    function VMD_func(len, horizon, numberIMFs)
        % numberIMFs = 31; %[31 63 127 255];
        %THICKNESS
        %Fall/Winter
        clear x
        for i = 0:len
            x{i+1} = 'Element'+string(i);
        end
        for L = 1:1 %numberIMFs
            fprintf('*Extracting %s VMD thickness fall/winter features using %d IMFs..\n',horizon, numberIMFs(L));
            VMD = table('Size',[length(Thick_FallWinter)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
            VMD.Properties.VariableNames{1}='SequenceNumber';
            TEMThick_FallWinter=ones(length(Thick_FallWinter)*(numberIMFs(L)+1),1+len);
            for i = 1:1:length(Thick_FallWinter)
                [imf,res] = vmd(Thick_FallWinter(i,:),'NumIMFs',numberIMFs(L));
                TEMThick_FallWinter(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
            end
            VMD = array2table(TEMThick_FallWinter,'VariableNames',string(x));
            %compute IMFs then save into csv files
            fprintf('-Exporting VMD sequences.., ');
            writetable(VMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_',string(numberIMFs(L)),'IMFs_FallWinter.csv'))
            fprintf('finished!\n');
        end

        %Spring/Summer
        clear x
        for i = 0:len
            x{i+1} = 'Element'+string(i);
        end
        for L = 1:1 %numberIMFs
            fprintf('*Extracting %s VMD thickness spring/summer features using %d IMFs..\n',horizon, numberIMFs(L));
            VMD = table('Size',[length(Thick_SpringSummer)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
            VMD.Properties.VariableNames{1}='SequenceNumber';
            TEMThick_SpringSummer=ones(length(Thick_SpringSummer)*(numberIMFs(L)+1),1+len);
            for i = 1:1:length(Thick_SpringSummer)
                [imf,res] = vmd(Thick_SpringSummer(i,:),'NumIMFs',numberIMFs(L));
                TEMThick_SpringSummer(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
            end
            VMD = array2table(TEMThick_SpringSummer,'VariableNames',string(x));
            %compute IMFs then save into csv files
            fprintf('-Exporting VMD sequences.., ');
            writetable(VMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_',string(numberIMFs(L)),'IMFs_SpringSummer.csv'))
            fprintf('finished!\n');
        end

        % VOLUME
        %Fall/Winter
        clear x
        for i = 0:len
            x{i+1} = 'Element'+string(i);
        end
        for L = 1:1 %numberIMFs
            fprintf('*Extracting %s VMD volume fall/winter features using %d IMFs..\n',horizon, numberIMFs(L));
            VMD = table('Size',[length(Vol_FallWinter)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
            VMD.Properties.VariableNames{1}='SequenceNumber';
            TEMVol_FallWinter=ones(length(Vol_FallWinter)*(numberIMFs(L)+1),1+len);
            for i = 1:1:length(Vol_FallWinter)
                [imf,res] = vmd(Vol_FallWinter(i,:),'NumIMFs',numberIMFs(L));
                TEMVol_FallWinter(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
            end
            VMD = array2table(TEMVol_FallWinter,'VariableNames',string(x));
            %compute IMFs then save into csv files
            fprintf('-Exporting VMD sequences.., ');
            writetable(VMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_',string(numberIMFs(L)),'IMFs_FallWinter.csv'))
            fprintf('finished!\n');
        end

        %Spring/Summer
        clear x
        for i = 0:len
            x{i+1} = 'Element'+string(i);
        end
        for L = 1:1 %numberIMFs
            fprintf('*Extracting %s VMD thickness spring/summer features using %d IMFs..\n',horizon, numberIMFs(L));
            VMD = table('Size',[length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
            VMD.Properties.VariableNames{1}='SequenceNumber';
            TEMVol_SpringSummer=ones(length(Vol_SpringSummer)*(numberIMFs(L)+1),1+len);
            for i = 1:1:length(Vol_SpringSummer)
                [imf,res] = vmd(Vol_SpringSummer(i,:),'NumIMFs',numberIMFs(L));
                TEMVol_SpringSummer(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
            end
            VMD = array2table(TEMVol_SpringSummer,'VariableNames',string(x));
            %compute IMFs then save into csv files
            fprintf('-Exporting VMD sequences.., ');
            writetable(VMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_',string(numberIMFs(L)),'IMFs_SpringSummer.csv'))
            fprintf('finished!\n');
        end

    end

    function EMD_func(len, horizon, numberIMFs_Thick_SpringSummer, numberIMFs_Thick_FallWinter, numberIMFs_Vol_SpringSummer, numberIMFs_Vol_FallWinter)
        %         %THICKNESS
        %         %Fall/Winter
        %         numberIMFs = numberIMFs_Thick_FallWinter;
        %         clear x
        %         for i = 0:len
        %             x{i+1} = 'Element'+string(i);
        %         end
        %         for L = 1:1 %numberIMFs
        %             fprintf('*Extracting %s EMD thickness fall/winter features using IMFs..\n',horizon);
        %             EMD = table('Size',[length(Thick_FallWinter)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
        %             EMD.Properties.VariableNames{1}='SequenceNumber';
        %             TEMThick_FallWinter=ones(length(Thick_FallWinter)*(numberIMFs(L)+1),1+len);
        %             for i = 1:1:length(Thick_FallWinter)
        %                 imf = eemd(Thick_FallWinter(i,:),0,1);% for EMD
        %                 res = imf(:,end);
        %                 imf = imf(:,2:end-1);
        %                 TEMThick_FallWinter(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
        %             end
        %             EMD = array2table(TEMThick_FallWinter,'VariableNames',string(x));
        %             %compute IMFs then save into csv files
        %             fprintf('-Exporting EMD sequences.., ');
        %             writetable(EMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_EMD',string(numberIMFs(L)),'IMFs_FallWinter.csv'))
        %             fprintf('finished!\n');
        %         end
        %
        %         %Spring/Summer
        %         numberIMFs = numberIMFs_Thick_SpringSummer;
        %         clear x
        %         for i = 0:len
        %             x{i+1} = 'Element'+string(i);
        %         end
        %         for L = 1:1 %numberIMFs
        %             fprintf('*Extracting %s EMD thickness spring/summer features using %d IMFs..\n',horizon, numberIMFs(L));
        %             EMD = table('Size',[length(Thick_SpringSummer)*(numberIMFs(L)+1),1+len],'VariableNames',string(x),'VariableTypes','double'+strings(1,length(x)));%,'',{'single','double','double','double','double','double','double','double','double','double','double','double','double','double'});
        %             EMD.Properties.VariableNames{1}='SequenceNumber';
        %             TEMThick_SpringSummer=ones(length(Thick_SpringSummer)*(numberIMFs(L)+1),1+len);
        %             for i = 1:1:length(Thick_SpringSummer)
        %                 imf = eemd(Thick_SpringSummer(i,:),0,1);
        %                 res = imf(:,end);
        %                 imf = imf(:,2:end-1);
        %                 TEMThick_SpringSummer(i+(numberIMFs(L))*(i-1):i+(numberIMFs(L))*(i-1)+(numberIMFs(L)),:) = [ones(numberIMFs(L)+1,1)*i,[imf';res']];%
        %             end
        %             EMD = array2table(TEMThick_SpringSummer,'VariableNames',string(x));
        %             %compute IMFs then save into csv files
        %             fprintf('-Exporting EMD sequences.., ');
        %             writetable(EMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Thicksequences_EMD',string(numberIMFs(L)),'IMFs_SpringSummer.csv'))
        %             fprintf('finished!\n');
        %         end

        % VOLUME
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
            %compute IMFs then save into csv files
            %             fprintf('-Exporting EMD sequences.., ');
            %             writetable(EMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_EMD',string(numberIMFs(L)),'IMFs_FallWinter.csv'))
            fprintf('finished!\n');
        end

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
            %compute IMFs then save into csv files
            fprintf('-Exporting EMD sequences.., ');
            writetable(EMD,strcat('C:\Users\mohamed.ahajjam\Desktop\UND\Defense resiliency platform\Datasets\Arctic sea forecasting\PIOMAS\ICEF',horizon,'_Volsequences_EMD',string(numberIMFs(L)),'IMFs_SpringSummer.csv'))
            fprintf('finished!\n');
        end

    end
end

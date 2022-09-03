% clr = [0 0.4470 0.7410; 0.8500 0.3250 0.0980];
% smbls = {'v','^'};
% K = [1:87];
% size1=30;
% % Create figure
% figure1 = figure('WindowState','maximized');
% t = tiledlayout(1,1,'TileSpacing','tight','Padding','tight');%3,4
% X = [7 15 23 31 39 47 55 63 71 79];
% 
% %Ice Thickness
% %RMSE curves for short-term
% nexttile(1);
% RMSE = [0.006
% 0.004
% 0.004
% 0.005
% 0.005
% 0.006
% 0.005
% 0.004
% 0.006
% 0.006
% 0.006
% 0.006
% 0.004
% ];
% plot(K(X),RMSE,'Marker',smbls{1},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Fall/Winter','LineStyle','-','Color',clr(1,:)), hold on
% [min_S1,ind_S1] = min(RMSE);
% box('on')
% grid('on')
% set(gca,'XMinorGrid','on','YMinorGrid','on');
% 
% RMSE = [0.012
% 0.013
% 0.011
% 0.012
% 0.007
% 0.01
% 0.009
% 0.013
% 0.012
% 0.011
% 0.009
% 0.009
% 0.014
% ];
% plot(K(X),RMSE,smbls{2},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Spring/Summer','LineStyle','-','Color',clr(2,:))
% [min_S2,ind_S2] = min(RMSE);
% stem(X(ind_S1),min_S1,smbls{1},'filled','MarkerFaceColor',clr(1,:),'LineStyle','--','Color',clr(1,:),'HandleVisibility','off')
% stem(X(ind_S2),min_S2,smbls{2},'filled','MarkerFaceColor',clr(2,:),'LineStyle','--','Color',clr(2,:),'HandleVisibility','off')
% ylabel('RMSE ($m$)','interpreter','latex','FontSize',size1);
% xlabel('Decomposition level ($K$)','interpreter','latex','FontSize',size1);
% box('on')
% grid('on')
% max_y = get(gca,'ylim');
% set(gca,'XMinorGrid','on','YMinorGrid','on','ylim',[min(min_S1,min_S2)-.2*min(min_S1,min_S2), max_y(2)],'FontSize',size1,'TickLabelInterpreter','latex');
% legend1 = legend(gca,'show');
% set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
% exportgraphics(t,'EXPII_RMSE_7d_Thickness.pdf','ContentType','vector')
% fprintf('done!\n')
% exportgraphics(t,'EXPII_RMSE_7d_Thickness.pdf','ContentType','vector')
% close all
% 
% %RMSE curves for mid-term
% % Create figure
% figure1 = figure('WindowState','maximized');
% t = tiledlayout(1,1,'TileSpacing','tight','Padding','tight');%3,4
% nexttile(1);
% RMSE = [0.012
% 0.013
% 0.009
% 0.01
% 0.009
% 0.009
% 0.008
% 0.009
% 0.008
% 0.013
% 0.011
% 0.007
% 0.01
% ];
% plot(K(X),RMSE,'Marker',smbls{1},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Fall/Winter','LineStyle','-','Color',clr(1,:)), hold on
% [min_S1,ind_S1] = min(RMSE);
% box('on')
% grid('on')
% set(gca,'XMinorGrid','on','YMinorGrid','on');
% 
% RMSE = [0.028
% 0.02
% 0.018
% 0.015
% 0.02
% 0.02
% 0.023
% 0.017
% 0.016
% 0.019
% 0.016
% 0.021
% 0.024
% ];
% plot(K(X),RMSE,smbls{2},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Spring/Summer','LineStyle','-','Color',clr(2,:))
% [min_S2,ind_S2] = min(RMSE);
% stem(X(ind_S1),min_S1,smbls{1},'filled','MarkerFaceColor',clr(1,:),'LineStyle','--','Color',clr(1,:),'HandleVisibility','off')
% stem(X(ind_S2),min_S2,smbls{2},'filled','MarkerFaceColor',clr(2,:),'LineStyle','--','Color',clr(2,:),'HandleVisibility','off')
% ylabel('RMSE ($m$)','interpreter','latex','FontSize',size1);
% xlabel('Decomposition level ($K$)','interpreter','latex','FontSize',size1);
% box('on')
% grid('on')
% max_y = get(gca,'ylim');
% max_y = get(gca,'ylim');
% set(gca,'XMinorGrid','on','YMinorGrid','on','ylim',[min(min_S1,min_S2)-.2*min(min_S1,min_S2), max_y(2)],'FontSize',size1,'TickLabelInterpreter','latex');
% legend1 = legend(gca,'show');
% set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
% exportgraphics(t,'EXPII_RMSE_1m_Thickness.pdf','ContentType','vector')
% fprintf('done!\n')
% exportgraphics(t,'EXPII_RMSE_1m_Thickness.pdf','ContentType','vector')
% close all

%% Ice volume
clr = [0 0.4470 0.7410; 0.8500 0.3250 0.0980];
smbls = {'v','^'};
K = [1:87];
size=30;
% Create figure
figure1 = figure('WindowState','maximized');
t = tiledlayout(1,1,'TileSpacing','tight','Padding','tight');%3,4
X = [7 15 23 31 39 47 55 63 71 79];
size1=30;

%RMSE curves for short-term
nexttile(1);
RMSE = [152.386
189.766
150.981
173.027
137.394
163.695
171.804
157.729
165.018
161.361
];
plot(K(X),RMSE,'Marker',smbls{1},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Fall/Winter','LineStyle','-','Color',clr(1,:)), hold on
[min_S1,ind_S1] = min(RMSE);
box('on')
grid('on')
set(gca,'XMinorGrid','on','YMinorGrid','on');

RMSE = [160.967
115.423
143.982
164.417
176.837
256.001
189.178
237.486
177.631
226.067
];
plot(K(X),RMSE,smbls{2},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Spring/Summer','LineStyle','-','Color',clr(2,:))
[min_S2,ind_S2] = min(RMSE);
stem(X(ind_S1),min_S1,smbls{1},'filled','MarkerFaceColor',clr(1,:),'LineStyle','--','Color',clr(1,:),'HandleVisibility','off')
stem(X(ind_S2),min_S2,smbls{2},'filled','MarkerFaceColor',clr(2,:),'LineStyle','--','Color',clr(2,:),'HandleVisibility','off')
ylabel('RMSE ($km^3$)','interpreter','latex','FontSize',size1);
xlabel('Decomposition level ($K$)','interpreter','latex','FontSize',size1);
box('on')
grid('on')
max_y = get(gca,'ylim');
set(gca,'XMinorGrid','on','YMinorGrid','on','ylim',[min(min_S1,min_S2)-.2*min(min_S1,min_S2), max_y(2)],'FontSize',size1,'TickLabelInterpreter','latex');
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
% Create textarrow
annotation(figure1,'textarrow',[0.469791666666666 0.509375],...
    [0.253413291796469 0.28141225337487],'String',{'K=39'},'LineWidth',1,...
    'Interpreter','latex',...
    'FontSize',25);

% Create textarrow
annotation(figure1,'textarrow',[0.232291666666667 0.238020833333333],...
    [0.300142263759086 0.221183800623053],'String',{'K=15'},'LineWidth',1,...
    'Interpreter','latex',...
    'FontSize',25);

exportgraphics(t,'EXPII_RMSE_7d_Volume.pdf','ContentType','vector')
fprintf('done!\n')
exportgraphics(t,'EXPII_RMSE_7d_Volume.pdf','ContentType','vector')
close(gcf)

%RMSE curves for mid-term
% Create figure
figure1 = figure('WindowState','maximized');
t = tiledlayout(1,1,'TileSpacing','tight','Padding','tight');%3,4
nexttile(1);
RMSE = [222.717
234.214
306.804
250.068
272.598
266.564
268.542
194.579
217.154
289.275
];
plot(K(X),RMSE,'Marker',smbls{1},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Fall/Winter','LineStyle','-','Color',clr(1,:)), hold on
[min_S1,ind_S1] = min(RMSE);
box('on')
grid('on')
set(gca,'XMinorGrid','on','YMinorGrid','on');

RMSE = [323.867
293.079
260.657
208.387
286.571
311.155
326.631
362.771
387.102
328.216
];
plot(K(X),RMSE,smbls{2},'MarkerSize',10,'MarkerFaceColor','w','LineWidth',2,'Parent',gca,'DisplayName','Spring/Summer','LineStyle','-','Color',clr(2,:))
[min_S2,ind_S2] = min(RMSE);
stem(X(ind_S1),min_S1,smbls{1},'filled','MarkerFaceColor',clr(1,:),'LineStyle','--','Color',clr(1,:),'HandleVisibility','off')
stem(X(ind_S2),min_S2,smbls{2},'filled','MarkerFaceColor',clr(2,:),'LineStyle','--','Color',clr(2,:),'HandleVisibility','off')
ylabel('RMSE ($km^3$)','interpreter','latex','FontSize',size1);
xlabel('Decomposition level ($K$)','interpreter','latex','FontSize',size1);
box('on')
grid('on')
max_y = get(gca,'ylim');
set(gca,'XMinorGrid','on','YMinorGrid','on','ylim',[min(min_S1,min_S2)-.2*min(min_S1,min_S2), max_y(2)],'FontSize',size1,'TickLabelInterpreter','latex');
legend1 = legend(gca,'show');
set(legend1,'Orientation','horizontal','Location','northoutside','Interpreter','latex','FontSize',size1);
% Create textarrow
annotation(figure1,'textarrow',[0.805729166666667 0.795833333333333],...
    [0.339563862928349 0.263759086188993],'String',{'K=63'},'LineWidth',1,...
    'Interpreter','latex',...
    'FontSize',25);

% Create textarrow
annotation(figure1,'textarrow',[0.372916666666666 0.414583333333333],...
    [0.2523748701973 0.275181723779855],'String',{'K=31'},'LineWidth',1,...
    'Interpreter','latex',...
    'FontSize',25);

exportgraphics(t,'EXPII_RMSE_1m_Volume.pdf','ContentType','vector')
fprintf('done!\n')
exportgraphics(t,'EXPII_RMSE_1m_Volume.pdf','ContentType','vector')
close(gcf)

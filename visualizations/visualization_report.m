%% Resuluts, absolute climatic parameters

Pt2mmaxERA = groupsummary(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.Season,"mean");
Pt2mmaxStation = groupsummary(Potsdam_31y_dog.t2mmaxStation,Potsdam_31y_dog.Season,"mean");
Kt2mmaxERA = groupsummary(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.Season,"mean");
Kt2mmaxStation = groupsummary(Kimberley_31y_dog.t2mmaxStation,Kimberley_31y_dog.Season,"mean");

Pt2mminERA = groupsummary(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.Season,"mean");
Pt2mminStation = groupsummary(Potsdam_31y_dog.t2mminStation,Potsdam_31y_dog.Season,"mean");
Kt2mminERA = groupsummary(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.Season,"mean");
Kt2mminStation = groupsummary(Kimberley_31y_dog.t2mminStation,Kimberley_31y_dog.Season,"mean");

P1t = [1991:2021]';

tiledlayout(1,2,"TileSpacing","compact")

nexttile
plot(P1t,Pt2mminERA,Color=[0.4940 0.1840 0.5560],LineStyle=":",LineWidth=1.5)
hold on
plot(P1t,Pt2mminStation,Color=[0.4660 0.6740 0.1880],LineStyle="-",LineWidth=1.5)
plot(P1t,Pt2mmaxERA,Color=[0.4940 0.1840 0.5560],LineStyle=":",LineWidth=1.5)
plot(P1t,Pt2mmaxStation,Color=[0.4660 0.6740 0.1880],LineStyle="-",LineWidth=1.5)
ylim([10,38])
xlim([1991,2021])
hold off
grid on
ylabel("Min. & Max. temperature (seasonal mean) [°C]","Position",[1988,24.5],"FontWeight","normal")
legend("ERA5-Land","Climate Station")
title("Potsdam, Germany -" + "\bf higher climate station density", "FontWeight","normal","FontSize",11)

nexttile
plot(P1t,Kt2mminERA,Color=[0.4940 0.1840 0.5560],LineStyle=":",LineWidth=1.5)
hold on
plot(P1t,Kt2mminStation,Color=[0.4660 0.6740 0.1880],LineStyle="-",LineWidth=1.5)
plot(P1t,Kt2mmaxERA,Color=[0.4940 0.1840 0.5560],LineStyle=":",LineWidth=1.5)
plot(P1t,Kt2mmaxStation,Color=[0.4660 0.6740 0.1880],LineStyle="-",LineWidth=1.5)
ylim([10,38])
xlim([1991,2021])
title("Kimberley, South Africa -" + "\bf lower climate station density", "FontWeight","normal","FontSize",11)
hold off
grid on

%%

p = ranksum(Pt2mmaxERA,Pt2mmaxStation)

%% Results stat. parameter NSE

figure(1)

NSEno2003 = PK_NSE_seasonal(PK_NSE_seasonal.Season~="2003",:);

t = tiledlayout(1,3);
% tt = title(t,"Nash-Sutcliffe Efficiency calculated for each Growing Season");
% stt = subtitle(t,"1991 - 2021, Potsdam vs. Kimberley, Obs = Station Data, Pred = ERA5-Land");
% tt.FontWeight = "normal";
% stt.FontWeight ="bold";
% tt.FontSize = 12;
% stt.FontSize = 10;
% t.TileSpacing = "tight";
% t.Padding = "compact";

% Stat1 t2m
a1 = nexttile;
boxchart(PK_NSE_seasonal.Stage,PK_NSE_seasonal.t2mmax, ...
    "GroupByColor",PK_NSE_seasonal.Loc,"Notch","on");
title("daily max."+ "\bf Temperature", "FontWeight","normal","FontSize",11)


% Stat1 tp
a2 = nexttile;
boxchart(NSEno2003.Stage,NSEno2003.tp, ...
    "GroupByColor",NSEno2003.Loc,"Notch","on");
title("daily total"+ "\bf Precipitation", "FontWeight","normal","FontSize",11)

% Stat1 et0
a3 = nexttile;
boxchart(PK_NSE_seasonal.Stage,PK_NSE_seasonal.et0, ...
    "GroupByColor",PK_NSE_seasonal.Loc,"Notch","on");
title("daily total"+ "\bf ET0", "FontWeight","normal","FontSize",11)


grid([a1,a2,a3],"on")
xticklabels([a1,a2,a3],"")
fontsize([a1.YAxis,a2.YAxis,a3.YAxis],8,"points")
fontsize([a1.XAxis,a2.XAxis,a3.XAxis],8,"points")
legend(["Potsdam","Kimberley"], ...
    "Position",[0.5, 0.83, 0.115, 0.08]);

% title(a1,"TEMP, daily mean","FontWeight","bold","FontSize",8)
% title(a2,"PRCP, daily total","FontWeight","bold","FontSize",8)
% title(a3,"ET0, daily total","FontWeight","bold","FontSize",8)

ylabel(a1,"Nash-Stutcliffe Efficiency," + "\bf NSE","FontWeight","normal","FontSize",12)

xlabel(a1,"P_{NSE_{31y}} = "+round(PK_NSE_all.t2mmax(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{31y}} = "+round(PK_NSE_all.t2mmax(PK_NSE_all.Loc=="K"),3),"FontWeight","bold")
xlabel(a2,"P_{NSE_{30y}} = "+round(PK_NSE_all.tp(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{30y}} = "+round(PK_NSE_all.tp(PK_NSE_all.Loc=="K"),3),"FontWeight","bold")
xlabel(a3,"P_{NSE_{31y}} = "+round(PK_NSE_all.et0(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{31y}} = "+round(PK_NSE_all.et0(PK_NSE_all.Loc=="K"),3),"FontWeight","bold")

axis([a1,a2,a3],"tickaligned")
ylim([a1,a2,a3],[-1.5,1])

%% Results stat. parameter KGE

figure(2)
KGEno2003 = PK_KGE_seasonal(PK_KGE_seasonal.Season~="2003",:);

t = tiledlayout(1,3);
% tt = title(t,"Nash-Sutcliffe Efficiency calculated for each Growing Season");
% stt = subtitle(t,"1991 - 2021, Potsdam vs. Kimberley, Obs = Station Data, Pred = ERA5-Land");
% tt.FontWeight = "normal";
% stt.FontWeight ="bold";
% tt.FontSize = 12;
% stt.FontSize = 10;
% t.TileSpacing = "tight";
% t.Padding = "compact";

% Stat1 t2m
a1 = nexttile;
boxchart(PK_KGE_seasonal.Stage,PK_KGE_seasonal.t2mmax, ...
    "GroupByColor",PK_KGE_seasonal.Loc,"Notch","on");
title("daily max."+ "\bf Temperature", "FontWeight","normal","FontSize",11)

% Stat1 tp
a2 = nexttile;
boxchart(KGEno2003.Stage,KGEno2003.tp, ...
    "GroupByColor",KGEno2003.Loc,"Notch","on");
title("daily total"+ "\bf Precipitation", "FontWeight","normal","FontSize",11)

% Stat1 et0
a3 = nexttile;
boxchart(PK_KGE_seasonal.Stage,PK_KGE_seasonal.et0, ...
    "GroupByColor",PK_KGE_seasonal.Loc,"Notch","on");
title("daily total"+ "\bf ET0", "FontWeight","normal","FontSize",11)


grid([a1,a2,a3],"on")
xticklabels([a1,a2,a3],"")
fontsize([a1.YAxis,a2.YAxis,a3.YAxis],8,"points")
fontsize([a1.XAxis,a2.XAxis,a3.XAxis],8,"points")
legend(["Potsdam","Kimberley"], ...
    "Position",[0.5, 0.83, 0.115, 0.08]);

% title(a1,"TEMP, daily mean","FontWeight","bold","FontSize",8)
% title(a2,"PRCP, daily total","FontWeight","bold","FontSize",8)
% title(a3,"ET0, daily total","FontWeight","bold","FontSize",8)

ylabel(a1,"Kling-Gupta Efficiency,"+"\bf KGE","FontWeight","normal","FontSize",12)

xlabel(a1,"P_{KGE_{31y}} = "+round(PK_KGE_all.t2mmax(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{31y}} = "+round(PK_KGE_all.t2mmax(PK_KGE_all.Loc=="K"),3),"FontWeight","bold")
xlabel(a2,"P_{KGE_{30y}} = "+round(PK_KGE_all.tp(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{30y}} = "+round(PK_KGE_all.tp(PK_KGE_all.Loc=="K"),3),"FontWeight","bold")
xlabel(a3,"P_{KGE_{31y}} = "+round(PK_KGE_all.et0(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{31y}} = "+round(PK_KGE_all.et0(PK_KGE_all.Loc=="K"),3),"FontWeight","bold")

axis([a1,a2,a3],"tickaligned")
ylim([a1,a2,a3],[-0.2,1])

%% Results dry yield abs

tiledlayout(1,2,"TileSpacing","tight")

nexttile
a1 = boxchart(acP.DryYield,"GroupByColor",acP.Source,Notch="on");
grid on
a1(1).BoxFaceColor = [0.4940 0.1840 0.5560];
a1(1).MarkerColor = [0.4940 0.1840 0.5560];
a1(2).BoxFaceColor = [0.4660 0.6740 0.1880];
a1(2).MarkerColor = [0.4660 0.6740 0.1880];
ylim([0,20])
ylabel("Dry Yield [t/ha]","Position",[-0.2,10],"FontWeight","normal")
xticklabels({});
xlabel("ERA_{MEAN_{30y}} = "+round(mean(acP.DryYield(acP.Source=="ERA")),3) + " t/ha" ...
    + "     Station_{MEAN_{30y}} = "+round(mean(acP.DryYield(acP.Source=="Station")),3) + " t/ha","FontWeight","bold","FontSize",10)
title("Potsdam, Germany -" + "\bf higher climate station density", "FontWeight","normal","FontSize",11)



nexttile
a2 = boxchart(acK.DryYield,"GroupByColor",acK.Source,Notch="on");
grid on
a2(1).BoxFaceColor = [0.4940 0.1840 0.5560];
a2(1).MarkerColor = [0.4940 0.1840 0.5560];
a2(2).BoxFaceColor = [0.4660 0.6740 0.1880];
a2(2).MarkerColor = [0.4660 0.6740 0.1880];
ylim([0,20])
xticklabels({});
xlabel("ERA_{MEAN_{30y}} = "+round(mean(acK.DryYield(acK.Source=="ERA")),3) + " t/ha" ...
    + "     Station_{MEAN_{30y}} = "+round(mean(acK.DryYield(acK.Source=="Station")),3) + " t/ha","FontWeight","bold","FontSize",10)
title("Kimberley, South Africa -" + "\bf lower climate station density", "FontWeight","normal","FontSize",11)

legend(["ERA5-Land","Station"],Position=[0.35,0.81,0.12,0.1])

%% Results dry yield diff

corrtblP.Loc = categorical([repelem("P",height(corrtblP))]');
corrtblK.Loc = categorical([repelem("K",height(corrtblK))]');

corrtblBOTH = [corrtblP;corrtblK];
corrtblBOTH.group = categorical([repelem("all",height(corrtblBOTH))]');

corrtblBOTH(corrtblBOTH.year==2003,:)=[];

tiledlayout(1,2)

nexttile

boxchart(corrtblBOTH.group,corrtblBOTH.DryYieldDiff,"GroupByColor",corrtblBOTH.Loc,"Notch","on");
xticklabels({});
xlabel("P_{MEAN DIFF_{30y}} = "+round(mean(corrtblBOTH.DryYieldDiff(corrtblBOTH.Loc=="P")),3) + " t/ha" ...
    + "     K_{MEAN DIFF_{30y}} = "+round(mean(corrtblBOTH.DryYieldDiff(corrtblBOTH.Loc=="K")),3) + " t/ha","FontWeight","bold","FontSize",10)

grid on
ylim([0,13])
ylabel("Dry Yield"+"\bf Differnce"+"\rm (abs.) [t/ha]","FontWeight","normal")
title("seasonal"+ "\bf Dry Yield", "FontWeight","normal","FontSize",11)


nexttile

boxchart(corrtblBOTH.group,corrtblBOTH.WaterProdDiff,"GroupByColor",corrtblBOTH.Loc,"Notch","on");
xticklabels({});
xlabel("P_{MEAN DIFF_{30y}} = "+round(mean(corrtblBOTH.WaterProdDiff(corrtblBOTH.Loc=="P")),3) + " kg/m^{3}" ...
    + "     K_{MEAN DIFF_{30y}} = "+round(mean(corrtblBOTH.WaterProdDiff(corrtblBOTH.Loc=="K")),3) + " kg/m^{3}","FontWeight","bold","FontSize",10)

grid on
ylim([0,2.2])
legend(["Potsdam","Kimberley"], ...
    "Position",[0.37,0.81,0.12,0.1]);
ylabel("Water Productivity Differnce (abs.) [kg/m^3]","FontWeight","normal")
title("seasonal"+ "\bf Water Productivity", "FontWeight","normal","FontSize",11)

%% APPENDIX Phase1 all

RMSEno2003 = PK_RMSE_seasonal(PK_RMSE_seasonal.Season~="2003",:);
RRMSEno2003 = PK_RRMSE_seasonal(PK_RRMSE_seasonal.Season~="2003",:);
KGEno2003 = PK_KGE_seasonal(PK_KGE_seasonal.Season~="2003",:);

NSEno2003 = PK_NSE_seasonal(PK_NSE_seasonal.Season~="2003",:);
SPEARno2003 = PK_SPEAR_seasonal(PK_SPEAR_seasonal.Season~="2003",:);

figure(1)

t = tiledlayout(5,3);
tt = title(t,"Statistical Parameters calculated for each Growing Season");
stt = subtitle(t,"1991 - 2021, Potsdam vs. Kimberley, Obs = Station Data, Pred = ERA5-Land");
tt.FontWeight = "normal";
stt.FontWeight ="bold";
tt.FontSize = 12;
stt.FontSize = 10;
t.TileSpacing = "tight";
t.Padding = "compact";

% Stat1 t2m
a1 = nexttile;
boxchart(PK_RMSE_seasonal.Stage,PK_RMSE_seasonal.t2m, ...
    "GroupByColor",PK_RMSE_seasonal.Loc);
% ylim([0,3])
% Stat1 tp
a2 = nexttile;
boxchart(RMSEno2003.Stage,RMSEno2003.tp, ...
    "GroupByColor",RMSEno2003.Loc);
% ylim([0,30])
% Stat1 et0
a3 = nexttile;
boxchart(PK_RMSE_seasonal.Stage,PK_RMSE_seasonal.et0, ...
    "GroupByColor",PK_RMSE_seasonal.Loc);
% ylim([0,3])

% Stat2 t2m
b1 = nexttile;
boxchart(PK_RRMSE_seasonal.Stage,PK_RRMSE_seasonal.t2m, ...
    "GroupByColor",PK_RRMSE_seasonal.Loc);
% ylim([0,0.3])
% Stat2 tp
b2 = nexttile;
boxchart(RRMSEno2003.Stage,RRMSEno2003.tp, ...
    "GroupByColor",RRMSEno2003.Loc);
% ylim([0,1.5])
% Stat2 et0
b3 = nexttile;
boxchart(PK_RRMSE_seasonal.Stage,PK_RRMSE_seasonal.et0, ...
    "GroupByColor",PK_RRMSE_seasonal.Loc);
% ylim([0,0.3])

% Stat3 t2m
c1 = nexttile;
boxchart(PK_NSE_seasonal.Stage,PK_NSE_seasonal.t2m, ...
"GroupByColor",PK_NSE_seasonal.Loc);
% ylim([0.5,1])
% Stat3 tp
c2 = nexttile;
boxchart(NSEno2003.Stage,NSEno2003.tp,...
    "GroupByColor",NSEno2003.Loc); 
% ylim([-0.2,1])
% Stat3 et0
c3 = nexttile;
boxchart(PK_NSE_seasonal.Stage,PK_NSE_seasonal.et0, ...
    "GroupByColor",PK_NSE_seasonal.Loc);
% ylim([0.5,1])

% Stat4 t2m
d1 = nexttile;
boxchart(PK_SPEAR_seasonal.Stage,PK_SPEAR_seasonal.t2m, ...
"GroupByColor",PK_SPEAR_seasonal.Loc);
% ylim([0.5,1])
% Stat4 tp
d2 = nexttile;
boxchart(SPEARno2003.Stage,SPEARno2003.tp,...
    "GroupByColor",SPEARno2003.Loc); 
% ylim([-0.2,1])
% Stat4 et0
d3 = nexttile;
boxchart(PK_SPEAR_seasonal.Stage,PK_SPEAR_seasonal.et0, ...
    "GroupByColor",PK_SPEAR_seasonal.Loc);
% ylim([0.5,1])

% Stat5 t2m
e1 = nexttile;
boxchart(PK_KGE_seasonal.Stage,PK_KGE_seasonal.t2m, ...
"GroupByColor",PK_KGE_seasonal.Loc);
% ylim([0.5,1])
% Stat5 tp
e2 = nexttile;
boxchart(KGEno2003.Stage,KGEno2003.tp,...
    "GroupByColor",KGEno2003.Loc); 
% ylim([-0.2,1])
% Stat5 et0
e3 = nexttile;
boxchart(PK_KGE_seasonal.Stage,PK_KGE_seasonal.et0, ...
    "GroupByColor",PK_KGE_seasonal.Loc);
% ylim([0.5,1])

grid([a1,a2,a3,b1,b2,b3,c1,c2,c3,d1,d2,d3,e1,e2,e3],"minor")
xticklabels([a1,a2,a3,b1,b2,b3,c1,c2,c3,d1,d2,d3,e1,e2,e3],"")
fontsize([a1.YAxis,a2.YAxis,a3.YAxis, ...
    b1.YAxis,b2.YAxis,b3.YAxis, ...
    c1.YAxis,c2.YAxis,c3.YAxis, ...
    d1.YAxis,d2.YAxis,d3.YAxis, ...
    e1.YAxis,e2.YAxis,e3.YAxis, ...
    ],8,"points")
fontsize([a1.XAxis,a2.XAxis,a3.XAxis, ...
    b1.XAxis,b2.XAxis,b3.XAxis, ...
    c1.XAxis,c2.XAxis,c3.XAxis, ...
    d1.XAxis,d2.XAxis,d3.XAxis, ...
    e1.XAxis,e2.XAxis,e3.XAxis, ...
    ],8,"points")
legend(["Potsdam","Kimberley"], ...
    "Position",[0.512, 0.88, 0.13, 0.05]);

title(a1,"TEMP, daily mean","FontWeight","bold","FontSize",8)
title(a2,"PRCP, daily total","FontWeight","bold","FontSize",8)
title(a3,"ET0, daily total","FontWeight","bold","FontSize",8)

ylabel(a1,"RMSE","FontWeight","bold","FontSize",10)
ylabel(b1,"RRMSE","FontWeight","bold","FontSize",10)
ylabel(c1,"NSE","FontWeight","bold","FontSize",10)
ylabel(d1,"SPEAR","FontWeight","bold","FontSize",10)
ylabel(e1,"KGE","FontWeight","bold","FontSize",10)

xlabel(a1,"P_{RMSE_{31y}} = "+round(PK_RMSE_all.t2m(PK_RMSE_all.Loc=="P"),3) ...
    + "   K_{RMSE_{31y}} = "+round(PK_RMSE_all.t2m(PK_RMSE_all.Loc=="K"),3))
xlabel(a2,"P_{RMSE_{30y}} = "+round(PK_RMSE_all.tp(PK_RMSE_all.Loc=="P"),3) ...
    + "   K_{RMSE_{30y}} = "+round(PK_RMSE_all.tp(PK_RMSE_all.Loc=="K"),3))
xlabel(a3,"P_{RMSE_{31y}} = "+round(PK_RMSE_all.et0(PK_RMSE_all.Loc=="P"),3) ...
    + "   K_{RMSE_{31y}} = "+round(PK_RMSE_all.et0(PK_RMSE_all.Loc=="K"),3))
xlabel(b1,"P_{RRMSE_{31y}} = "+round(PK_RRMSE_all.t2m(PK_RRMSE_all.Loc=="P"),3) ...
    + "   K_{RRMSE_{31y}} = "+round(PK_RRMSE_all.t2m(PK_RRMSE_all.Loc=="K"),3))
xlabel(b2,"P_{RRMSE_{30y}} = "+round(PK_RRMSE_all.tp(PK_RRMSE_all.Loc=="P"),3) ...
    + "   K_{RRMSE_{30y}} = "+round(PK_RRMSE_all.tp(PK_RRMSE_all.Loc=="K"),3))
xlabel(b3,"P_{RRMSE_{31y}} = "+round(PK_RRMSE_all.et0(PK_RRMSE_all.Loc=="P"),3) ...
    + "   K_{RRMSE_{31y}} = "+round(PK_RRMSE_all.et0(PK_RRMSE_all.Loc=="K"),3))
xlabel(c1,"P_{NSE_{31y}} = "+round(PK_NSE_all.t2m(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{31y}} = "+round(PK_NSE_all.t2m(PK_NSE_all.Loc=="K"),3))
xlabel(c2,"P_{NSE_{30y}} = "+round(PK_NSE_all.tp(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{30y}} = "+round(PK_NSE_all.tp(PK_NSE_all.Loc=="K"),3))
xlabel(c3,"P_{NSE_{31y}} = "+round(PK_NSE_all.et0(PK_NSE_all.Loc=="P"),3) ...
    + "   K_{NSE_{31y}} = "+round(PK_NSE_all.et0(PK_NSE_all.Loc=="K"),3))
xlabel(d1,"P_{SPEAR_{31y}} = "+round(PK_SPEAR_all.t2m(PK_SPEAR_all.Loc=="P"),3) ...
    + "   K_{SPEAR_{31y}} = "+round(PK_SPEAR_all.t2m(PK_SPEAR_all.Loc=="K"),3))
xlabel(d2,"P_{SPEAR_{30y}} = "+round(PK_SPEAR_all.tp(PK_SPEAR_all.Loc=="P"),3) ...
    + "   K_{SPEAR_{30y}} = "+round(PK_SPEAR_all.tp(PK_SPEAR_all.Loc=="K"),3))
xlabel(d3,"P_{SPEAR_{31y}} = "+round(PK_SPEAR_all.et0(PK_SPEAR_all.Loc=="P"),3) ...
    + "   K_{SPEAR_{31y}} = "+round(PK_SPEAR_all.et0(PK_SPEAR_all.Loc=="K"),3))
xlabel(e1,"P_{KGE_{31y}} = "+round(PK_KGE_all.t2m(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{31y}} = "+round(PK_KGE_all.t2m(PK_KGE_all.Loc=="K"),3))
xlabel(e2,"P_{KGE_{30y}} = "+round(PK_KGE_all.tp(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{30y}} = "+round(PK_KGE_all.tp(PK_KGE_all.Loc=="K"),3))
xlabel(e3,"P_{KGE_{31y}} = "+round(PK_KGE_all.et0(PK_KGE_all.Loc=="P"),3) ...
    + "   K_{KGE_{31y}} = "+round(PK_KGE_all.et0(PK_KGE_all.Loc=="K"),3))


ylim(a1, [0,3])
ylim(a2,10.*a1.YLim)
ylim(b1,[0,0.14])
ylim(b2,10.*b1.YLim)
ylim([c1,e3],[0,1])
ylim(c2,[-2,1])

%% APPENDIX Phase1 per stage

RMSEno2003_sest = PK_RMSE_seasonstage(PK_RMSE_seasonstage.Season~="2003",:);
RRMSEno2003_sest = PK_RRMSE_seasonstage(PK_RRMSE_seasonstage.Season~="2003",:);
NSEno2003_sest = PK_NSE_seasonstage(PK_NSE_seasonstage.Season~="2003",:);
SPEARno2003_sest = PK_SPEAR_seasonstage(PK_SPEAR_seasonstage.Season~="2003",:);
KGEno2003_sest = PK_KGE_seasonstage(PK_KGE_seasonstage.Season~="2003",:);

figure(2)

t = tiledlayout(5,3);
tt = title(t,"Statistical Parameters calculated for each Stage of each Growing Season");
stt = subtitle(t,"1991 - 2021, Potsdam vs. Kimberley, Obs = Station Data, Pred = ERA5-Land");
tt.FontWeight = "normal";
stt.FontWeight ="bold";
tt.FontSize = 12;
stt.FontSize = 10;
t.TileSpacing = "tight";
t.Padding = "compact";

% Stat1 t2m
a1 = nexttile;
boxchart(PK_RMSE_seasonstage.Stage,PK_RMSE_seasonstage.t2m, ...
    "GroupByColor",PK_RMSE_seasonstage.Loc);
% Stat1 tp
a2 = nexttile;
boxchart(RMSEno2003_sest.Stage,RMSEno2003_sest.tp, ...
    "GroupByColor",RMSEno2003_sest.Loc);
% Stat1 et0
a3 = nexttile;
boxchart(PK_RMSE_seasonstage.Stage,PK_RMSE_seasonstage.et0, ...
    "GroupByColor",PK_RMSE_seasonstage.Loc);

% Stat2 t2m
b1 = nexttile;
boxchart(PK_RRMSE_seasonstage.Stage,PK_RRMSE_seasonstage.t2m, ...
    "GroupByColor",PK_RRMSE_seasonstage.Loc);
% Stat2 tp
b2 = nexttile;
boxchart(RRMSEno2003_sest.Stage,RRMSEno2003_sest.tp, ...
    "GroupByColor",RRMSEno2003_sest.Loc);
% Stat2 et0
b3 = nexttile;
boxchart(PK_RRMSE_seasonstage.Stage,PK_RRMSE_seasonstage.et0, ...
    "GroupByColor",PK_RRMSE_seasonstage.Loc);

% Stat3 t2m
c1 = nexttile;
boxchart(PK_NSE_seasonstage.Stage,PK_NSE_seasonstage.t2m, ...
"GroupByColor",PK_NSE_seasonstage.Loc);
% Stat3 tp
c2 = nexttile;
boxchart(NSEno2003_sest.Stage,NSEno2003_sest.tp, ...
    "GroupByColor",NSEno2003_sest.Loc);
% Stat3 et0
c3 = nexttile;
boxchart(PK_NSE_seasonstage.Stage,PK_NSE_seasonstage.et0, ...
    "GroupByColor",PK_NSE_seasonstage.Loc);

% Stat4 t2m
d1 = nexttile;
boxchart(PK_SPEAR_seasonstage.Stage,PK_SPEAR_seasonstage.t2m, ...
"GroupByColor",PK_SPEAR_seasonstage.Loc);
% Stat4 tp
d2 = nexttile;
boxchart(SPEARno2003_sest.Stage,SPEARno2003_sest.tp, ...
    "GroupByColor",SPEARno2003_sest.Loc);
% Stat4 et0
d3 = nexttile;
boxchart(PK_SPEAR_seasonstage.Stage,PK_SPEAR_seasonstage.et0, ...
    "GroupByColor",PK_SPEAR_seasonstage.Loc);

% Stat5 t2m
e1 = nexttile;
boxchart(PK_KGE_seasonstage.Stage,PK_KGE_seasonstage.t2m, ...
"GroupByColor",PK_KGE_seasonstage.Loc);
% Stat5 tp
e2 = nexttile;
boxchart(KGEno2003_sest.Stage,KGEno2003_sest.tp, ...
    "GroupByColor",KGEno2003_sest.Loc);
% Stat5 et0
e3 = nexttile;
boxchart(PK_KGE_seasonstage.Stage,PK_KGE_seasonstage.et0, ...
    "GroupByColor",PK_KGE_seasonstage.Loc);

grid([a1,a2,a3,b1,b2,b3,c1,c2,c3,d1,d2,d3,e1,e2,e3],"minor")
xticklabels([a1,a2,a3,b1,b2,b3,c1,c2,c3,d1,d2,d3,e1,e2,e3],["VE-V8","V8-R1","R1-FM"])
fontsize([a1.YAxis,a2.YAxis,a3.YAxis, ...
    b1.YAxis,b2.YAxis,b3.YAxis, ...
    c1.YAxis,c2.YAxis,c3.YAxis, ...
    d1.YAxis,d2.YAxis,d3.YAxis, ...
    e1.YAxis,e2.YAxis,e3.YAxis, ...
    ],8,"points")
fontsize([a1.XAxis,a2.XAxis,a3.XAxis, ...
    b1.XAxis,b2.XAxis,b3.XAxis, ...
    c1.XAxis,c2.XAxis,c3.XAxis, ...
    d1.XAxis,d2.XAxis,d3.XAxis, ...
    e1.XAxis,e2.XAxis,e3.XAxis, ...
    ],8,"points")
legend(["Potsdam","Kimberley"], ...
    "Position",[0.512, 0.88, 0.13, 0.05]);

title(a1,"TEMP, daily mean","FontWeight","bold","FontSize",8)
title(a2,"PRCP, daily total","FontWeight","bold","FontSize",8)
title(a3,"ET0, daily total","FontWeight","bold","FontSize",8)

ylabel(a1,"RMSE","FontWeight","bold","FontSize",10)
ylabel(b1,"RRMSE","FontWeight","bold","FontSize",10)
ylabel(c1,"NSE","FontWeight","bold","FontSize",10)
ylabel(d1,"SPEAR","FontWeight","bold","FontSize",10)
ylabel(e1,"KGE","FontWeight","bold","FontSize",10)

ylim(c2,[-6,1])
ylim(c3,[-6,1])
ylim(e2,[-2,1])

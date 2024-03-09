%% clear 2003 since errors in Station Data tp (alternatively only exclude fot tp visu)

% PK_RMSE_seasonal = PK_RMSE_seasonal(PK_RMSE_seasonal.Season~="2003",:);
% PK_RRMSE_seasonal = PK_RRMSE_seasonal(PK_RRMSE_seasonal.Season~="2003",:);
% PK_KGE_seasonal = PK_KGE_seasonal(PK_KGE_seasonal.Season~="2003",:);
% PK_SPEAR_seasonal = PK_SPEAR_seasonal(PK_SPEAR_seasonal.Season~="2003",:);
% PK_NSE_seasonal = PK_NSE_seasonal(PK_NSE_seasonal.Season~="2003",:);

%% t2m analysis

pRMSE = ranksum(PK_RMSE_seasonal.t2m(PK_RMSE_seasonal.Loc=="P"),PK_RMSE_seasonal.t2m(PK_RMSE_seasonal.Loc=="K"));

pRRMSE = ranksum(PK_RRMSE_seasonal.t2m(PK_RRMSE_seasonal.Loc=="P"),PK_RRMSE_seasonal.t2m(PK_RRMSE_seasonal.Loc=="K"));

pKGE = ranksum(PK_KGE_seasonal.t2m(PK_KGE_seasonal.Loc=="P"),PK_KGE_seasonal.t2m(PK_KGE_seasonal.Loc=="K"));

pSPEAR = ranksum(PK_SPEAR_seasonal.t2m(PK_SPEAR_seasonal.Loc=="P"),PK_SPEAR_seasonal.t2m(PK_SPEAR_seasonal.Loc=="K"));

pNSE = ranksum(PK_NSE_seasonal.t2m(PK_NSE_seasonal.Loc=="P"),PK_NSE_seasonal.t2m(PK_NSE_seasonal.Loc=="K"));

RESt2m = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% tp analysis

pRMSE = ranksum(RMSEno2003.tp(PK_RMSE_seasonal.Loc=="P"),RMSEno2003.tp(RMSEno2003.Loc=="K"));

pRRMSE = ranksum(RRMSEno2003.tp(PK_RRMSE_seasonal.Loc=="P"),RRMSEno2003.tp(RRMSEno2003.Loc=="K"));

pKGE = ranksum(KGEno2003.tp(PK_KGE_seasonal.Loc=="P"),KGEno2003.tp(KGEno2003.Loc=="K"));

pSPEAR = ranksum(SPEARno2003.tp(PK_SPEAR_seasonal.Loc=="P"),SPEARno2003.tp(SPEARno2003.Loc=="K"));

pNSE = ranksum(NSEno2003.tp(NSEno2003.Loc=="P"),PK_SPEAR_seasonal.tp(NSEno2003.Loc=="K"));

REStp = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% et0 analysis

pRMSE = ranksum(PK_RMSE_seasonal.et0(PK_RMSE_seasonal.Loc=="P"),PK_RMSE_seasonal.et0(PK_RMSE_seasonal.Loc=="K"));

pRRMSE = ranksum(PK_RRMSE_seasonal.et0(PK_RRMSE_seasonal.Loc=="P"),PK_RRMSE_seasonal.et0(PK_RRMSE_seasonal.Loc=="K"));

pKGE = ranksum(PK_KGE_seasonal.et0(PK_KGE_seasonal.Loc=="P"),PK_KGE_seasonal.et0(PK_KGE_seasonal.Loc=="K"));

pSPEAR = ranksum(PK_SPEAR_seasonal.et0(PK_SPEAR_seasonal.Loc=="P"),PK_SPEAR_seasonal.et0(PK_SPEAR_seasonal.Loc=="K"));

pNSE = ranksum(PK_NSE_seasonal.et0(PK_NSE_seasonal.Loc=="P"),PK_NSE_seasonal.et0(PK_NSE_seasonal.Loc=="K"));

RESet0 = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% table creation 

vars = ["t2m","tp","et0"];

WILCtest_pval = table(RESt2m,REStp,RESet0);
WILCtest_pval.Properties.RowNames = ["RMSE","RRMSE","KGE","SPEAR","NSE"]

%% 

[h,pt2mP] = ttest2(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
[h,ptpP] = ttest2(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season~="2003"),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season~="2003"));
[h,pet0P] = ttest2(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

[h,pt2mK] = ttest2(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
[h,ptpK] = ttest2(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season~="2003"));
[h,pet0K] = ttest2(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

P = table(pt2mP,ptpP,pet0P);
P.Properties.VariableNames= ["t2m","tp","et0"]

K = table(pt2mK,ptpK,pet0K);
K.Properties.VariableNames= ["t2m","tp","et0"]
%%

pt2mP = ranksum(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
ptpP = ranksum(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season~="2003"),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season~="2003"));
pet0P = ranksum(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

pt2mK = ranksum(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
ptpK = ranksum(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season~="2003"));
pet0K = ranksum(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

P = table(pt2mP,ptpP,pet0P);
P.Properties.VariableNames= ["t2m","tp","et0"]

K = table(pt2mK,ptpK,pet0K);
K.Properties.VariableNames= ["t2m","tp","et0"]
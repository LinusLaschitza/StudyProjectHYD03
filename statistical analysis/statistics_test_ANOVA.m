%% remove 2003 

% PK_RMSE_seasonal = PK_RMSE_seasonal(PK_RMSE_seasonal.Season~="2003",:);
% PK_RRMSE_seasonal = PK_RRMSE_seasonal(PK_RRMSE_seasonal.Season~="2003",:);
% PK_KGE_seasonal = PK_KGE_seasonal(PK_KGE_seasonal.Season~="2003",:);
% PK_SPEAR_seasonal = PK_SPEAR_seasonal(PK_SPEAR_seasonal.Season~="2003",:);


%% t2m analysis

comp = [PK_RMSE_seasonal.t2m(PK_RMSE_seasonal.Loc=="P"),PK_RMSE_seasonal.t2m(PK_RMSE_seasonal.Loc=="K")];
[pRMSE,tblRMSE,statsRMSE] = anova1(comp);

comp = [PK_RRMSE_seasonal.t2m(PK_RRMSE_seasonal.Loc=="P"),PK_RRMSE_seasonal.t2m(PK_RRMSE_seasonal.Loc=="K")];
[pRRMSE,tblRRMSE,statsRRMSE] = anova1(comp);

comp = [PK_KGE_seasonal.t2m(PK_KGE_seasonal.Loc=="P"),PK_KGE_seasonal.t2m(PK_KGE_seasonal.Loc=="K")];
[pKGE,tblKGE,statsKGE] = anova1(comp);

comp = [PK_SPEAR_seasonal.t2m(PK_SPEAR_seasonal.Loc=="P"),PK_SPEAR_seasonal.t2m(PK_SPEAR_seasonal.Loc=="K")];
[pSPEAR,tblSPEAR,statsSPEAR] = anova1(comp);

comp = [PK_NSE_seasonal.t2m(PK_NSE_seasonal.Loc=="P"),PK_NSE_seasonal.t2m(PK_NSE_seasonal.Loc=="K")];
[pNSE,tblNSE,statsNSE] = anova1(comp);

RESt2m = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% tp analysis

comp = [RMSEno2003.tp(RMSEno2003.Loc=="P"),RMSEno2003.tp(RMSEno2003.Loc=="K")];
[pRMSE,tblRMSE,statsRMSE] = anova1(comp);

comp = [RRMSEno2003.tp(RRMSEno2003.Loc=="P"),RRMSEno2003.tp(RRMSEno2003.Loc=="K")];
[pRRMSE,tblRRMSE,statsRRMSE] = anova1(comp);

comp = [KGEno2003.tp(KGEno2003.Loc=="P"),KGEno2003.tp(KGEno2003.Loc=="K")];
[pKGE,tblKGE,statsKGE] = anova1(comp);

comp = [SPEARno2003.tp(SPEARno2003.Loc=="P"),SPEARno2003.tp(SPEARno2003.Loc=="K")];
[pSPEAR,tblSPEAR,statsSPEAR] = anova1(comp);

comp = [NSEno2003.tp(NSEno2003.Loc=="P"),NSEno2003.tp(NSEno2003.Loc=="K")];
[pNSE,tblNSE,statsNSE] = anova1(comp);

REStp = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% et0 analysis

comp = [PK_RMSE_seasonal.et0(PK_RMSE_seasonal.Loc=="P"),PK_RMSE_seasonal.et0(PK_RMSE_seasonal.Loc=="K")];
[pRMSE,tblRMSE,statsRMSE] = anova1(comp);

comp = [PK_RRMSE_seasonal.et0(PK_RRMSE_seasonal.Loc=="P"),PK_RRMSE_seasonal.et0(PK_RRMSE_seasonal.Loc=="K")];
[pRRMSE,tblRRMSE,statsRRMSE] = anova1(comp);

comp = [PK_KGE_seasonal.et0(PK_KGE_seasonal.Loc=="P"),PK_KGE_seasonal.et0(PK_KGE_seasonal.Loc=="K")];
[pKGE,tblKGE,statsKGE] = anova1(comp);

comp = [PK_SPEAR_seasonal.et0(PK_SPEAR_seasonal.Loc=="P"),PK_SPEAR_seasonal.et0(PK_SPEAR_seasonal.Loc=="K")];
[pSPEAR,tblSPEAR,statsSPEAR] = anova1(comp);

comp = [PK_NSE_seasonal.et0(PK_NSE_seasonal.Loc=="P"),PK_NSE_seasonal.et0(PK_NSE_seasonal.Loc=="K")];
[pNSE,tblNSE,statsNSE] = anova1(comp);

RESet0 = [pRMSE;
    pRRMSE;
    pKGE;
    pSPEAR;
    pNSE];

%% table creation 

vars = ["t2m","tp","et0"];

ANOVAtest_pval = table(RESt2m,REStp,RESet0);
ANOVAtest_pval.Properties.RowNames = ["RMSE","RRMSE","KGE","SPEAR","NSE"]
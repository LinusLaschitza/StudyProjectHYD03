%% read excel tables 

inP = readtable("AquaCrop_results_for_MATLAB.xlsx",Range="A3:A156");
inP = table2array(inP);

inK = readtable("AquaCrop_results_for_MATLAB.xlsx",Range="B3:B156");
inK = table2array(inK);

%% indexing 

idxBiomass = 1:5:154;
idxDryYield = idxBiomass+1;
idxWaterProd = idxBiomass+2;

%% read biomas and dry yield differences

t = [2021:-1:1991]';

corrtblP = table(t,inP(idxBiomass),inP(idxDryYield),inP(idxWaterProd));
corrtblP.Properties.VariableNames = ["year","BiomassDiff","DryYieldDiff","WaterProdDiff"];

corrtblK = table(t,inK(idxBiomass),inK(idxDryYield),inK(idxWaterProd));
corrtblK.Properties.VariableNames = ["year","BiomassDiff","DryYieldDiff","WaterProdDiff"];


%% corr analysis / visualization NSE DryYield (after running stat parmeter script (here NSE))

K_NSE_seasonal = PK_NSE_seasonal(PK_NSE_seasonal.Loc=="K",:);
K_NSE_seasonal = sortrows(K_NSE_seasonal,"Season","descend");

corrtblK = [corrtblK,K_NSE_seasonal];
corrtblK = corrtblK(corrtblK.Season~="2003",:);

[KcorrYieldTMEAN,pvalt2m] = corr(corrtblK.DryYieldDiff,corrtblK.t2m,"type","Pearson")
[KcorrYieldPRCP,pvaltp] = corr(corrtblK.DryYieldDiff,corrtblK.tp,"type","Pearson")
[KcorrYieldET0,pvalet0] = corr(corrtblK.DryYieldDiff,corrtblK.et0,"type","Pearson")

lm = fitlm(corrtblK.DryYieldDiff,corrtblK.et0);
p = plot(lm)
legend("Scatter NSE / Dry Yield","Fit", "Confidence Bounds", ...
    Location="southwest")
title("")
% title("Correlation of ET0-error and Dry Yield Difference")
% subtitle("Error and Difference relates to Comparison between Station & ERA5-Land data")
ylabel("Nash-Sutcliffe Efficiency ET0 [-]","FontWeight","bold")
xlabel("Dry Yield Difference [ton/ha]","FontWeight","bold")
t1= text(0.4,-1.05,"corr_{PEARSON}       = "+KcorrYieldET0);
t2= text(0.4,-1.17,"p-value_{PEARSON} = "+pvalet0);
t1.FontSize = 9;
t2.FontSize = 9;

%% corr analysis / visualization NSE DryYield (after running stat parmeter script (here KGE))

K_KGE_seasonal = PK_KGE_seasonal(PK_KGE_seasonal.Loc=="K",:);
K_KGE_seasonal = sortrows(K_KGE_seasonal,"Season","descend");

corrtblK = [corrtblK,K_KGE_seasonal];

[KcorrYieldTMEAN,pvalt2m] = corr(corrtblK.DryYieldDiff,corrtblK.t2m,"type","Pearson");
[KcorrYieldPRCP,pvaltp] = corr(corrtblK.DryYieldDiff,corrtblK.tp,"type","Pearson");
[KcorrYieldET0,pvalet0] = corr(corrtblK.DryYieldDiff,corrtblK.et0,"type","Pearson");

lm = fitlm(corrtblK.DryYieldDiff,corrtblK.et0);
p = plot(lm);
legend("Scatter KGE / Dry Yield","Fit", "Confidence Bounds", ...
    Location="northeast")
title("Correlation of ET0-error and Dry Yield Difference")
subtitle("Error and Difference relates to Comparison between Station & ERA5-Land data")
ylabel("Kling-Gupta Efficiency ET0 [-]")
xlabel("Dry Yield Difference [ton/ha]")
t1= text(8.2,0.72,"corr_{PEARSON}       = "+KcorrYieldET0);
t2= text(8.2,0.695,"p-value_{PEARSON}  = "+pvalet0);
t1.FontSize = 9;
t2.FontSize = 9;




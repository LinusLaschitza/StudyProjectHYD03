%% goal is to calculate compareable statistical parameters
% for both datasets. Initially the NaN values in the Kimberly set need to
% be removes as well as the respecive rows in the Potsdam data set. 
%
% Initially the Kimberley dataset has: 
% 11 t2m & et0 missing values
% 106 tp missing values 
% If we assume that there are now rows with missing values left after
% removing the 106 missing tp rows, we will generate 2 datasets (one for
% each location) with 4030 minus 106 (= 3924) rows, which are ready for the
% statistical analysis. 
% 
% For the statistical analysis we will calculate stat. parameteres (RMSE,
% MAPE(?) and KGE) for both datasets over 1. the whole time period, 2. for
% each season 3. for each stage of the growing cyle, 4. yearly for each 
% stage of the growing cyle . Finally these parameters
% will be compared in boxcharts. 
%
% The MAPE parameter might get replaced by another dimensionless parameter 
% that describes the relative deviation between model and observation. 

% load("Potsdam_31y_dog.mat")
% load("Kimberley_31y_dog.mat")

%% identify rows with missing data in Kimberley set
%  ...remove those rows
%  remove the same rows in the Potsdam dataset

K_NaN = ismissing(Kimberley_31y_dog.tpStation);
Kimberley_31y_dog(K_NaN,:) = [];
Potsdam_31y_dog(K_NaN,:) = [];
Kimberley_31y_dog.Season = categorical(Kimberley_31y_dog.Season);

K_NaN_v2 = ismissing(Kimberley_31y_dog.et0Station);
Kimberley_31y_dog(K_NaN_v2,:) = [];
Potsdam_31y_dog(K_NaN_v2,:) = [];

%% 1.1 Statistics KGE, whole time series

p_kge_all = zeros([1,5]);

p_kge_all(1) = kge(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
p_kge_all(2) = kge(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.t2mminStation);
p_kge_all(3) = kge(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.t2mmaxStation);
p_kge_all(4) = kge(Potsdam_31y_dog.tpERA,Potsdam_31y_dog.tpStation);
p_kge_all(5) = kge(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

k_kge_all = zeros([1,5]);

k_kge_all(1) = kge(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
k_kge_all(2) = kge(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.t2mminStation);
k_kge_all(3) = kge(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.t2mmaxStation);
k_kge_all(4) = kge(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season~="2003"));
k_kge_all(5) = kge(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

%% 1.2 Statistics KGE, for each season

p_kge_seasonal = zeros([31,5]);

for i = 1991:2021
    p_kge_seasonal(i-1990,1) = kge(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season==categorical(i)));
    p_kge_seasonal(i-1990,2) = kge(Potsdam_31y_dog.t2mminERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mminStation(Potsdam_31y_dog.Season==categorical(i)));
    p_kge_seasonal(i-1990,3) = kge(Potsdam_31y_dog.t2mmaxERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mmaxStation(Potsdam_31y_dog.Season==categorical(i)));
    p_kge_seasonal(i-1990,4) = kge(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Season==categorical(i)));
    p_kge_seasonal(i-1990,5) = kge(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Season==categorical(i)));
end

k_kge_seasonal = zeros([31,5]);

for i = 1991:2021
    k_kge_seasonal(i-1990,1) = kge(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season==categorical(i)));
    k_kge_seasonal(i-1990,2) = kge(Kimberley_31y_dog.t2mminERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mminStation(Kimberley_31y_dog.Season==categorical(i)));
    k_kge_seasonal(i-1990,3) = kge(Kimberley_31y_dog.t2mmaxERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mmaxStation(Kimberley_31y_dog.Season==categorical(i)));
    k_kge_seasonal(i-1990,4) = kge(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season==categorical(i)));
    k_kge_seasonal(i-1990,5) = kge(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Season==categorical(i)));
end

%% 1.3 Statistics KGE, for each stage of the growing cyle (not used)

% p_kge_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     p_kge_stage(i,1) = kge(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_kge_stage(i,2) = kge(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_kge_stage(i,3) = kge(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Stage==stages(i)));
% end
% 
% k_kge_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     k_kge_stage(i,1) = kge(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_kge_stage(i,2) = kge(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_kge_stage(i,3) = kge(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Stage==stages(i)));
% end

%% 1.4 Statistics KGE, yearly for each stage of the growing cyle

p_kge_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Potsdam_31y_dog(Potsdam_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            p_kge_seasonstage(start+y-1991,1) = kge(subseason.t2mERA,subseason.t2mStation);
            p_kge_seasonstage(start+y-1991,2) = kge(subseason.t2mminERA,subseason.t2mminStation);
            p_kge_seasonstage(start+y-1991,3) = kge(subseason.t2mmaxERA,subseason.t2mmaxStation);            
            p_kge_seasonstage(start+y-1991,4) = kge(subseason.tpERA,subseason.tpStation);
            p_kge_seasonstage(start+y-1991,5) = kge(subseason.et0ERA,subseason.et0Station);
            
        end

end

k_kge_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Kimberley_31y_dog(Kimberley_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            k_kge_seasonstage(start+y-1991,1) = kge(subseason.t2mERA,subseason.t2mStation);
            k_kge_seasonstage(start+y-1991,2) = kge(subseason.t2mminERA,subseason.t2mminStation);
            k_kge_seasonstage(start+y-1991,3) = kge(subseason.t2mmaxERA,subseason.t2mmaxStation);
            k_kge_seasonstage(start+y-1991,4) = kge(subseason.tpERA,subseason.tpStation);
            k_kge_seasonstage(start+y-1991,5) = kge(subseason.et0ERA,subseason.et0Station);
            
        end

end
%% combine results in tables 

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

P_KGE_all = table(p_kge_all(:,1),p_kge_all(:,2),p_kge_all(:,3),p_kge_all(:,4),p_kge_all(:,5));
P_KGE_all.Properties.VariableNames = varnames;
P_KGE_all.Season = "all";
P_KGE_all.Stage = "all";

P_KGE_seasonal = table(p_kge_seasonal(:,1),p_kge_seasonal(:,2),p_kge_seasonal(:,3),p_kge_seasonal(:,4),p_kge_seasonal(:,5));
P_KGE_seasonal.Properties.VariableNames = varnames;
P_KGE_seasonal.Season = [1991:2021]';
P_KGE_seasonal.Stage = repelem(["all"],31)';

% P_KGE_stage = table(p_kge_stage(:,1),p_kge_stage(:,2),p_kge_stage(:,3));
% P_KGE_stage.Properties.VariableNames = varnames;
% P_KGE_stage.Season = repelem(["all"],3)';
% P_KGE_stage.Stage = stages';

P_KGE_seasonstage = table(p_kge_seasonstage(:,1),p_kge_seasonstage(:,2),p_kge_seasonstage(:,3),p_kge_seasonstage(:,4),p_kge_seasonstage(:,5));
P_KGE_seasonstage.Properties.VariableNames = varnames;
P_KGE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    P_KGE_seasonstage.Season(P_KGE_seasonstage.Stage==stages(s)) = 1991:2021;
end

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

K_KGE_all = table(k_kge_all(:,1),k_kge_all(:,2),k_kge_all(:,3),k_kge_all(:,4),k_kge_all(:,5));
K_KGE_all.Properties.VariableNames = varnames;
K_KGE_all.Season = "all";
K_KGE_all.Stage = "all";

K_KGE_seasonal = table(k_kge_seasonal(:,1),k_kge_seasonal(:,2),k_kge_seasonal(:,3),k_kge_seasonal(:,4),k_kge_seasonal(:,5));
K_KGE_seasonal.Properties.VariableNames = varnames;
K_KGE_seasonal.Season = [1991:2021]';
K_KGE_seasonal.Stage = repelem(["all"],31)';

% K_KGE_stage = table(k_kge_stage(:,1),k_kge_stage(:,2),k_kge_stage(:,3));
% K_KGE_stage.Properties.VariableNames = varnames;
% K_KGE_stage.Season = repelem(["all"],3)';
% K_KGE_stage.Stage = stages';

K_KGE_seasonstage = table(k_kge_seasonstage(:,1),k_kge_seasonstage(:,2),k_kge_seasonstage(:,3),k_kge_seasonstage(:,4),k_kge_seasonstage(:,5));
K_KGE_seasonstage.Properties.VariableNames = varnames;
K_KGE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    K_KGE_seasonstage.Season(K_KGE_seasonstage.Stage==stages(s)) = 1991:2021;
end

%% clean up 

clear i stages varnames p_kge_seasonstage p_kge_stage p_kge_seasonal p_kge_all subseason start substage y s K_NaN
clear k_kge_seasonstage k_kge_stage k_kge_seasonal k_kge_all

%% combine both stat tables with unique location variable for grouping

P_KGE_all.Loc = categorical(repelem("P",1)');
K_KGE_all.Loc = categorical(repelem("K",1)');

PK_KGE_all =  [P_KGE_all; K_KGE_all];
PK_KGE_all.Stage = categorical(PK_KGE_all.Stage);
PK_KGE_all.Loc = categorical(PK_KGE_all.Loc);
PK_KGE_all.Season = categorical(PK_KGE_all.Season);

P_KGE_seasonal.Loc = categorical(repelem("P",length(P_KGE_seasonal.t2m))');
K_KGE_seasonal.Loc = categorical(repelem("K",length(K_KGE_seasonal.t2m))');

PK_KGE_seasonal =  [P_KGE_seasonal; K_KGE_seasonal];
PK_KGE_seasonal.Stage = categorical(PK_KGE_seasonal.Stage);
PK_KGE_seasonal.Loc = categorical(PK_KGE_seasonal.Loc);
PK_KGE_seasonal.Season = categorical(PK_KGE_seasonal.Season);

P_KGE_seasonstage.Loc = categorical(repelem("P",length(P_KGE_seasonstage.t2m))');
K_KGE_seasonstage.Loc = categorical(repelem("K",length(K_KGE_seasonstage.t2m))');

PK_KGE_seasonstage =  [P_KGE_seasonstage; K_KGE_seasonstage];
PK_KGE_seasonstage.Stage = categorical(PK_KGE_seasonstage.Stage);
PK_KGE_seasonstage.Loc = categorical(PK_KGE_seasonstage.Loc);
PK_KGE_seasonstage.Season = categorical(PK_KGE_seasonstage.Season);

%% clean up

clear K_KGE_stage K_KGE_seasonstage K_KGE_seasonal K_KGE_all
clear P_KGE_stage P_KGE_seasonstage P_KGE_seasonal P_KGE_all

%%

function [kge,r,relvar,bias] = kge(modelled,observed)
%Nash Sutcliffe Efficiency measure
modelled(isnan(observed))=NaN;

cflow=[modelled,observed];

sdmodelled=std(modelled);
sdobserved=std(observed);
 
mmodelled=mean(modelled);
mobserved=mean(observed);

r=corrcoef(cflow,'rows','pairwise'); r=r(1,2);
relvar=sdmodelled/sdobserved;
bias=mmodelled/mobserved;

%KGE timeseries 
kge=1-  sqrt( ((r-1)^2) + ((relvar-1)^2)  + ((bias-1)^2) );
 
end




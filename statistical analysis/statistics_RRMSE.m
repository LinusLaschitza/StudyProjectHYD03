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

%% 1.1 Statistics RRMSE, whole time series

p_rrmse_all = zeros([1,5]);

p_rrmse_all(1) = rrmse(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
p_rrmse_all(2) = rrmse(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.t2mminStation);
p_rrmse_all(3) = rrmse(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.t2mmaxStation);
p_rrmse_all(4) = rrmse(Potsdam_31y_dog.tpERA,Potsdam_31y_dog.tpStation);
p_rrmse_all(5) = rrmse(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

k_rrmse_all = zeros([1,5]);

k_rrmse_all(1) = rrmse(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
k_rrmse_all(2) = rrmse(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.t2mminStation);
k_rrmse_all(3) = rrmse(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.t2mmaxStation);
k_rrmse_all(4) = rrmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season~="2003"));
k_rrmse_all(5) = rrmse(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

%% 1.2 Statistics RRMSE, for each season

p_rrmse_seasonal = zeros([31,5]);

for i = 1991:2021
    p_rrmse_seasonal(i-1990,1) = rrmse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rrmse_seasonal(i-1990,2) = rrmse(Potsdam_31y_dog.t2mminERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mminStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rrmse_seasonal(i-1990,3) = rrmse(Potsdam_31y_dog.t2mmaxERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mmaxStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rrmse_seasonal(i-1990,4) = rrmse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rrmse_seasonal(i-1990,5) = rrmse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Season==categorical(i)));
end

k_rrmse_seasonal = zeros([31,5]);

for i = 1991:2021
    k_rrmse_seasonal(i-1990,1) = rrmse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rrmse_seasonal(i-1990,2) = rrmse(Kimberley_31y_dog.t2mminERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mminStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rrmse_seasonal(i-1990,3) = rrmse(Kimberley_31y_dog.t2mmaxERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mmaxStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rrmse_seasonal(i-1990,4) = rrmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rrmse_seasonal(i-1990,5) = rrmse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Season==categorical(i)));
end

%% 1.3 Statistics RRMSE, for each stage of the growing cyle (not used)

% p_rrmse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     p_rrmse_stage(i,1) = rrmse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_rrmse_stage(i,2) = rrmse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_rrmse_stage(i,3) = rrmse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Stage==stages(i)));
% end
% 
% k_rrmse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     k_rrmse_stage(i,1) = rrmse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_rrmse_stage(i,2) = rrmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_rrmse_stage(i,3) = rrmse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Stage==stages(i)));
% end

%% 1.4 Statistics RRMSE, yearly for each stage of the growing cyle

p_rrmse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Potsdam_31y_dog(Potsdam_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            p_rrmse_seasonstage(start+y-1991,1) = rrmse(subseason.t2mERA,subseason.t2mStation);
            p_rrmse_seasonstage(start+y-1991,2) = rrmse(subseason.t2mminERA,subseason.t2mminStation);
            p_rrmse_seasonstage(start+y-1991,3) = rrmse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            p_rrmse_seasonstage(start+y-1991,4) = rrmse(subseason.tpERA,subseason.tpStation);
            p_rrmse_seasonstage(start+y-1991,5) = rrmse(subseason.et0ERA,subseason.et0Station);
            
        end

end

k_rrmse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Kimberley_31y_dog(Kimberley_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            k_rrmse_seasonstage(start+y-1991,1) = rrmse(subseason.t2mERA,subseason.t2mStation);
            k_rrmse_seasonstage(start+y-1991,2) = rrmse(subseason.t2mminERA,subseason.t2mminStation);
            k_rrmse_seasonstage(start+y-1991,3) = rrmse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            k_rrmse_seasonstage(start+y-1991,4) = rrmse(subseason.tpERA,subseason.tpStation);
            k_rrmse_seasonstage(start+y-1991,5) = rrmse(subseason.et0ERA,subseason.et0Station);
            
        end

end
%% combine results in tables 

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

P_RRMSE_all = table(p_rrmse_all(:,1),p_rrmse_all(:,2),p_rrmse_all(:,3),p_rrmse_all(:,4),p_rrmse_all(:,5));
P_RRMSE_all.Properties.VariableNames = varnames;
P_RRMSE_all.Season = "all";
P_RRMSE_all.Stage = "all";

P_RRMSE_seasonal = table(p_rrmse_seasonal(:,1),p_rrmse_seasonal(:,2),p_rrmse_seasonal(:,3),p_rrmse_seasonal(:,4),p_rrmse_seasonal(:,5));
P_RRMSE_seasonal.Properties.VariableNames = varnames;
P_RRMSE_seasonal.Season = [1991:2021]';
P_RRMSE_seasonal.Stage = repelem(["all"],31)';

% P_RRMSE_stage = table(p_rrmse_stage(:,1),p_rrmse_stage(:,2),p_rrmse_stage(:,3));
% P_RRMSE_stage.Properties.VariableNames = varnames;
% P_RRMSE_stage.Season = repelem(["all"],3)';
% P_RRMSE_stage.Stage = stages';

P_RRMSE_seasonstage = table(p_rrmse_seasonstage(:,1),p_rrmse_seasonstage(:,2),p_rrmse_seasonstage(:,3),p_rrmse_seasonstage(:,4),p_rrmse_seasonstage(:,5));
P_RRMSE_seasonstage.Properties.VariableNames = varnames;
P_RRMSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    P_RRMSE_seasonstage.Season(P_RRMSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

K_RRMSE_all = table(k_rrmse_all(:,1),k_rrmse_all(:,2),k_rrmse_all(:,3),k_rrmse_all(:,4),k_rrmse_all(:,5));
K_RRMSE_all.Properties.VariableNames = varnames;
K_RRMSE_all.Season = "all";
K_RRMSE_all.Stage = "all";

K_RRMSE_seasonal = table(k_rrmse_seasonal(:,1),k_rrmse_seasonal(:,2),k_rrmse_seasonal(:,3),k_rrmse_seasonal(:,4),k_rrmse_seasonal(:,5));
K_RRMSE_seasonal.Properties.VariableNames = varnames;
K_RRMSE_seasonal.Season = [1991:2021]';
K_RRMSE_seasonal.Stage = repelem(["all"],31)';

% K_RRMSE_stage = table(k_rrmse_stage(:,1),k_rrmse_stage(:,2),k_rrmse_stage(:,3));
% K_RRMSE_stage.Properties.VariableNames = varnames;
% K_RRMSE_stage.Season = repelem(["all"],3)';
% K_RRMSE_stage.Stage = stages';

K_RRMSE_seasonstage = table(k_rrmse_seasonstage(:,1),k_rrmse_seasonstage(:,2),k_rrmse_seasonstage(:,3),k_rrmse_seasonstage(:,4),k_rrmse_seasonstage(:,5));
K_RRMSE_seasonstage.Properties.VariableNames = varnames;
K_RRMSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    K_RRMSE_seasonstage.Season(K_RRMSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

%% clean up 

clear i stages varnames p_rrmse_seasonstage p_rrmse_stage p_rrmse_seasonal p_rrmse_all subseason start substage y s K_NaN
clear k_rrmse_seasonstage k_rrmse_stage k_rrmse_seasonal k_rrmse_all

%% combine both stat tables with unique location variable for grouping

P_RRMSE_all.Loc = categorical(repelem("P",1)');
K_RRMSE_all.Loc = categorical(repelem("K",1)');

PK_RRMSE_all =  [P_RRMSE_all; K_RRMSE_all];
PK_RRMSE_all.Stage = categorical(PK_RRMSE_all.Stage);
PK_RRMSE_all.Loc = categorical(PK_RRMSE_all.Loc);
PK_RRMSE_all.Season = categorical(PK_RRMSE_all.Season);

P_RRMSE_seasonal.Loc = categorical(repelem("P",length(P_RRMSE_seasonal.t2m))');
K_RRMSE_seasonal.Loc = categorical(repelem("K",length(K_RRMSE_seasonal.t2m))');

PK_RRMSE_seasonal =  [P_RRMSE_seasonal; K_RRMSE_seasonal];
PK_RRMSE_seasonal.Stage = categorical(PK_RRMSE_seasonal.Stage);
PK_RRMSE_seasonal.Loc = categorical(PK_RRMSE_seasonal.Loc);
PK_RRMSE_seasonal.Season = categorical(PK_RRMSE_seasonal.Season);

P_RRMSE_seasonstage.Loc = categorical(repelem("P",length(P_RRMSE_seasonstage.t2m))');
K_RRMSE_seasonstage.Loc = categorical(repelem("K",length(K_RRMSE_seasonstage.t2m))');

PK_RRMSE_seasonstage =  [P_RRMSE_seasonstage; K_RRMSE_seasonstage];
PK_RRMSE_seasonstage.Stage = categorical(PK_RRMSE_seasonstage.Stage);
PK_RRMSE_seasonstage.Loc = categorical(PK_RRMSE_seasonstage.Loc);
PK_RRMSE_seasonstage.Season = categorical(PK_RRMSE_seasonstage.Season);

%% clean up

clear K_RRMSE_stage K_RRMSE_seasonstage K_RRMSE_seasonal K_RRMSE_all
clear P_RRMSE_stage P_RRMSE_seasonstage P_RRMSE_seasonal P_RRMSE_all

%%
function rrmse = rrmse(pred,obs) % rmse normalized by mean of values in considered timer period

a = rmse(pred,obs);
    rrmse = a/mean(obs(obs>1)); % for tp -> nomalized by mean P amount of WET DAYS (>1mm)  
end





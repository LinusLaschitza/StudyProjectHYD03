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

%% 1.1 Statistics RMSE, whole time series

p_rmse_all = zeros([1,5]);

p_rmse_all(1) = rmse(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
p_rmse_all(2) = rmse(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.t2mminStation);
p_rmse_all(3) = rmse(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.t2mmaxStation);
p_rmse_all(4) = rmse(Potsdam_31y_dog.tpERA,Potsdam_31y_dog.tpStation);
p_rmse_all(5) = rmse(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

k_rmse_all = zeros([1,5]);

k_rmse_all(1) = rmse(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
k_rmse_all(2) = rmse(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.t2mminStation);
k_rmse_all(3) = rmse(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.t2mmaxStation);
k_rmse_all(4) = rmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season~="2003"));
k_rmse_all(5) = rmse(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

%% 1.2 Statistics RMSE, for each season

p_rmse_seasonal = zeros([31,5]);

for i = 1991:2021
    p_rmse_seasonal(i-1990,1) = rmse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rmse_seasonal(i-1990,2) = rmse(Potsdam_31y_dog.t2mminERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mminStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rmse_seasonal(i-1990,3) = rmse(Potsdam_31y_dog.t2mmaxERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mmaxStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rmse_seasonal(i-1990,4) = rmse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Season==categorical(i)));
    p_rmse_seasonal(i-1990,5) = rmse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Season==categorical(i)));
end

k_rmse_seasonal = zeros([31,5]);

for i = 1991:2021
    k_rmse_seasonal(i-1990,1) = rmse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rmse_seasonal(i-1990,2) = rmse(Kimberley_31y_dog.t2mminERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mminStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rmse_seasonal(i-1990,3) = rmse(Kimberley_31y_dog.t2mmaxERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mmaxStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rmse_seasonal(i-1990,4) = rmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season==categorical(i)));
    k_rmse_seasonal(i-1990,5) = rmse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Season==categorical(i)));
end

%% 1.3 Statistics RMSE, for each stage of the growing cyle (not used) (not adapted for Tmin & Tmax)

% p_rmse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     p_rmse_stage(i,1) = rmse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_rmse_stage(i,2) = rmse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_rmse_stage(i,3) = rmse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Stage==stages(i)));
% end
% 
% k_rmse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     k_rmse_stage(i,1) = rmse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_rmse_stage(i,2) = rmse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_rmse_stage(i,3) = rmse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Stage==stages(i)));
% end

%% 1.4 Statistics RMSE, yearly for each stage of the growing cyle

p_rmse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Potsdam_31y_dog(Potsdam_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            p_rmse_seasonstage(start+y-1991,1) = rmse(subseason.t2mERA,subseason.t2mStation);
            p_rmse_seasonstage(start+y-1991,2) = rmse(subseason.t2mminERA,subseason.t2mminStation);
            p_rmse_seasonstage(start+y-1991,3) = rmse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            p_rmse_seasonstage(start+y-1991,4) = rmse(subseason.tpERA,subseason.tpStation);
            p_rmse_seasonstage(start+y-1991,5) = rmse(subseason.et0ERA,subseason.et0Station);
            
        end

end

k_rmse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Kimberley_31y_dog(Kimberley_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            k_rmse_seasonstage(start+y-1991,1) = rmse(subseason.t2mERA,subseason.t2mStation);
            k_rmse_seasonstage(start+y-1991,2) = rmse(subseason.t2mminERA,subseason.t2mminStation);
            k_rmse_seasonstage(start+y-1991,3) = rmse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            k_rmse_seasonstage(start+y-1991,4) = rmse(subseason.tpERA,subseason.tpStation);
            k_rmse_seasonstage(start+y-1991,5) = rmse(subseason.et0ERA,subseason.et0Station);
            
        end

end
%% combine results in tables 

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

P_RMSE_all = table(p_rmse_all(:,1),p_rmse_all(:,2),p_rmse_all(:,3),p_rmse_all(:,4),p_rmse_all(:,5));
P_RMSE_all.Properties.VariableNames = varnames;
P_RMSE_all.Season = "all";
P_RMSE_all.Stage = "all";

P_RMSE_seasonal = table(p_rmse_seasonal(:,1),p_rmse_seasonal(:,2),p_rmse_seasonal(:,3),p_rmse_seasonal(:,4),p_rmse_seasonal(:,5));
P_RMSE_seasonal.Properties.VariableNames = varnames;
P_RMSE_seasonal.Season = [1991:2021]';
P_RMSE_seasonal.Stage = repelem(["all"],31)';

% P_RMSE_stage = table(p_rmse_stage(:,1),p_rmse_stage(:,2),p_rmse_stage(:,3));
% P_RMSE_stage.Properties.VariableNames = varnames;
% P_RMSE_stage.Season = repelem(["all"],3)';
% P_RMSE_stage.Stage = stages';

P_RMSE_seasonstage = table(p_rmse_seasonstage(:,1),p_rmse_seasonstage(:,2),p_rmse_seasonstage(:,3),p_rmse_seasonstage(:,4),p_rmse_seasonstage(:,5));
P_RMSE_seasonstage.Properties.VariableNames = varnames;
P_RMSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    P_RMSE_seasonstage.Season(P_RMSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

K_RMSE_all = table(k_rmse_all(:,1),k_rmse_all(:,2),k_rmse_all(:,3),k_rmse_all(:,4),k_rmse_all(:,5));
K_RMSE_all.Properties.VariableNames = varnames;
K_RMSE_all.Season = "all";
K_RMSE_all.Stage = "all";

K_RMSE_seasonal = table(k_rmse_seasonal(:,1),k_rmse_seasonal(:,2),k_rmse_seasonal(:,3),k_rmse_seasonal(:,4),k_rmse_seasonal(:,5));
K_RMSE_seasonal.Properties.VariableNames = varnames;
K_RMSE_seasonal.Season = [1991:2021]';
K_RMSE_seasonal.Stage = repelem(["all"],31)';

% K_RMSE_stage = table(k_rmse_stage(:,1),k_rmse_stage(:,2),k_rmse_stage(:,3));
% K_RMSE_stage.Properties.VariableNames = varnames;
% K_RMSE_stage.Season = repelem(["all"],3)';
% K_RMSE_stage.Stage = stages';

K_RMSE_seasonstage = table(k_rmse_seasonstage(:,1),k_rmse_seasonstage(:,2),k_rmse_seasonstage(:,3),k_rmse_seasonstage(:,4),k_rmse_seasonstage(:,5));
K_RMSE_seasonstage.Properties.VariableNames = varnames;
K_RMSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    K_RMSE_seasonstage.Season(K_RMSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

%% clean up 

clear i stages varnames p_rmse_seasonstage p_rmse_stage p_rmse_seasonal p_rmse_all subseason start substage y s K_NaN
clear k_rmse_seasonstage k_rmse_stage k_rmse_seasonal k_rmse_all

%% combine both stat tables with unique location variable for grouping

P_RMSE_all.Loc = categorical(repelem("P",1)');
K_RMSE_all.Loc = categorical(repelem("K",1)');

PK_RMSE_all =  [P_RMSE_all; K_RMSE_all];
PK_RMSE_all.Stage = categorical(PK_RMSE_all.Stage);
PK_RMSE_all.Loc = categorical(PK_RMSE_all.Loc);
PK_RMSE_all.Season = categorical(PK_RMSE_all.Season);

P_RMSE_seasonal.Loc = categorical(repelem("P",length(P_RMSE_seasonal.t2m))');
K_RMSE_seasonal.Loc = categorical(repelem("K",length(K_RMSE_seasonal.t2m))');

PK_RMSE_seasonal =  [P_RMSE_seasonal; K_RMSE_seasonal];
PK_RMSE_seasonal.Stage = categorical(PK_RMSE_seasonal.Stage);
PK_RMSE_seasonal.Loc = categorical(PK_RMSE_seasonal.Loc);
PK_RMSE_seasonal.Season = categorical(PK_RMSE_seasonal.Season);

P_RMSE_seasonstage.Loc = categorical(repelem("P",length(P_RMSE_seasonstage.t2m))');
K_RMSE_seasonstage.Loc = categorical(repelem("K",length(K_RMSE_seasonstage.t2m))');

PK_RMSE_seasonstage =  [P_RMSE_seasonstage; K_RMSE_seasonstage];
PK_RMSE_seasonstage.Stage = categorical(PK_RMSE_seasonstage.Stage);
PK_RMSE_seasonstage.Loc = categorical(PK_RMSE_seasonstage.Loc);
PK_RMSE_seasonstage.Season = categorical(PK_RMSE_seasonstage.Season);

%% clean up

clear K_RMSE_stage K_RMSE_seasonstage K_RMSE_seasonal K_RMSE_all
clear P_RMSE_stage P_RMSE_seasonstage P_RMSE_seasonal P_RMSE_all





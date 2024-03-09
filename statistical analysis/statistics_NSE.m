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
% For the statistical analysis we will calculate stat. parameteres (NSE,
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

%% 1.1 Statistics NSE, whole time series

p_nse_all = zeros([1,5]);

p_nse_all(1) = nse(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
p_nse_all(2) = nse(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.t2mminStation);
p_nse_all(3) = nse(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.t2mmaxStation);
p_nse_all(4) = nse(Potsdam_31y_dog.tpERA,Potsdam_31y_dog.tpStation);
p_nse_all(5) = nse(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

k_nse_all = zeros([1,5]);

k_nse_all(1) = nse(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
k_nse_all(2) = nse(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.t2mminStation);
k_nse_all(3) = nse(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.t2mmaxStation);
k_nse_all(4) = nse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season~="2003"));
k_nse_all(5) = nse(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

%% 1.2 Statistics NSE, for each season

p_nse_seasonal = zeros([31,5]);

for i = 1991:2021
    p_nse_seasonal(i-1990,1) = nse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season==categorical(i)));
    p_nse_seasonal(i-1990,2) = nse(Potsdam_31y_dog.t2mminERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mminStation(Potsdam_31y_dog.Season==categorical(i)));
    p_nse_seasonal(i-1990,3) = nse(Potsdam_31y_dog.t2mmaxERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mmaxStation(Potsdam_31y_dog.Season==categorical(i)));
    p_nse_seasonal(i-1990,4) = nse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Season==categorical(i)));
    p_nse_seasonal(i-1990,5) = nse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Season==categorical(i)));
end

k_nse_seasonal = zeros([31,5]);

for i = 1991:2021
    k_nse_seasonal(i-1990,1) = nse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season==categorical(i)));
    k_nse_seasonal(i-1990,2) = nse(Kimberley_31y_dog.t2mminERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mminStation(Kimberley_31y_dog.Season==categorical(i)));
    k_nse_seasonal(i-1990,3) = nse(Kimberley_31y_dog.t2mmaxERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mmaxStation(Kimberley_31y_dog.Season==categorical(i)));
    k_nse_seasonal(i-1990,4) = nse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season==categorical(i)));
    k_nse_seasonal(i-1990,5) = nse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Season==categorical(i)));
end

%% 1.3 Statistics NSE, for each stage of the growing cyle (not used) (not adapted for Tmin & Tmax)

% p_nse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     p_nse_stage(i,1) = nse(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_nse_stage(i,2) = nse(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_nse_stage(i,3) = nse(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Stage==stages(i)));
% end
% 
% k_nse_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     k_nse_stage(i,1) = nse(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_nse_stage(i,2) = nse(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_nse_stage(i,3) = nse(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Stage==stages(i)));
% end

%% 1.4 Statistics NSE, yearly for each stage of the growing cyle

p_nse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Potsdam_31y_dog(Potsdam_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            p_nse_seasonstage(start+y-1991,1) = nse(subseason.t2mERA,subseason.t2mStation);
            p_nse_seasonstage(start+y-1991,2) = nse(subseason.t2mminERA,subseason.t2mminStation);
            p_nse_seasonstage(start+y-1991,3) = nse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            p_nse_seasonstage(start+y-1991,4) = nse(subseason.tpERA,subseason.tpStation);
            p_nse_seasonstage(start+y-1991,5) = nse(subseason.et0ERA,subseason.et0Station);
            
        end

end

k_nse_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Kimberley_31y_dog(Kimberley_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            k_nse_seasonstage(start+y-1991,1) = nse(subseason.t2mERA,subseason.t2mStation);
            k_nse_seasonstage(start+y-1991,2) = nse(subseason.t2mminERA,subseason.t2mminStation);
            k_nse_seasonstage(start+y-1991,3) = nse(subseason.t2mmaxERA,subseason.t2mmaxStation);
            k_nse_seasonstage(start+y-1991,4) = nse(subseason.tpERA,subseason.tpStation);
            k_nse_seasonstage(start+y-1991,5) = nse(subseason.et0ERA,subseason.et0Station);
            
        end

end
%% combine results in tables 

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

P_NSE_all = table(p_nse_all(:,1),p_nse_all(:,2),p_nse_all(:,3),p_nse_all(:,4),p_nse_all(:,5));
P_NSE_all.Properties.VariableNames = varnames;
P_NSE_all.Season = "all";
P_NSE_all.Stage = "all";

P_NSE_seasonal = table(p_nse_seasonal(:,1),p_nse_seasonal(:,2),p_nse_seasonal(:,3),p_nse_seasonal(:,4),p_nse_seasonal(:,5));
P_NSE_seasonal.Properties.VariableNames = varnames;
P_NSE_seasonal.Season = [1991:2021]';
P_NSE_seasonal.Stage = repelem(["all"],31)';

% P_NSE_stage = table(p_nse_stage(:,1),p_nse_stage(:,2),p_nse_stage(:,3));
% P_NSE_stage.Properties.VariableNames = varnames;
% P_NSE_stage.Season = repelem(["all"],3)';
% P_NSE_stage.Stage = stages';

P_NSE_seasonstage = table(p_nse_seasonstage(:,1),p_nse_seasonstage(:,2),p_nse_seasonstage(:,3),p_nse_seasonstage(:,4),p_nse_seasonstage(:,5));
P_NSE_seasonstage.Properties.VariableNames = varnames;
P_NSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    P_NSE_seasonstage.Season(P_NSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

K_NSE_all = table(k_nse_all(:,1),k_nse_all(:,2),k_nse_all(:,3),k_nse_all(:,4),k_nse_all(:,5));
K_NSE_all.Properties.VariableNames = varnames;
K_NSE_all.Season = "all";
K_NSE_all.Stage = "all";

K_NSE_seasonal = table(k_nse_seasonal(:,1),k_nse_seasonal(:,2),k_nse_seasonal(:,3),k_nse_seasonal(:,4),k_nse_seasonal(:,5));
K_NSE_seasonal.Properties.VariableNames = varnames;
K_NSE_seasonal.Season = [1991:2021]';
K_NSE_seasonal.Stage = repelem(["all"],31)';

% K_NSE_stage = table(k_nse_stage(:,1),k_nse_stage(:,2),k_nse_stage(:,3));
% K_NSE_stage.Properties.VariableNames = varnames;
% K_NSE_stage.Season = repelem(["all"],3)';
% K_NSE_stage.Stage = stages';

K_NSE_seasonstage = table(k_nse_seasonstage(:,1),k_nse_seasonstage(:,2),k_nse_seasonstage(:,3),k_nse_seasonstage(:,4),k_nse_seasonstage(:,5));
K_NSE_seasonstage.Properties.VariableNames = varnames;
K_NSE_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    K_NSE_seasonstage.Season(K_NSE_seasonstage.Stage==stages(s)) = 1991:2021;
end

%% clean up 

clear i stages varnames p_nse_seasonstage p_nse_stage p_nse_seasonal p_nse_all subseason start substage y s K_NaN
clear k_nse_seasonstage k_nse_stage k_nse_seasonal k_nse_all

%% combine both stat tables with unique location variable for grouping

P_NSE_all.Loc = categorical(repelem("P",1)');
K_NSE_all.Loc = categorical(repelem("K",1)');

PK_NSE_all =  [P_NSE_all; K_NSE_all];
PK_NSE_all.Stage = categorical(PK_NSE_all.Stage);
PK_NSE_all.Loc = categorical(PK_NSE_all.Loc);
PK_NSE_all.Season = categorical(PK_NSE_all.Season);

P_NSE_seasonal.Loc = categorical(repelem("P",length(P_NSE_seasonal.t2m))');
K_NSE_seasonal.Loc = categorical(repelem("K",length(K_NSE_seasonal.t2m))');

PK_NSE_seasonal =  [P_NSE_seasonal; K_NSE_seasonal];
PK_NSE_seasonal.Stage = categorical(PK_NSE_seasonal.Stage);
PK_NSE_seasonal.Loc = categorical(PK_NSE_seasonal.Loc);
PK_NSE_seasonal.Season = categorical(PK_NSE_seasonal.Season);

P_NSE_seasonstage.Loc = categorical(repelem("P",length(P_NSE_seasonstage.t2m))');
K_NSE_seasonstage.Loc = categorical(repelem("K",length(K_NSE_seasonstage.t2m))');

PK_NSE_seasonstage =  [P_NSE_seasonstage; K_NSE_seasonstage];
PK_NSE_seasonstage.Stage = categorical(PK_NSE_seasonstage.Stage);
PK_NSE_seasonstage.Loc = categorical(PK_NSE_seasonstage.Loc);
PK_NSE_seasonstage.Season = categorical(PK_NSE_seasonstage.Season);

%% clean up

clear K_NSE_stage K_NSE_seasonstage K_NSE_seasonal K_NSE_all K_NaN_v2
clear P_NSE_stage P_NSE_seasonstage P_NSE_seasonal P_NSE_all


%% 


function out = nse(sim,obs)

    if length(obs) ~= length(sim)
        error('Input vectors must have the same length');
    end

    num = sum((obs-sim).^2);
    denom = sum((obs-mean(obs)).^2);

    out = 1 - (num/denom);

end




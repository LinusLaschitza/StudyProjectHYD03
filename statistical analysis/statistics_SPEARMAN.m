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
% For the statistical analysis we will calculate stat. parameteres (SPEAR,
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

%% 1.1 Statistics SPEAR, whole time series

p_corrSPEAR_all = zeros([1,5]);

p_corrSPEAR_all(1) = corrSPEAR(Potsdam_31y_dog.t2mERA,Potsdam_31y_dog.t2mStation);
p_corrSPEAR_all(2) = corrSPEAR(Potsdam_31y_dog.t2mminERA,Potsdam_31y_dog.t2mminStation);
p_corrSPEAR_all(3) = corrSPEAR(Potsdam_31y_dog.t2mmaxERA,Potsdam_31y_dog.t2mmaxStation);
p_corrSPEAR_all(4) = corrSPEAR(Potsdam_31y_dog.tpERA,Potsdam_31y_dog.tpStation);
p_corrSPEAR_all(5) = corrSPEAR(Potsdam_31y_dog.et0ERA,Potsdam_31y_dog.et0Station);

k_corrSPEAR_all = zeros([1,5]);

k_corrSPEAR_all(1) = corrSPEAR(Kimberley_31y_dog.t2mERA,Kimberley_31y_dog.t2mStation);
k_corrSPEAR_all(2) = corrSPEAR(Kimberley_31y_dog.t2mminERA,Kimberley_31y_dog.t2mminStation);
k_corrSPEAR_all(3) = corrSPEAR(Kimberley_31y_dog.t2mmaxERA,Kimberley_31y_dog.t2mmaxStation);
k_corrSPEAR_all(4) = corrSPEAR(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season~="2003"),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season~="2003"));
k_corrSPEAR_all(5) = corrSPEAR(Kimberley_31y_dog.et0ERA,Kimberley_31y_dog.et0Station);

%% 1.2 Statistics SPEAR, for each season

p_corrSPEAR_seasonal = zeros([31,5]);

for i = 1991:2021
    p_corrSPEAR_seasonal(i-1990,1) = corrSPEAR(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Season==categorical(i)));
    p_corrSPEAR_seasonal(i-1990,2) = corrSPEAR(Potsdam_31y_dog.t2mminERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mminStation(Potsdam_31y_dog.Season==categorical(i)));
    p_corrSPEAR_seasonal(i-1990,3) = corrSPEAR(Potsdam_31y_dog.t2mmaxERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.t2mmaxStation(Potsdam_31y_dog.Season==categorical(i)));
    p_corrSPEAR_seasonal(i-1990,4) = corrSPEAR(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Season==categorical(i)));
    p_corrSPEAR_seasonal(i-1990,5) = corrSPEAR(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Season==categorical(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Season==categorical(i)));
end

k_corrSPEAR_seasonal = zeros([31,5]);

for i = 1991:2021
    k_corrSPEAR_seasonal(i-1990,1) = corrSPEAR(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Season==categorical(i)));
    k_corrSPEAR_seasonal(i-1990,2) = corrSPEAR(Kimberley_31y_dog.t2mminERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mminStation(Kimberley_31y_dog.Season==categorical(i)));
    k_corrSPEAR_seasonal(i-1990,3) = corrSPEAR(Kimberley_31y_dog.t2mmaxERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.t2mmaxStation(Kimberley_31y_dog.Season==categorical(i)));
    k_corrSPEAR_seasonal(i-1990,4) = corrSPEAR(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Season==categorical(i)));
    k_corrSPEAR_seasonal(i-1990,5) = corrSPEAR(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Season==categorical(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Season==categorical(i)));
end

%% 1.3 Statistics SPEAR, for each stage of the growing cyle (not used)

% p_corrSPEAR_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     p_corrSPEAR_stage(i,1) = corrSPEAR(Potsdam_31y_dog.t2mERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.t2mStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_corrSPEAR_stage(i,2) = corrSPEAR(Potsdam_31y_dog.tpERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.tpStation(Potsdam_31y_dog.Stage==stages(i)));
%     p_corrSPEAR_stage(i,3) = corrSPEAR(Potsdam_31y_dog.et0ERA(Potsdam_31y_dog.Stage==stages(i)),Potsdam_31y_dog.et0Station(Potsdam_31y_dog.Stage==stages(i)));
% end
% 
% k_corrSPEAR_stage = zeros([3,3]);
% 
% stages = ["VE-V8","V8-R1","R1-FM"];
% 
% for i = 1:numel(stages)
%     k_corrSPEAR_stage(i,1) = corrSPEAR(Kimberley_31y_dog.t2mERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.t2mStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_corrSPEAR_stage(i,2) = corrSPEAR(Kimberley_31y_dog.tpERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.tpStation(Kimberley_31y_dog.Stage==stages(i)));
%     k_corrSPEAR_stage(i,3) = corrSPEAR(Kimberley_31y_dog.et0ERA(Kimberley_31y_dog.Stage==stages(i)),Kimberley_31y_dog.et0Station(Kimberley_31y_dog.Stage==stages(i)));
% end

%% 1.4 Statistics SPEAR, yearly for each stage of the growing cyle

p_corrSPEAR_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Potsdam_31y_dog(Potsdam_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            p_corrSPEAR_seasonstage(start+y-1991,1) = corrSPEAR(subseason.t2mERA,subseason.t2mStation);
            p_corrSPEAR_seasonstage(start+y-1991,2) = corrSPEAR(subseason.t2mminERA,subseason.t2mminStation);
            p_corrSPEAR_seasonstage(start+y-1991,3) = corrSPEAR(subseason.t2mmaxERA,subseason.t2mmaxStation);
            p_corrSPEAR_seasonstage(start+y-1991,4) = corrSPEAR(subseason.tpERA,subseason.tpStation);
            p_corrSPEAR_seasonstage(start+y-1991,5) = corrSPEAR(subseason.et0ERA,subseason.et0Station);
            
        end

end

k_corrSPEAR_seasonstage = zeros([31.*3,5]);

stages = ["VE-V8","V8-R1","R1-FM"];

for s = 1:numel(stages)
    
    substage = Kimberley_31y_dog(Kimberley_31y_dog.Stage==stages(s),:);

        for y = 1991:2021

            start = 1+(s-1).*31;
            subseason = substage(substage.Season==categorical(y),:);

            k_corrSPEAR_seasonstage(start+y-1991,1) = corrSPEAR(subseason.t2mERA,subseason.t2mStation);
            k_corrSPEAR_seasonstage(start+y-1991,2) = corrSPEAR(subseason.t2mminERA,subseason.t2mminStation);
            k_corrSPEAR_seasonstage(start+y-1991,3) = corrSPEAR(subseason.t2mmaxERA,subseason.t2mmaxStation);
            k_corrSPEAR_seasonstage(start+y-1991,4) = corrSPEAR(subseason.tpERA,subseason.tpStation);
            k_corrSPEAR_seasonstage(start+y-1991,5) = corrSPEAR(subseason.et0ERA,subseason.et0Station);
            
        end

end
%% combine results in tables 

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

P_SPEAR_all = table(p_corrSPEAR_all(:,1),p_corrSPEAR_all(:,2),p_corrSPEAR_all(:,3),p_corrSPEAR_all(:,4),p_corrSPEAR_all(:,5));
P_SPEAR_all.Properties.VariableNames = varnames;
P_SPEAR_all.Season = "all";
P_SPEAR_all.Stage = "all";

P_SPEAR_seasonal = table(p_corrSPEAR_seasonal(:,1),p_corrSPEAR_seasonal(:,2),p_corrSPEAR_seasonal(:,3),p_corrSPEAR_seasonal(:,4),p_corrSPEAR_seasonal(:,5));
P_SPEAR_seasonal.Properties.VariableNames = varnames;
P_SPEAR_seasonal.Season = [1991:2021]';
P_SPEAR_seasonal.Stage = repelem(["all"],31)';

% P_SPEAR_stage = table(p_corrSPEAR_stage(:,1),p_corrSPEAR_stage(:,2),p_corrSPEAR_stage(:,3));
% P_SPEAR_stage.Properties.VariableNames = varnames;
% P_SPEAR_stage.Season = repelem(["all"],3)';
% P_SPEAR_stage.Stage = stages';

P_SPEAR_seasonstage = table(p_corrSPEAR_seasonstage(:,1),p_corrSPEAR_seasonstage(:,2),p_corrSPEAR_seasonstage(:,3),p_corrSPEAR_seasonstage(:,4),p_corrSPEAR_seasonstage(:,5));
P_SPEAR_seasonstage.Properties.VariableNames = varnames;
P_SPEAR_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    P_SPEAR_seasonstage.Season(P_SPEAR_seasonstage.Stage==stages(s)) = 1991:2021;
end

varnames = ["t2m","t2mmin","t2mmax","tp","et0"];
stages = ["VE-V8","V8-R1","R1-FM"];

K_SPEAR_all = table(k_corrSPEAR_all(:,1),k_corrSPEAR_all(:,2),k_corrSPEAR_all(:,3),k_corrSPEAR_all(:,4),k_corrSPEAR_all(:,5));
K_SPEAR_all.Properties.VariableNames = varnames;
K_SPEAR_all.Season = "all";
K_SPEAR_all.Stage = "all";

K_SPEAR_seasonal = table(k_corrSPEAR_seasonal(:,1),k_corrSPEAR_seasonal(:,2),k_corrSPEAR_seasonal(:,3),k_corrSPEAR_seasonal(:,4),k_corrSPEAR_seasonal(:,5));
K_SPEAR_seasonal.Properties.VariableNames = varnames;
K_SPEAR_seasonal.Season = [1991:2021]';
K_SPEAR_seasonal.Stage = repelem(["all"],31)';

% K_SPEAR_stage = table(k_corrSPEAR_stage(:,1),k_corrSPEAR_stage(:,2),k_corrSPEAR_stage(:,3));
% K_SPEAR_stage.Properties.VariableNames = varnames;
% K_SPEAR_stage.Season = repelem(["all"],3)';
% K_SPEAR_stage.Stage = stages';

K_SPEAR_seasonstage = table(k_corrSPEAR_seasonstage(:,1),k_corrSPEAR_seasonstage(:,2),k_corrSPEAR_seasonstage(:,3),k_corrSPEAR_seasonstage(:,4),k_corrSPEAR_seasonstage(:,5));
K_SPEAR_seasonstage.Properties.VariableNames = varnames;
K_SPEAR_seasonstage.Stage = repelem(stages,31)';
for s = 1:numel(stages)
    K_SPEAR_seasonstage.Season(K_SPEAR_seasonstage.Stage==stages(s)) = 1991:2021;
end

%% clean up 

clear i stages varnames p_corrSPEAR_seasonstage p_corrSPEAR_stage p_corrSPEAR_seasonal p_corrSPEAR_all subseason start substage y s K_NaN
clear k_corrSPEAR_seasonstage k_corrSPEAR_stage k_corrSPEAR_seasonal k_corrSPEAR_all

%% combine both stat tables with unique location variable for grouping

P_SPEAR_all.Loc = categorical(repelem("P",1)');
K_SPEAR_all.Loc = categorical(repelem("K",1)');

PK_SPEAR_all =  [P_SPEAR_all; K_SPEAR_all];
PK_SPEAR_all.Stage = categorical(PK_SPEAR_all.Stage);
PK_SPEAR_all.Loc = categorical(PK_SPEAR_all.Loc);
PK_SPEAR_all.Season = categorical(PK_SPEAR_all.Season);

P_SPEAR_seasonal.Loc = categorical(repelem("P",length(P_SPEAR_seasonal.t2m))');
K_SPEAR_seasonal.Loc = categorical(repelem("K",length(K_SPEAR_seasonal.t2m))');

PK_SPEAR_seasonal =  [P_SPEAR_seasonal; K_SPEAR_seasonal];
PK_SPEAR_seasonal.Stage = categorical(PK_SPEAR_seasonal.Stage);
PK_SPEAR_seasonal.Loc = categorical(PK_SPEAR_seasonal.Loc);
PK_SPEAR_seasonal.Season = categorical(PK_SPEAR_seasonal.Season);

P_SPEAR_seasonstage.Loc = categorical(repelem("P",length(P_SPEAR_seasonstage.t2m))');
K_SPEAR_seasonstage.Loc = categorical(repelem("K",length(K_SPEAR_seasonstage.t2m))');

PK_SPEAR_seasonstage =  [P_SPEAR_seasonstage; K_SPEAR_seasonstage];
PK_SPEAR_seasonstage.Stage = categorical(PK_SPEAR_seasonstage.Stage);
PK_SPEAR_seasonstage.Loc = categorical(PK_SPEAR_seasonstage.Loc);
PK_SPEAR_seasonstage.Season = categorical(PK_SPEAR_seasonstage.Season);

%% clean up

clear K_SPEAR_stage K_SPEAR_seasonstage K_SPEAR_seasonal K_SPEAR_all
clear P_SPEAR_stage P_SPEAR_seasonstage P_SPEAR_seasonal P_SPEAR_all

%%

function a = corrSPEAR(x,y)
    a = corr(x,y,"type","Spearman");
end



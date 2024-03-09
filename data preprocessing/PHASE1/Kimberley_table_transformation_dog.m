%% goal is to transform the data input
% into a table with one colum growing season (= year when the growing
% period starts) and a column with the day of the growing period up t0 130
% days. Afterwards a growing stage (realized via "groupbins") will be
% assigned to each row depending on the day of the growing season.
%
% Later statistics (rmse...) can eventuall be formed for each stage of the
% growing cycle. Addidtionally the assignemnt of "days of growing period"
% and "season" makes our Potsdam and Kimberley datasets more comparable.

load("Kimberley_all_gs30years.mat")

Kimberley_all_30y.Season = categorical(Kimberley_all_30y.Season);

%%
% Kimberley_all_30y.Month = [];
% Kimberley_all_30y = renamevars(Kimberley_all_30y,"Year","Season");
Kimberley_all_30y.dog = zeros([length(Kimberley_all_30y.time)],1);
Kimberley_all_30y = movevars(Kimberley_all_30y,"dog","After","Season");

%%

for i = 1991:2021

    t1 = datetime(i,11,01);
    t2 = datetime(i+1,04,01);
    tr = timerange(t1,t2);

    % Kimberley_all_30y.Season(tr) = i;
    Kimberley_all_30y.dog(tr) = [1:length(Kimberley_all_30y.dog(tr))]';

end

%% bin for growing stages
% here we selcted growth stages (simplification) based on the NSW Paper

% StageEdges = [0,7,20,30,45,60,70,110,130];
% StageNames = ["VE-V2","V2-V5","V5-V8","V8-V12","V12-V16","V16-R1","R1-R5","R5-FM"];

StageEdges = [0,30,70,131,160];
StageNames = ["VE-V8","V8-R1","R1-FM","130+"];

Kimberley_all_30y.Stage = discretize(Kimberley_all_30y.dog,StageEdges,"categorical",StageNames);

Kimberley_all_30y = movevars(Kimberley_all_30y,"Stage","After","dog");

%% remove dog larger than 130 
% to compare both locations we limit the growing season to 130 days

Kimberley_all_30y(Kimberley_all_30y.dog>150,:) = [];

%% insert ET0 
% timrange already adapted to 4030 rows
load("20240108_Kimberley_station_30years_NaN_clean.mat");
Kimberley_station_30years_NaN = sortrows(Kimberley_station_30years_NaN,"DATE","ascend");
%%
Kimberley_all_30y.t2mStation = Kimberley_station_30years_NaN.TEMP;
Kimberley_all_30y.t2mminStation = Kimberley_station_30years_NaN.TMIN;
Kimberley_all_30y.t2mmaxStation = Kimberley_station_30years_NaN.TMAX;
Kimberley_all_30y.tpStation = Kimberley_station_30years_NaN.PRCP;
Kimberley_all_30y.et0Station = Kimberley_station_30years_NaN.ETZERO;
 
%% write results to a new variable and save 

Kimberley_31y_dog = Kimberley_all_30y;

save("Kimberley_31y_dog","Kimberley_31y_dog")

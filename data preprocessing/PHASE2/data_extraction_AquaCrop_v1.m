%% goal is to extract data from the "dog" tables
% to make it suitable for simulation runs in AquaCrop. Initially one season
% and one station. Afterwards extend to both stations and all documented
% seasons. 
%
% + change NaN to -999 for AquaCrop detection (only needed in Kimberley)

load("Potsdam_31y_dog.mat")
load("Kimberley_31y_dog.mat")

%% identify rows with missing data in Kimberley set
%  ...remove those rows
%  remove the same rows in the Potsdam dataset

% K_NaN = ismissing(Kimberley_31y_dog.tpStation);
% Kimberley_31y_dog(K_NaN,:) = [];
% Potsdam_31y_dog(K_NaN,:) = [];
% Kimberley_31y_dog.Season = categorical(Kimberley_31y_dog.Season);
% 
% K_NaN_v2 = ismissing(Kimberley_31y_dog.et0Station);
% Kimberley_31y_dog(K_NaN_v2,:) = [];
% Potsdam_31y_dog(K_NaN_v2,:) = [];

Potsdam_31y_dog.tpERA(Potsdam_31y_dog.tpERA<0) = 0; 
Kimberley_31y_dog.tpERA(Kimberley_31y_dog.tpERA<0) = 0; 

Kimberley_31y_dog.t2mStation(ismissing(Kimberley_31y_dog.t2mStation)) = Kimberley_31y_dog.t2mERA(ismissing(Kimberley_31y_dog.t2mStation));
Kimberley_31y_dog.t2mminStation(ismissing(Kimberley_31y_dog.t2mminStation)) = Kimberley_31y_dog.t2mminERA(ismissing(Kimberley_31y_dog.t2mminStation));
Kimberley_31y_dog.t2mmaxStation(ismissing(Kimberley_31y_dog.t2mmaxStation)) = Kimberley_31y_dog.t2mmaxERA(ismissing(Kimberley_31y_dog.t2mmaxStation));
Kimberley_31y_dog.tpStation(ismissing(Kimberley_31y_dog.tpStation)) = Kimberley_31y_dog.tpERA(ismissing(Kimberley_31y_dog.tpStation));
Kimberley_31y_dog.et0Station(ismissing(Kimberley_31y_dog.et0Station)) = Kimberley_31y_dog.et0ERA(ismissing(Kimberley_31y_dog.et0Station));

%% Potsdam, continuous 31 years

t0P = datetime(1991,05,01);
t1P = datetime(2021,09,27);

tallP = timetable([t0P:t1P]');

P_all = synchronize(tallP,Potsdam_31y_dog);

P_all.t2mERA(ismissing(P_all.t2mERA)) = 0;
P_all.t2mminERA(ismissing(P_all.t2mminERA)) = 0;
P_all.t2mmaxERA(ismissing(P_all.t2mmaxERA)) = 0;
P_all.tpERA(ismissing(P_all.tpERA)) = 0;
P_all.et0ERA(ismissing(P_all.et0ERA)) = 0;

P_all.t2mStation(ismissing(P_all.t2mStation)) = 0;
P_all.t2mminStation(ismissing(P_all.t2mminStation)) = 0;
P_all.t2mmaxStation(ismissing(P_all.t2mmaxStation)) = 0;
P_all.tpStation(ismissing(P_all.tpStation)) = 0;
P_all.et0Station(ismissing(P_all.et0Station)) = 0;

P_31y_ERA = table(P_all.t2mERA,P_all.t2mminERA,P_all.t2mmaxERA,P_all.tpERA,P_all.et0ERA);

P_31y_Station = table(P_all.t2mStation,P_all.t2mminStation,P_all.t2mmaxStation,P_all.tpStation,P_all.et0Station);

writetable(P_31y_ERA,"P_31y_ERA_v1.txt", ...
    "WriteVariableNames",false, ...
    "Delimiter","\t")

writetable(P_31y_Station,"P_31y_Station_v1.txt", ...
    "WriteVariableNames",false, ...
    "Delimiter","\t")

%% Kimberley, continuous 31 years

t0K = datetime(1991,11,01);
t1K = datetime(2022,03,30);

tallK = timetable([t0K:t1K]');

K_all = synchronize(tallK,Kimberley_31y_dog);

K_all.t2mERA(ismissing(K_all.t2mERA)) = 0;
K_all.t2mminERA(ismissing(K_all.t2mminERA)) = 0;
K_all.t2mmaxERA(ismissing(K_all.t2mmaxERA)) = 0;
K_all.tpERA(ismissing(K_all.tpERA)) = 0;
K_all.et0ERA(ismissing(K_all.et0ERA)) = 0;

K_all.t2mStation(ismissing(K_all.t2mStation)) = 0;
K_all.t2mminStation(ismissing(K_all.t2mminStation)) = 0;
K_all.t2mmaxStation(ismissing(K_all.t2mmaxStation)) = 0;
K_all.tpStation(ismissing(K_all.tpStation)) = 0;
K_all.et0Station(ismissing(K_all.et0Station)) = 0;

K_31y_ERA = table(K_all.t2mERA,K_all.t2mminERA,K_all.t2mmaxERA,K_all.tpERA,K_all.et0ERA);

K_31y_Station = table(K_all.t2mStation,K_all.t2mminStation,K_all.t2mmaxStation,K_all.tpStation,K_all.et0Station);

writetable(K_31y_ERA,"K_31y_ERA_v1.txt", ...
    "WriteVariableNames",false, ...
    "Delimiter","\t")

writetable(K_31y_Station,"K_31y_Station_v1.txt", ...
    "WriteVariableNames",false, ...
    "Delimiter","\t")

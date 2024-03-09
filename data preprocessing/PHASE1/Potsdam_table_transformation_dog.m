%% goal is to transform the data input
% into a table with one colum growing season (= year when the growing
% period starts) and a column with the day of the growing period up t0 130
% days. Afterwards a growing stage (realized via "groupbins") will be
% assigned to each row depending on the day of the growing season.
%
% Later statistics (rmse...) can eventuall be formed for each stage of the
% growing cycle. Addidtionally the assignemnt of "days of growing period"
% and "season" makes our Potsdam and Kimberley datasets more comparable.

load("Potsdam_all_gs30years.mat")

Potsdam_all_30y.Season = categorical(Potsdam_all_30y.Season);
summary(Potsdam_all_30y)
%%
% Potsdam_all_30y.Month = [];
% Potsdam_all_30y = renamevars(Potsdam_all_30y,"Year","Season");
Potsdam_all_30y.dog = zeros([length(Potsdam_all_30y.time)],1);
Potsdam_all_30y = movevars(Potsdam_all_30y,"dog","After","Season");

%% 

for i = categorical(1991:2021)

    Potsdam_all_30y.dog(Potsdam_all_30y.Season==i,:) = [1:length(Potsdam_all_30y.dog(Potsdam_all_30y.Season==i))]';

end

%% bin for growing stages
% here we selcted growth stages (simplification) based on the NSW Paper

% StageEdges = [0,7,20,30,45,60,70,110,130];
% StageNames = ["VE-V2","V2-V5","V5-V8","V8-V12","V12-V16","V16-R1","R1-R5","R5-FM"];

StageEdges = [0,30,70,131,160];
StageNames = ["VE-V8","V8-R1","R1-FM","130+"];

Potsdam_all_30y.Stage = discretize(Potsdam_all_30y.dog,StageEdges,"categorical",StageNames);

Potsdam_all_30y = movevars(Potsdam_all_30y,"Stage","After","dog");

%% remove dog larger than 130 
% to compare both locations we limit the growing season to 130 days

Potsdam_all_30y(Potsdam_all_30y.dog>150,:) = [];

%% write results to a new variable and save 

Potsdam_31y_dog = Potsdam_all_30y;

save("Potsdam_31y_dog","Potsdam_31y_dog")

%% import

et0_map = "daily_pet_v2.nc";
ncdisp(et0_map)

et0_map21 = "2021_daily_pet.nc";
ncdisp(et0_map21)

et0_map22 = "2022_daily_pet.nc";
ncdisp(et0_map22)

%% time horizon

t = ncread(et0_map,"time");
t0 = datetime(1981,01,01);
t = t0 + days(t);

t21 = ncread(et0_map21,"time");
t0_21 = datetime(2021,01,01);
t21 = t0_21 + days(t21);

t22 = ncread(et0_map22,"time");
t0_22 = datetime(2022,01,01);
t22 = t0_22 + days(t22);

%% location selection

lon=ncread(et0_map,'longitude');
lat=ncread(et0_map,'latitude'); 

lon21=ncread(et0_map21,'longitude');
lat21=ncread(et0_map21,'latitude'); 

%   station location is Lat. -28.803, Lon. 24.765
%   nearest is Lat. -28.8, Lon 24.8

want_lon = find(abs(lon-24.8) < 0.001);
want_lat = find(abs(lat-(-28.8)) < 0.001);

%% reading et0

et0ERA = ncread(et0_map,"pet",[want_lon,want_lat,1],[1,1,length(t)]);
et0ERA = et0ERA(:);

et0ERA21 = ncread(et0_map21,"pet",[want_lon,want_lat,1],[1,1,length(t21)]);
et0ERA21 = et0ERA21(:);

et0ERA22 = ncread(et0_map22,"pet",[want_lon,want_lat,1],[1,1,length(t22)]);
et0ERA22 = et0ERA22(:);

%% timetable creation 

dailytotal_et0_ERA = timetable(t,et0ERA);
dailytotal_et0_ERA21 = timetable(t21,et0ERA21);
dailytotal_et0_ERA22 = timetable(t22,et0ERA22);

dailytotal_et0_ERA21.Properties.VariableNames = ["et0ERA"];
dailytotal_et0_ERA22.Properties.VariableNames = ["et0ERA"];


%% megre timetables into one 

dailytotal_et0_ERA = [dailytotal_et0_ERA;dailytotal_et0_ERA21;dailytotal_et0_ERA22];

%%
dailytotal_et0_ERA.Properties.Description = "19981 to 2021 from hpet map (Prof. Schütze); 2021&2022 downloaded by Linus; all Data is from Bristol...";
dailytotal_et0_ERA.Properties.VariableUnits = "mm/d";

summary(dailytotal_et0_ERA)

%% save final table 

save("Kimberley_et0_ERA5Land","dailytotal_et0_ERA")
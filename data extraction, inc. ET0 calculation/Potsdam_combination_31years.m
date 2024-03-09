%% timetable imports

load("Potsdam_t2m_ERA5Land_gs91to21.mat")
load("Potsdam_t2mmin_ERA5Land_gs91to21.mat")
load("Potsdam_t2mmax_ERA5Land_gs91to21.mat")
load("Potsdam_tp_ERA5Land_gs91to21.mat")
load("Potsdam_et0_ERA5Land_81to21.mat")

load("Potsdam_t2m_Station_91to23.mat")
load("Potsdam_t2mmin_Station_91to23.mat")
load("Potsdam_t2mmax_Station_91to23.mat")
load("Potsdam_tp_Station_91to23.mat")
load("Potsdam_et0_Station_91to23.mat")

%% extraction of gs from each timetable

t=1991:2021;

for y = t;

startgs = datetime(y,05,01)';
endgs = datetime(y,10,01)';
durgs = days(endgs-startgs);

tr = timerange(startgs,endgs);

if y>t(1)

    last_et0_ERA = dailytotal_et0_ERA_gs;
    dailytotal_et0_ERA_gs = dailytotal_et0_ERA(tr,:);
    dailytotal_et0_ERA_gs = [last_et0_ERA;dailytotal_et0_ERA_gs];

    last_t2m_mean_Station = dailymean_t2m_Station_gs;
    dailymean_t2m_Station_gs = dailymean_t2m_Station(tr,:);
    dailymean_t2m_Station_gs = [last_t2m_mean_Station;dailymean_t2m_Station_gs];

    last_t2m_min_Station = dailymin_t2m_Station_gs;
    dailymin_t2m_Station_gs = dailymin_t2m_Station(tr,:);
    dailymin_t2m_Station_gs = [last_t2m_min_Station;dailymin_t2m_Station_gs];

    last_t2m_max_Station = dailymax_t2m_Station_gs;
    dailymax_t2m_Station_gs = dailymax_t2m_Station(tr,:);
    dailymax_t2m_Station_gs = [last_t2m_max_Station;dailymax_t2m_Station_gs];

    last_tp_Station = dailytotal_tp_Station_gs;
    dailytotal_tp_Station_gs = dailytotal_tp_Station(tr,:);
    dailytotal_tp_Station_gs = [last_tp_Station;dailytotal_tp_Station_gs];

    last_et0_Station = dailytotal_et0_Station_gs;
    dailytotal_et0_Station_gs = dailytotal_et0_Station(tr,:);
    dailytotal_et0_Station_gs = [last_et0_Station;dailytotal_et0_Station_gs];

else

dailytotal_et0_ERA_gs = dailytotal_et0_ERA(tr,:);

dailymean_t2m_Station_gs = dailymean_t2m_Station(tr,:);
dailymin_t2m_Station_gs = dailymin_t2m_Station(tr,:);
dailymax_t2m_Station_gs = dailymax_t2m_Station(tr,:);

dailytotal_tp_Station_gs = dailytotal_tp_Station(tr,:);
dailytotal_et0_Station_gs = dailytotal_et0_Station(tr,:);

end

end

%% rename variables
dailymin_t2m_ERA.Properties.VariableNames = "t2mminERA";
dailymax_t2m_ERA.Properties.VariableNames = "t2mmaxERA";

%% 
Potsdam_all_30y = join(dailymean_t2m_ERA,[dailymin_t2m_ERA,dailymax_t2m_ERA,dailytotal_tp_ERA,dailytotal_et0_ERA_gs, ...
    dailymean_t2m_Station_gs,dailymin_t2m_Station_gs,dailymax_t2m_Station_gs,dailytotal_tp_Station_gs,dailytotal_et0_Station_gs]);

save("Potsdam_all_gs30years","Potsdam_all_30y")
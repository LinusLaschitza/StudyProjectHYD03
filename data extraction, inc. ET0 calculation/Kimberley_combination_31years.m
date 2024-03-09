
%% timetable imports, Kimberley station data later

load("Kimberley_t2m_ERA5Land_gs91to21.mat")
load("Kimberley_t2mmin_ERA5Land_gs91to21.mat")
load("Kimberley_t2mmax_ERA5Land_gs91to21.mat")
load("Kimberley_tp_ERA5Land_gs91to21.mat")
load("Kimberley_et0_ERA5Land_81to22.mat")

% load("Kimberley_station_30years_NaN.mat")

%% extraction of gs from each timetable

t=1991:2021;

for y = t;

startgs = datetime(y,11,01)';
endgs = datetime(y+1,04,01)';
durgs = days(endgs-startgs);

tr = timerange(startgs,endgs);

if y>t(1)

    last_et0_ERA = dailytotal_et0_ERA_gs;
    dailytotal_et0_ERA_gs = dailytotal_et0_ERA(tr,:);
    dailytotal_et0_ERA_gs = [last_et0_ERA;dailytotal_et0_ERA_gs];

else

dailytotal_et0_ERA_gs = dailytotal_et0_ERA(tr,:);

end

end

%% transform station to timetable

% v1_KS = timetable(Kimberley_station_30years_Interpolated.DATE,Kimberley_station_30years_Interpolated.TEMP,Kimberley_station_30years_NaN.PRCP);

%%
Kimberley_all_30y = join(dailymean_t2m_ERA,[dailymin_t2m_ERA,dailymax_t2m_ERA,dailytotal_tp_ERA,dailytotal_et0_ERA_gs]);
Kimberley_all_30y.Properties.VariableNames = ["t2mERA","t2mminERA","t2mmaxERA", "tpERA", "et0ERA"];

%%
Kimberley_all_30y.Year = year(Kimberley_all_30y.time);
Kimberley_all_30y.Month = month(Kimberley_all_30y.time);
%%
Kimberley_all_30y = movevars(Kimberley_all_30y,"Year","Before","t2mERA");
Kimberley_all_30y = movevars(Kimberley_all_30y,"Month","Before","t2mERA");
%%
save("Kimberley_all_gs30years","Kimberley_all_30y")
%%
t = [1991:2021];

t0 = datetime(1900,01,01);

startgs = datetime(2021,05,01);
endgs = datetime(2021,10,01);
durgs = hours(endgs-startgs);

for i = t
    ERA5Land = "PotsdamGrid_t2m_P_gs"+i+".nc";

    lon=ncread(ERA5Land,'longitude');
    lat=ncread(ERA5Land,'latitude');
    time=ncread(ERA5Land,'time',1,durgs+1);
    time = t0 + hours(time-1);

    want_lon = find(abs(lon-13.1) < 0.001);
    want_lat = find(abs(lat-52.4) < 0.001);

    tpERA = ncread(ERA5Land,"tp",[want_lon,want_lat,1],[1,1,durgs+1]);
    tpERA = tpERA(:);

    tpERA = tpERA.*1000;

    if i>t(1)
        last_table = dailytotal_tp_ERA;

        hourly_tp_ERA = timetable(time, tpERA);
        hourly_tp_ERA(1,:) = [];
        dailytotal_tp_ERA = retime(hourly_tp_ERA,"daily","max");

        dailytotal_tp_ERA = [last_table;dailytotal_tp_ERA];
    else

    hourly_tp_ERA = timetable(time, tpERA);
    hourly_tp_ERA(1,:) = [];
    dailytotal_tp_ERA = retime(hourly_tp_ERA,"daily","max");

    end

end

%%

save("Potsdam_tp_ERA5Land_gs91to21","dailytotal_tp_ERA")






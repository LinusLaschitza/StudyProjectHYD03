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
    time=ncread(ERA5Land,'time',1,durgs);
    time = t0 + hours(time);

    want_lon = find(abs(lon-13.1) < 0.001);
    want_lat = find(abs(lat-52.4) < 0.001);

    t2mERA = ncread(ERA5Land,"t2m",[want_lon,want_lat,1],[1,1,durgs]);
    t2mERA = t2mERA(:);

    t2mERA = t2mERA-273.15;

    if i>t(1)
        last_table_mean = dailymean_t2m_ERA;
        last_table_min = dailymin_t2m_ERA;
        last_table_max = dailymax_t2m_ERA;

        hourly_t2m_ERA = timetable(time, t2mERA);
        dailymean_t2m_ERA = retime(hourly_t2m_ERA,"daily","mean");
        dailymin_t2m_ERA = retime(hourly_t2m_ERA,"daily","min");
        dailymax_t2m_ERA = retime(hourly_t2m_ERA,"daily","max");

        dailymean_t2m_ERA = [last_table_mean;dailymean_t2m_ERA];
        dailymin_t2m_ERA = [last_table_min;dailymin_t2m_ERA];
        dailymax_t2m_ERA = [last_table_max;dailymax_t2m_ERA];

    else

    hourly_t2m_ERA = timetable(time, t2mERA);
    dailymean_t2m_ERA = retime(hourly_t2m_ERA,"daily","mean");
    dailymin_t2m_ERA = retime(hourly_t2m_ERA,"daily","min");
    dailymax_t2m_ERA = retime(hourly_t2m_ERA,"daily","max");

    end

end

%%

% save("Potsdam_t2m_ERA5Land_gs91to21","dailymean_t2m_ERA")
save("Potsdam_t2mmin_ERA5Land_gs91to21","dailymin_t2m_ERA")
save("Potsdam_t2mmax_ERA5Land_gs91to21","dailymax_t2m_ERA")






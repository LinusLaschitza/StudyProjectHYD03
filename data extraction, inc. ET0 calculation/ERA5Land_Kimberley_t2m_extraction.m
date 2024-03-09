%%

% ncdisp("KimbereleyGrid_t2m_P_gs1991.nc")
% z = ncread("KimbereleyGrid_t2m_P_gs1991.nc","time");
% z = t0 + hours(z);

%%
t = [1992:2022];

t0 = datetime(1900,01,01);

for i = 1992:2022

    startgs1 = datetime(i,01,01);
    endgs1 = datetime(i,04,01);
    durgs1 = hours(endgs1-startgs1);

    startgs2 = datetime(i,11,01);
    endgs2 = datetime(i+1,01,01);
    durgs2 = hours(endgs2-startgs2);

    startgsx = datetime(i,01,01);
    endgsx = datetime(i,05,01);
    durgsx = hours(endgsx-startgsx);

    ERA5Land = "KimbereleyGrid_t2m_P_gs"+i+".nc";

    lon=ncread(ERA5Land,'longitude');
    lat=ncread(ERA5Land,'latitude');
    time=ncread(ERA5Land,'time',1,durgs1);
    time = t0 + hours(time);

    want_lon = find(abs(lon-24.8) < 0.001);
    want_lat = find(abs(lat-(-28.8)) < 0.001);

    t2mERA = ncread(ERA5Land,"t2m",[want_lon,want_lat,1],[1,1,durgs1]);
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

%% rename

dailymin_t2m_ERA.Properties.VariableNames = "t2mminERA";
dailymax_t2m_ERA.Properties.VariableNames = "t2mmaxERA";


%%

save("Potsdam_t2m_ERA5Land_gs91to21_JanFebMar","dailymean_t2m_ERA")
save("Potsdam_t2mmin_ERA5Land_gs91to21_JanFebMar","dailymin_t2m_ERA")
save("Potsdam_t2mmax_ERA5Land_gs91to21_JanFebMar","dailymax_t2m_ERA")

%% merge sub-timetables

load("Potsdam_t2mmax_ERA5Land_gs91to21_NovDec.mat");
gs1 = dailymax_t2m_ERA;
load("Potsdam_t2mmax_ERA5Land_gs91to21_JanFebMar.mat");
gs2 = dailymax_t2m_ERA;
clear("dailymax_t2m_ERA")
 
 dailymax_t2m_ERA = [gs1;gs2];
 dailymax_t2m_ERA = sortrows(dailymax_t2m_ERA,"time","ascend");
 
 save("Kimberley_t2mmax_ERA5Land_gs91to21","dailymax_t2m_ERA")






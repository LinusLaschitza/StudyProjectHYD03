
ncdisp("KimbereleyGrid_t2m_P_gs1991.nc")
%%
t = [1992:2022];

t0 = datetime(1900,01,01);

for i = t

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
    time=ncread(ERA5Land,'time',1,durgs1+1);
    time = t0 + hours(time-1);

    want_lon = find(abs(lon-24.8) < 0.001);
    want_lat = find(abs(lat-(-28.8)) < 0.001);

    tpERA = ncread(ERA5Land,"tp",[want_lon,want_lat,1],[1,1,durgs1+1]);
    tpERA = tpERA(:);

    tpERA = tpERA.*1000;

    if i>t(1)
        last_table =  dailytotal_tp_ERA;

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

% save("Kimberley_tp_ERA5Land_gs91to21_JanFebMar","dailytotal_tp_ERA")

%% first value of each year to fill last december value

% t = [1992:2022];
% 
% t0 = datetime(1900,01,01);
% 
% for i = t
% 
%     startgs1 = datetime(i,01,01);
%     endgs1 = datetime(i,04,01);
%     durgs1 = hours(endgs1-startgs1);
% 
%     startgs2 = datetime(i,11,01);
%     endgs2 = datetime(i+1,01,01);
%     durgs2 = hours(endgs2-startgs2);
% 
%     startgsx = datetime(i,01,01);
%     endgsx = datetime(i,05,01);
%     durgsx = hours(endgsx-startgsx);
% 
%     ERA5Land = "KimbereleyGrid_t2m_P_gs"+i+".nc";
% 
%     lon=ncread(ERA5Land,'longitude');
%     lat=ncread(ERA5Land,'latitude');
%     time=ncread(ERA5Land,'time',1,1);
%     time = t0 + hours(time);
% 
%     want_lon = find(abs(lon-24.8) < 0.001);
%     want_lat = find(abs(lat-(-28.8)) < 0.001);
% 
%     tpERA = ncread(ERA5Land,"tp",[want_lon,want_lat,1],[1,1,1]);
%     tpERA = tpERA(:);
% 
%     tpERA = tpERA.*1000;
% 
%     if i>t(1)
%         last_table = hourly_tp_ERA;
% 
%         hourly_tp_ERA = timetable(time, tpERA);
%         % hourly_tp_ERA(1,:) = [];
%         % dailytotal_tp_ERA = retime(hourly_tp_ERA,"daily","max");
% 
%         hourly_tp_ERA = [last_table;hourly_tp_ERA];
%     else
% 
%     hourly_tp_ERA = timetable(time, tpERA);
%     % hourly_tp_ERA(1,:) = [];
%     % dailytotal_tp_ERA = retime(hourly_tp_ERA,"daily","max");
% 
%     end
% 
% end
% 
% save("hourly_tp_fill","hourly_tp_ERA")

%%
% load("hourly_tp_gs1.mat")
% gs1 = hourly_tp_ERA;
% load("hourly_tp_fill.mat");
% gsfill = hourly_tp_ERA;
% clear("hourly_tp_ERA")
% 
% hourly_tp_ERA = [gs1;gsfill];
% hourly_tp_ERA = sortrows(hourly_tp_ERA,"time","ascend");
% 
% hourly_tp_ERA.time = hourly_tp_ERA.time - hours(1);
% 
% dailytotal_tp_ERA = retime(hourly_tp_ERA,"daily","max");
% 
% save("Kimberley_tp_ERA5Land_gs91to21_NovDec","dailytotal_tp_ERA")

%%
load("Kimberley_tp_ERA5Land_gs91to21_NovDec.mat")
gs1 = dailytotal_tp_ERA;
gs1 = rmmissing(gs1);
load("Kimberley_tp_ERA5Land_gs91to21_JanFebMar.mat")
gs2 = dailytotal_tp_ERA;
clear("dailytotal_tp_ERA")

dailytotal_tp_ERA = [gs1;gs2];
dailytotal_tp_ERA = sortrows(dailytotal_tp_ERA,"time","ascend");

save("Kimberley_tp_ERA5Land_gs91to21","dailytotal_tp_ERA")

%% 
load("Kimberley_t2m_ERA5Land_gs91to21.mat")
load("Kimberley_tp_ERA5Land_gs91to21.mat")





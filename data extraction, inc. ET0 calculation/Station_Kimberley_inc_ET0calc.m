%% Import Kimberley station data
folderPath = 'C:\Users\Stefan\Nextcloud\Shared\Study Project HYD3\Stefan\Station_kimberley\';

% Display the folder path for verification
disp(['Folder Path: ' folderPath]);

% Get a list of all CSV files in the folder
fileList = dir(fullfile(folderPath, 'kimberley*.csv'));
% Display the list of files for verification
disp('List of CSV files:');
disp({fileList.name});
%%
% Loop through each file and process it
for i = 1:length(fileList)

%Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 28);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "DATE", "Var3", "Var4", "Var5", "Var6", "TEMP", "Var8", "TDEW", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "WDSP", "Var18", "Var19", "Var20", "TMAX", "Var22", "TMIN", "Var24", "PRCP", "Var26", "Var27", "Var28"];
opts.SelectedVariableNames = ["DATE", "TEMP", "TDEW", "WDSP", "TMAX", "TMIN", "PRCP"];
opts.VariableTypes = ["string", "datetime", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "double", "string", "string", "string", "double", "string", "double", "string", "double", "string", "string", "string"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var3", "Var4", "Var5", "Var6", "Var8", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var18", "Var19", "Var20", "Var22", "Var24", "Var26", "Var27", "Var28"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var3", "Var4", "Var5", "Var6", "Var8", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var18", "Var19", "Var20", "Var22", "Var24", "Var26", "Var27", "Var28"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");

% Import the data
kimberleydata = readtable(fullfile(fileList(i).folder,fileList(i).name), opts);


%% Clear temporary variables
clear opts
%% delete first row
kimberleydata(1,:) = [];
%% Add missing Dates
%Some dates were completely missing from the dataset
startDate = datetime(kimberleydata.DATE(1), 'InputFormat', 'dd-MMM-yyyy');
endDate = datetime(kimberleydata.DATE(end), 'InputFormat', 'dd-MMM-yyyy');  
existingDates = kimberleydata.DATE
%%
fullDateRange = startDate:endDate;
missingDates = setdiff(fullDateRange, existingDates)
%%
% Create a table with missing dates
missingData = table(missingDates', 'VariableNames', {'DATE'});

% Add NaN columns for other variables
missingData.TEMP = NaN(size(missingData, 1), 1);
missingData.TDEW = NaN(size(missingData, 1), 1);
missingData.WDSP = NaN(size(missingData, 1), 1);
missingData.PRCP = NaN(size(missingData, 1), 1);
missingData.TMIN = NaN(size(missingData, 1), 1);
missingData.TMAX = NaN(size(missingData, 1), 1);

% Concatenate the original table with the table containing missing dates and NaN values
newTable = [kimberleydata; missingData];

% Sort the new table by dates
newTable = sortrows(newTable, 'DATE');
newTable = sortrows(newTable, 'DATE');

%% back to the original
kimberleydata = newTable
%% Replace NaN
kimberleydata.PRCP(kimberleydata.PRCP == 99.9900) = NaN

%% Convert Precipitation amount from .01 inches into mm
kimberleydata.PRCP= kimberleydata.PRCP*25.4;
%% Convert Temperature from  fahrenheit into Celcius
kimberleydata.TEMP = (kimberleydata.TEMP -32) * (5/9);
kimberleydata.TDEW = (kimberleydata.TDEW -32) * (5/9);
kimberleydata.TMAX = (kimberleydata.TMAX -32) * (5/9);
kimberleydata.TMIN = (kimberleydata.TMIN -32) * (5/9);
%% Convert knots to m/s
kimberleydata.WDSP = (kimberleydata.WDSP*0.514444)*(4.87 / (log(67.8*10-5.42)));

%% Add Month and year number
kimberleydata.YEAR = year(kimberleydata.DATE)
kimberleydata.MONTH = month(kimberleydata.DATE)
%%

yearValue = year(kimberleydata.DATE(1))
yearText = num2str(yearValue)
dataname = 'kimberley'
completeName = [dataname    yearText]
assignin('base',completeName,kimberleydata)
end
%% Set up the Import Options and import the data for radiation data 
opts = delimitedTextImportOptions("NumVariables", 6);

opts.DataLines = [1, Inf];
opts.Delimiter = ",";

opts.VariableNames = ["VarName1", "Var2", "VarName3", "VarName4", "Var5", "Var6"];
opts.SelectedVariableNames = ["VarName1", "VarName3", "VarName4"];
opts.VariableTypes = ["double", "string", "double", "double", "string", "string"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

opts = setvaropts(opts, ["Var2", "Var5", "Var6"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var5", "Var6"], "EmptyFieldRule", "auto");

LARCPOWERDATA = readtable("C:\Users\Stefan\Nextcloud\Shared\Study Project HYD3\Stefan\LARC_POWER_DATA.csv", opts);



%% Adding Radiation data

for year = 1990:2022
    variableName = ['kimberley' num2str(year)]

    selectedRows = LARCPOWERDATA.VarName1 == year
    TestTable = LARCPOWERDATA(selectedRows, :)

    eval([variableName '.ALLSKY = TestTable.VarName3;'])
    eval([variableName '.CLRSKY = TestTable.VarName4;'])

end
%%
%% Create variables with G (Ground Heat Flux) DATA with the help of mean monthly Temp data.
%Creating mean monthly Temp Data
years = 1990:2022
for i = 1:numel(years)

    yearValueCurrent = years(i)
    yearTextCurrent = num2str(yearValueCurrent)
    CurrentVarName = ['kimberley' num2str(year)]
    CurrentVar = eval(CurrentVarName); 
    
    months = month(CurrentVar.DATE);  
    meanMonthlyTemp = accumarray(months, CurrentVar.TEMP, [], @mean)
    
    dataname = 'MeanMonthlyTemp'
    completeName = [dataname    yearTextCurrent]
    assignin('base',completeName,meanMonthlyTemp)

end
years = 1991:2022;

meanMonthlyTempTables = cell(1, numel(years));
monthlyTempTable = table();

%Create a table with monthly mean temps

for year = 1990:2022
    
    currentVarName = ['MeanMonthlyTemp' num2str(year)];
    
    currentVar = evalin('base', currentVarName); 
    
    currentTable = table(repmat(year, 12, 1), (1:12)', currentVar, ...
        'VariableNames', {'Year', 'Month', 'MeanTemperature'});
    
    monthlyTempTable = [monthlyTempTable; currentTable];
end


% Create G Data with mean montly Temp from previous and following month
% Calculate the temperature difference for (i+1) - (i-1)
temperatureDiff = diff(monthlyTempTable.MeanTemperature);

% Initialize the 'G' column with NaN values
monthlyTempTable.G = NaN(height(monthlyTempTable), 1);


monthlyTempTable.G(2:end-1) = 0.07 * (temperatureDiff(1:end-1) + temperatureDiff(2:end));


%Adding G Data to the kimberley variables
for year = 1990:2022
    yearStr = num2str(year);
    

    currentVarName = ['kimberley' yearStr];
    currentVar = eval(currentVarName); 
   
    GData = monthlyTempTable.G(monthlyTempTable.Year == year);
    currentVar.G = NaN(height(currentVar), 1);
    for month = 1:12
        currentVar.G(currentVar.MONTH == month) = GData(month);
    end
    
    assignin('base', currentVarName, currentVar);
end


%% PM with the help of new variables
newOrder = {'DATE', 'YEAR', 'MONTH', 'TEMP', 'TMAX', 'TMIN', 'PRCP', 'ETZERO', 'WDSP', 'TDEW', 'ALLSKY', 'CLRSKY', 'G' }
for year = 1990:2022

    currentVarName = ['kimberley' num2str(year)]
    currentVar = eval(currentVarName); 

    
    currentVar.ETZERO = zeros(size(currentVar, 1), 1); 
    RNS = (1 - 0.23).*currentVar.ALLSKY
    RSO = currentVar.CLRSKY
    TMEAN = ((currentVar.TMAX + currentVar.TMIN) ./2)
    EA = 0.6108 * exp((17.27 * currentVar.TDEW) ./ (currentVar.TDEW + 237.3));
    EMIN = 0.6108 * (exp((17.27 * currentVar.TMIN) ./ (currentVar.TMIN + 237.3)))
    EMAX = 0.6108 * (exp((17.27 * currentVar.TMAX) ./ (currentVar.TMAX + 237.3)))
    ES = 0.5*(EMIN+EMAX)
    DELTA = (4098 * (0.6108 * exp((17.27 * TMEAN) ./ (TMEAN + 237.3)))) ./ ((TMEAN + 237.3).^2);
    GAMMA = 0.0584
    RQ = min(currentVar.ALLSKY./RSO,1)
    RNL = 4.903*(10^(-9)).*((((currentVar.TMAX+273.16).^4 + (currentVar.TMIN+273.16).^4 ))./2).*(0.34-0.14.*sqrt(EA)).*(1.35.*(RQ)-0.35);
    RN = RNS - RNL


    currentVar.ETZERO = (0.408 * DELTA .* (RN - currentVar.G) + GAMMA * (900 ./ (TMEAN + 273)) .* currentVar.WDSP .* (ES - EA)) ./ (DELTA + GAMMA .* (1 + 0.34 .* currentVar.WDSP))
    currentVar = currentVar(:, newOrder)

assignin('base', currentVarName, currentVar);
    
end

%% Create Seasonal Variables
years = 1991:2022
AllSeasonsKimberley = table()
newOrder = {'DATE', 'YEAR', 'MONTH', 'NUMBER', 'SEASON', 'TEMP', 'TMAX', 'TMIN', 'TDEW', 'PRCP',  'WDSP', 'ETZERO'}
for i = 1:numel(years)

    start_date = datetime(years(i), 11, 1);
    end_date = start_date + days(149);
    date_range = start_date:end_date;

    seasonalYear1Name = ['kimberley' num2str(years(i))];
    seasonalYear1 = eval(seasonalYear1Name)
    seasonalYear2Name = ['kimberley' num2str(years(i+1))];
    seasonalYear2 = eval(seasonalYear2Name)

    indicesSeason1 = ismember(seasonalYear1.DATE, date_range)
    indicesSeason2 = ismember(seasonalYear2.DATE, date_range)

    yearValue1 = years(i)
    yearText1 = num2str(yearValue1)
    yearValue2 = years(i+1)
    yearText2 = num2str(yearValue2)

    seasonalData = [seasonalYear1(indicesSeason1,:); seasonalYear2(indicesSeason2,:)];
    seasonalData.NUMBER = (1:height(seasonalData))'
    seasonalData.SEASON = ones(height(seasonalData), 1) * years(i)
    seasonalData = seasonalData(:, newOrder)

    
    dataname = 'season'
    completeName = [dataname    yearText1]
    assignin('base',completeName,seasonalData)
    AllSeasonsKimberley = [AllSeasonsKimberley; seasonalData];
end
%% Rename and fit to Potsdam Data structure
Kimberley_station_30years_NaN = AllSeasonsKimberley
%%


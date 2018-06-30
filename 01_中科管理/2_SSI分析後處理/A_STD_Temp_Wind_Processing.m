clear all;clc;close all; work_ori = cd;


year = 2017;
ClassType = 15; 
STD_sensor = [26 54]; %%%%%  AB : 26,  CD : 54 ;
if rem(year,4) ~= 0;    day_e = [31 28 31 30 31 30 31 31 30 31 30 31];else;    day_e = [31 29 31 30 31 30 31 31 30 31 30 31]    ;end;
if ClassType == 15 ; numberOfDay = 96; denv = 4; else ; numberOfDay = 48; denv = 2 ; end

%%%%%%%%%%%% Part 1 : Loading All  Data (STD and Environment) %%%%%%%%%%%%%%%%%%%%
pathname = uigetdir(); open1 = 0; open2 = 0;
if pathname ~= 0
    cd(pathname);
    process_STD = dir([pathname '\*.mat']);
    process_Env = dir([pathname '\*.txt']);
    data_STD = struct2cell(process_STD); 
    data_Env = struct2cell(process_Env);  
    if size(data_STD,1) ~= 0;   open1 = 1;     STD_ = struct2cell(load(data_STD{1,1})); STD = STD_{1};   end    
    if size(data_Env,1) ~= 0;   open2 = 1;     Env = load(data_Env{1,1});    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
postr = findstr(pathname,'\');
month = str2num(pathname(postr(end)+1:postr(end)+2));
AllSTD = zeros(day_e(month)*numberOfDay,2);
ProcessSTDindex = zeros(size(STD,1),2);

cd(work_ori);
if open1 == 1
    dateIndex = STD(:,2);
    [ po ] = F_Trans_DateToNumber_ForMonth_General(year,ClassType,dateIndex);
    for i = 1 : size(STD,1)
        index_ = STD{i,1}; 
        index = index_(STD_sensor);
        ProcessSTDindex(i,:) = index; 
    end    
    AllSTD(po,:) = ProcessSTDindex;
end

EnvIndex = zeros(day_e(month)*numberOfDay,2);
if open2 == 1    
    dateIndex = Env;
    %%%%%% Wind interp %%%%%%%%%%%%%%%
    
    EnvIndex(1:denv:end,2) = Env(:,1);
    EnvIndex(1:denv:end,1) = Env(:,2); 
    no_po1 = find(EnvIndex(:,1) == 0);
    ok_po1 = find(EnvIndex(:,1));
    int_p1 = interp1(ok_po1,EnvIndex(ok_po1,1),no_po1,'linear');
    EnvIndex(no_po1,1) = int_p1 ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%% Temp interp %%%%%%%%%%%%%%%%%%
    no_po2 = find(EnvIndex(:,2) == 0);
    ok_po2 = find(EnvIndex(:,2));
    int_p2 = interp1(ok_po2,EnvIndex(ok_po2,2),no_po2,'linear');
    EnvIndex(no_po2,2) = int_p2 ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%% Wind Extrap %%%%%%%%%%%%%%%%%%
    nanpo1_ = isnan(EnvIndex(:,1));
    nanpo1 = find(nanpo1_ == 1);
    okpo1 = find(nanpo1_ == 0);
    ext_p1 = interp1(okpo1,EnvIndex(okpo1,1),nanpo1,'linear','extrap');
    EnvIndex(nanpo1,1) = ext_p1;   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%% Temp Extrap %%%%%%%%%%%%%%%%%%
    nanpo2_ = isnan(EnvIndex(:,2));
    nanpo2 = find(nanpo2_ == 1);
    okpo2 = find(nanpo2_ == 0);
    ext_p2 = interp1(okpo2,EnvIndex(okpo2,2),nanpo2,'linear','extrap');
    EnvIndex(nanpo2,2) = ext_p2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
end



postr = findstr(pathname,'\');
FolderName = [num2str(month,'%02d') '_FilterResult'];    
work_out = pathname(1:postr(end)-1);



if open1 == 1 & open2 == 1
   cd(work_out);   mkdir(FolderName);
   cd([work_out '\' FolderName]);
   STDTempWind = [EnvIndex AllSTD] ;
   save('STDTempWind','STDTempWind')
elseif open1 == 0 & open2 == 0    
    msgbox('No STD,Temp and Wind data')
elseif open1 == 0
    msgbox('No STD data')
elseif open2 == 0
    msgbox('No Temp and Wind data')    
    
end










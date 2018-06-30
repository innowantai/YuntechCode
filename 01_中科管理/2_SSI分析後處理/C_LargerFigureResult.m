clear all;clc;close all;
 
work_ori = cd;  
year = 2017;     
ClassType = 15;
 
pathname = uigetdir(); 
if pathname ~= 0    process = dir([pathname '\*.xlsx']);    alldata = struct2cell(process);      alldata = alldata(1,:); end;
postr = findstr(pathname,'\'); month = str2num(pathname(postr(end)+1:postr(end)+2)); 
cd(pathname) ;  Data = xlsread(alldata{1},'All_data'); cd(work_ori);

if ClassType == 15 ; numberOfDay = 96; denv = 4; else ; numberOfDay = 48; denv = 2 ; end

 

type_ = {'AB' 'CD'};

for i = 1 : 2
    type = type_{i};    
    C_PlotResultFigure_ABandCD_Case2_sub(year,month,type,Data,numberOfDay,pathname)

end



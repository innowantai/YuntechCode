clear all;clc;close all;

work_ori = cd;
Class = 2017;
  
 
pathname = uigetdir(); 
%%%%%%%%%%%% Loading All Three step filter result data %%%%%%%%%%%%%%%%%%%%
if pathname ~= 0
    process = dir([pathname '\*.mat']);
    alldata = struct2cell(process);  
    alldata = alldata(1,:);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
postr = findstr(pathname,'\');
month = str2num(pathname(postr(end)+1:postr(end)+2));


cd(pathname) 
AB =  struct2cell(load(alldata{1,1})); AB = AB{1}
CD =  struct2cell(load(alldata{1,2})); CD = CD{1}    
Env =  struct2cell(load(alldata{1,3})); Env = Env{1}  

s1 = size(AB,1);
s2 = size(CD,1);

AllData = zeros(max([ s1 s2]),18);
AllData(1:s1,1:10) = AB;
AllData(1:s2,11:18) = CD;
Data = [Env AllData];
xlsname = ['all_measurement_data_' num2str(month) '.xlsx'];
xlswrite(xlsname,Data,'All_data','A2')

cd(work_ori)






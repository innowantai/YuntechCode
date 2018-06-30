clear all;clc;close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%   Input : Eq-Excel file
%%%%%   Output : The Variable for 2016 or 2017 EqTime 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


year = 2016
[d1 d2 d3] = xlsread('¦a¾_¸ê®Æ.xlsx')






time = d3(:,2); kk = 0;
 %%%% 13 to 17
for ii = 13 : 17
    kk = kk + 1;
    posi = d3(:,ii);  
    [EqTime ] = EQProcessing_sub(time,posi,year)
    EQTime{kk} = EqTime;

end 
index = [];
for ii = 1 : 4
   Index = EQTime{ii};
   index_ = F_Trans_DateToNumber_AllYears_General(year,15,Index)
   index = [index ; index_];
end
Nindex = sort(index);
check = diff(Nindex);
Result = Nindex([find(check)+1]); 
if check(1) ~= 0
   Result = [Nindex(1) ; Result]; 
end
[RESULT ] = F_Trans_NumberToDate_AllYears_General(year,15,Result)

 
name = ['EqTime_' num2str(year) 'All'];
name2 = [name '=RESULT']; evalc(name2);
save(name,name)


% save('EqTime_2016All','EqTime_2016All')





